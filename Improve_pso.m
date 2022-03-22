clc;
clear;
node1 = struct('visit', 1, ...
    'smoking', 2, ...
    'tuberculosis', 3, ...
    'bronchitis', 5, ...
    'lung', 4, ...
    'ou', 6, ...
    'Xray', 7, ...
    'dyspnoea', 8);

%给出关系
adjacency = zeros(6);
adjacency([node1.visit], node1.tuberculosis) = 1;
adjacency([node1.smoking], node1.lung) = 1;
adjacency([node1.lung node1.tuberculosis], node1.ou) = 1;
% adjacency([node1.ou], node1.Xray) = 1;
adjacency([node1.smoking], node1.bronchitis) = 1;
% adjacency([node1.bronchitis node1.ou], node1.dyspnoea) = 1;
% 给条件概率
bnet = mk_bnet(adjacency, [2 2 2 2 2 2]);
bnet.CPD{node1.visit} = tabular_CPD(bnet, node1.visit, [0.5 0.5]);
bnet.CPD{node1.tuberculosis} = tabular_CPD(bnet, node1.tuberculosis, [0.05 0.01 0.95 0.99]);
bnet.CPD{node1.smoking} = tabular_CPD(bnet, node1.smoking, [0.5 0.5]);
bnet.CPD{node1.lung} = tabular_CPD(bnet, node1.lung, [0.1 0.01 0.9 0.99]);
bnet.CPD{node1.ou} = tabular_CPD(bnet, node1.ou, [0.9 0.1 0.9 0.2 0.1 0.9 0.1 0.8]);
% bnet.CPD{node1.Xray} = tabular_CPD(bnet, node1.Xray, [0.02 0.05 0.98 0.95]);
bnet.CPD{node1.bronchitis} = tabular_CPD(bnet, node1.bronchitis, [0.05 0.01 0.95 0.99]);
% bnet.CPD{node1.dyspnoea} = tabular_CPD(bnet, node1.dyspnoea, [0.1 0.9 0.2 0.9 0.9 0.1 0.8 0.1]);
figure(1);
title('初始ASIA网络');
% draw_graph(adjacency);
N = 6;
node_number = 6;
nsamples = 1000;% 采样的样本条数
samples = cell(N, nsamples);%为元素添加[]
for i = 1:nsamples
    samples(:,i) = sample_bnet(bnet);
end
r = samples;
data1 = cell2num(r);%得到样本
data = data1(:,1:50);
% load('K2_asia1000.mat');
Experiment_Matrix = zeros(3);
Experiment_Matrix = [0.9 0.05 0.05;0.9 0.05 0.05;0.05 0.05 0.9];
Jc = Compute_Jc(Experiment_Matrix);
% sum = zeros(1,27);
% for i = 1 : 50
%     
%     Nc_number = Compute_Nc(1000);
%     sum = sum + Nc_number;
%     
% end
% sum = sum/50;

for i = 1 :27
Nc(i) = 3781503/27;
end
All_gb_score = cell(1,50);
All_gb_score1 = cell(1,50);
All_Haming_Distance = cell(1,50);
All_Haming_Distance1 = cell(1,50);
for Experiment_Number = 1 : 20
    Experiment_Number
for i = 1 : 20                                                             %粒子初始化
    particle = rand(N,N) >= 0.5;
    particle = Pre_Treament(particle);
    dags1(i,1) = {particle};
%     dags2(i,1) = {particle};
%     dags4(i,1) = {particle};
    
    pbest1(i) = {particle};
%     pbest2(i) = {particle};
%     pbest4(i) = {particle}; 
%    if rand < 0.9
%     particle(2,4) = 1;
%    end
%    if rand < 0.9
%     particle(4,6) = 1;
%    end
%    if rand < 0.9
%    particle(2,6) = 0;
%    end

   dags(i,1) = {particle};
   pbest(i) = {particle};
    
end
% for i = 1 : 20
%     particle = I_randint(N);
%     
%     particle = Pre_Treament(particle);
%     dags3(i,1) = {particle};
%     pbest3(i) = {particle};
% end

iterative = 50;               %迭代次数
f_Type = 'bic';          %评分函数的类型‘bayesian’或'bic'
w = 0.8*blkdiag(1,1,1,1,1,1); %惯性权重
c1 = blkdiag(2,2,2,2,2,2);    %粒子跟踪自己历史最优值的权重系数
c2 = blkdiag(2,2,2,2,2,2);    %粒子跟踪群体最优值的权重系数
ns = [2 2 2 2 2 2];
%dagsmin=0;增加位置范围限制
%dagsmax=1;
velmin = -4;
velmax = 4;
vel = cell(20,100);
vel1 = cell(20,100);
vel3 = cell(20,100);
vel4 = cell(20,100);

% for i=1:20
%   vel{i,1}=dags{i,1}; %rand(8)%zeros(8)%dags{i,1}
% end
% for i=1:20
%      score = score_dags(data, ns, dags(i,1), 'scoring_fn', 'bic', 'params', []);
%      score = Improve_score_dags(data, ns, dags(i,1),Jc,Nc, 'scoring_fn', 'bic', 'params', []);
%      ff(i) = score;
% end
%   [maxscore,i_index]=max(ff);
%   gbest=dags{i_index,1};
for i=1:20
  vel{i,1} = dags{i,1}; %rand(8)%zeros(8)%dags{i,1}
  vel1{i,1} = dags1{i,1};
%   vel3{i,1} = dags3{i,1};
%   vel4{i,1} = dags4{i,1};
end
% for experiment_num = 1 : 20
%% *************************加入先验并改进评分函数************************************
% for i = 1:20
% %      score = score_dags(data, ns, dags(i,1), 'scoring_fn', 'bic', 'params', []);
%      score = Improve_score_dags(data, ns, dags(i,1),Jc,Nc, 'scoring_fn',f_Type, 'params', []);
%      ff(i) = score;
% end
% 
% [maxscore,i_index] = max(ff);
%  gbest = dags{i_index,1};
% for j=1:iterative    %进化代数 加入先验改变评分时的BPSO学习网络结构
%     for i=1:20
%       %dags(i,j+1)={w*dags{i,j}+c1*rand*(pbest{i}-dags{i,j})+c2*rand*(gbest-dags{i,j})};%只用粒子位置时
%       %C=dags{i,j+1};
%       vel{i,j+1}=w*vel{i,j}+c1*0.6*(pbest{i}-dags{i,j})+c2*0.8*(gbest-dags{i,j});%加入速度时的BPSO
%       C=vel{i,j+1};
%      for m=1:node_number
%           for n=1:node_number
%              if C(m,n)>velmax
%                  C(m,n)=velmax;
%              else if C(m,n)<velmin
%                      C(m,n)=velmin;
%                  end
%              end
%              if  sigmoid(C(m,n))>rand%取一个随机数rand在(0,1)之间0.6+0.04*rand()
%                   C(m,n)=1;
%              else C(m,n)=0;
%              end 
%           end
%      end 
%  %参考文献：Particle Swarm Optimisation for learning Bayesian Networks (J. Cowie, L. Oteniya, R. Coles) 
% % if rand < 0.9
% %     C(2,4) = 1;
% % end
% % if rand < 0.9
% %     C(4,6) = 1;
% % end
% % if rand < 0.9
% %     C(2,6) = 0;
% % end
%      C(1,3) = 1;C(3,6) = 1;
%      C = Pre_Treament(C);
% %以上是去环操作
% %      vel(i,j+1)={C};
%       dags(i,j+1)={C}; %代替标准PSO算法中dags(i,j+1)={dags{i,j}+vel{i,j+1}};
%     end
%        pbest = I_pb(dags,j+1,ns,data,Jc,Nc,0);
% %        pbest = pb(dags,j+1,ns,data);
%       [maxscore gbest] = I_gb_d(dags,j+1,ns,data,maxscore,gbest,Jc,Nc,0);
% %       [maxscore gbest] = gb_d(dags,j+1,ns,data,maxscore,gbest);
% %       [maxscore gbest] = gb_l(dags,j+1,ns,data,maxscore,gbest);
% %       gb_score(j) = maxscore;
%       gb_score(j) = score_dags(data1, ns, {gbest}, 'scoring_fn', f_Type, 'params', []);
%       Haming_Distance(j) = Comupute_Haming_Distance(gbest,adjacency);
%  %     gb_score_standard(j) = score_dags(data1, ns, {adjacency}, 'scoring_fn', f_Type, 'params', []);
% end
% %       Sum_gb_score(experiment_num) = {gb_score};
% %       Sum_Haming_Distance(experiment_num) = {Haming_Distance};
%% **************************经典BPSO算法***************************************************
for i = 1:20
     score = score_dags(data, ns, dags1(i,1), 'scoring_fn',f_Type, 'params', []);
      f1(i) = score;
end

[maxscore1,i_index] = max(f1);
gbest1 = dags1{i_index,1};


for j=1:iterative    %进化代数       不加入先验时直接应用BPSO学习结构
    j
    for i=1:20
      %dags(i,j+1)={w*dags{i,j}+c1*rand*(pbest{i}-dags{i,j})+c2*rand*(gbest-dags{i,j})};%只用粒子位置时
      %C=dags{i,j+1};
      vel1{i,j+1} = w*vel1{i,j}+c1*0.6*(pbest1{i}-dags1{i,j})+c2*0.8*(gbest1-dags1{i,j});%加入速度时的BPSO
      C = vel1{i,j+1};
     for m=1:node_number
          for n=1:node_number
             if C(m,n)>velmax
                 C(m,n)=velmax;
             else if C(m,n)<velmin
                     C(m,n)=velmin;
                 end
             end
             if  sigmoid(C(m,n))>rand%取一个随机数rand在(0,1)之间0.6+0.04*rand()
                  C(m,n)=1;
             else C(m,n)=0;
             end 
          end
     end 
 %参考文献：Particle Swarm Optimisation for learning Bayesian Networks (J. Cowie, L. Oteniya, R. Coles) 

     C = Pre_Treament(C);
%以上是去环操作
%      vel(i,j+1)={C};
      dags1(i,j+1)={C}; %代替标准PSO算法中dags(i,j+1)={dags{i,j}+vel{i,j+1}};
    end
  
       pbest1 = pb(dags1,j+1,ns,data);

      [maxscore1 gbest1] = gb_d(dags1,j+1,ns,data,maxscore1,gbest1);
%       [maxscore gbest] = gb_l(dags,j+1,ns,data,maxscore,gbest);
%       gb_score(j) = maxscore;
      gb_score1(j) = score_dags(data1, ns, {gbest1}, 'scoring_fn',f_Type, 'params', []);
      Haming_Distance1(j) = Comupute_Haming_Distance(gbest1,adjacency);
end
%       Sum_gb_score1(experiment_num) = {gb_score1};
%       Sum_Haming_Distance1(experiment_num) = {Haming_Distance1};
% end
%% **********************改进评分+进化机制******************************************************************
% for i = 1:20
%      score = score_dags(data, ns, dags2(i,1), 'scoring_fn',f_Type, 'params', []);
%      f2(i) = score;
% end
% 
% [maxscore2,i_index] = max(f2);
% gbest2 = dags2{i_index,1};
% for j = 1:iterative       %进化代数
%     for i = 1:20
% %       dags(i,j+1) = {w*dags{i,j}+r1*(pbest{i}-dags{i,j})+r2*(gbest-dags{i,j})};
%       dags2{i,j+1} = I_updata_particle(dags2{i,j},pbest2{i},gbest2);  
%       dags2{i,j+1} = Pre_Treament(dags2{i,j+1});
%     end
%  %************去除环结构********
%       
%       pbest1 = I_pb(dags2,j+1,ns,data,Jc,Nc,0);
%       [maxscore2 gbest2] = I_gb_d(dags2,j+1,ns,data,maxscore2,gbest2,Jc,Nc,0);
% %       gb_score2(j) = maxscore2;
%       gb_score2(j) = score_dags(data1, ns, {gbest2}, 'scoring_fn', f_Type, 'params', []);
%       Haming_Distance2(j) = Comupute_Haming_Distance(gbest2,adjacency);
% end

%% **********************初始化+改进评分**********************************************
% for i = 1:20
% %      score = score_dags(data, ns, dags3(i,1), 'scoring_fn',f_Type, 'params', []);
%      score = Improve_score_dags(data, ns, dags3(i,1),Jc,Nc, 'scoring_fn',f_Type, 'params', []);
%       f3(i) = score;
% end
% 
% [maxscore3,i_index] = max(f3);
% gbest3 = dags3{i_index,1};
% 
% 
% for j=1:iterative    %进化代数       
%     for i=1:20
%       %dags(i,j+1)={w*dags{i,j}+c1*rand*(pbest{i}-dags{i,j})+c2*rand*(gbest-dags{i,j})};%只用粒子位置时
%       %C=dags{i,j+1};
%       vel3{i,j+1} = w*vel3{i,j}+c1*0.6*(pbest3{i}-dags3{i,j})+c2*0.8*(gbest3-dags3{i,j});%加入速度时的BPSO
%       C = vel3{i,j+1};
%      for m = 1:node_number
%           for n = 1:node_number
%              if C(m,n)>velmax
%                  C(m,n)=velmax;
%              else if C(m,n)<velmin
%                      C(m,n)=velmin;
%                  end
%              end
%              if  sigmoid(C(m,n))>rand%取一个随机数rand在(0,1)之间0.6+0.04*rand()
%                   C(m,n)=1;
%              else C(m,n)=0;
%              end 
%           end
%      end 
%  %参考文献：Particle Swarm Optimisation for learning Bayesian Networks (J. Cowie, L. Oteniya, R. Coles)
%  if rand < 0.9
%     C(2,4) = 1;
% end
% if rand < 0.9
%     C(4,6) = 1;
% end
% if rand < 0.9
%     C(2,6) = 0;
% end
% C(2,5) = 1;
%      C = Pre_Treament(C);
% %以上是去环操作
% %      vel(i,j+1)={C};
%       dags3(i,j+1)={C}; %代替标准PSO算法中dags(i,j+1)={dags{i,j}+vel{i,j+1}};
%     end
%   
%        pbest3 = I_pb(dags3,j+1,ns,data,Jc,Nc,0);
% 
%       [maxscore3 gbest3] = I_gb_d(dags3,j+1,ns,data,maxscore3,gbest3,Jc,Nc,0);
% %       [maxscore gbest] = gb_l(dags,j+1,ns,data,maxscore,gbest);
% %       gb_score(j) = maxscore;
%       gb_score3(j) = score_dags(data1, ns, {gbest3}, 'scoring_fn', f_Type, 'params', []);
%       Haming_Distance3(j) = Comupute_Haming_Distance(gbest3,adjacency);
% end
%% ***********************将先验以分解的形式加入到评分中*******************************************
% for i = 1:20
%      score = score_dags(data, ns, dags4(i,1), 'scoring_fn', f_Type, 'params', []);
%      f4(i) = score;
% end
% 
% [maxscore4,i_index] = max(f4);
% gbest4 = dags4{i_index,1};
% 
% 
% for j=1:iterative    %进化代数       
%     for i=1:20
%       %dags(i,j+1)={w*dags{i,j}+c1*rand*(pbest{i}-dags{i,j})+c2*rand*(gbest-dags{i,j})};%只用粒子位置时
%       %C=dags{i,j+1};
%       vel4{i,j+1} = w*vel4{i,j}+c1*0.6*(pbest4{i}-dags4{i,j})+c2*0.8*(gbest4-dags4{i,j});%加入速度时的BPSO
%       C = vel4{i,j+1};
%      for m=1:node_number
%           for n=1:node_number
%              if C(m,n)>velmax
%                  C(m,n)=velmax;
%              else if C(m,n)<velmin
%                      C(m,n)=velmin;
%                  end
%              end
%              if  sigmoid(C(m,n))>rand%取一个随机数rand在(0,1)之间0.6+0.04*rand()
%                   C(m,n)=1;
%              else C(m,n)=0;
%              end 
%           end
%      end 
%  %参考文献：Particle Swarm Optimisation for learning Bayesian Networks (J. Cowie, L. Oteniya, R. Coles) 
%      C = Pre_Treament(C);
% %以上是去环操作
% %      vel(i,j+1)={C};
%       dags4(i,j+1)={C}; %代替标准PSO算法中dags(i,j+1)={dags{i,j}+vel{i,j+1}};
%     end
%   
%        pbest4 = I_pb(dags4,j+1,ns,data,Jc,Nc,1);
% 
%       [maxscore4 gbest4] = I_gb_d(dags4,j+1,ns,data,maxscore4,gbest4,Jc,Nc,1);
% %       [maxscore gbest] = gb_l(dags,j+1,ns,data,maxscore,gbest);
% %       gb_score(j) = maxscore;
%       gb_score4(j) = score_dags(data1, ns, {gbest4}, 'scoring_fn', 'bic', 'params', []);
%       Haming_Distance4(j) = Comupute_Haming_Distance(gbest4,adjacency);
% end













%% ************************************************************************************************
% gb_score = Mean_Score_Hanmin(Sum_gb_score,20,20);
% gb_score1 = Mean_Score_Hanmin(Sum_gb_score1,20,20);
% gb_score = resolve(gb_score);                                              %改进评分
% gb_score1 = resolve(gb_score1);                                            %经典BPSO
% gb_score2 = resolve(gb_score2);                                            %改进评分+进化机制
% gb_score3 = resolve(gb_score3);                                            %改进初始化+评分
% gb_score4 = resolve(gb_score4); 

% Haming_Distance = Mean_Score_Hanmin(Sum_Haming_Distance,20,20);
% Haming_Distance1 = Mean_Score_Hanmin(Sum_Haming_Distance1,20,20);
% Haming_Distance = resolve_1(Haming_Distance);
% Haming_Distance1 = resolve_1(Haming_Distance1);
% Haming_Distance2 = resolve_1(Haming_Distance2);
% Haming_Distance3 = resolve_1(Haming_Distance3);
% Haming_Distance4 = resolve_1(Haming_Distance4);
% p=pb(dags,2,ns,data)
% time = cputime - time1
% All_gb_score(Experiment_Number) = {gb_score};
% All_gb_score1(Experiment_Number) = {gb_score1};
% All_Haming_Distance(Experiment_Number) = {Haming_Distance};
All_Haming_Distance1(Experiment_Number) = {Haming_Distance1};
end

%     Mean_gb_score = Compute_Mean(All_gb_score, 50 , 50);
%     Mean_gb_score1 = Compute_Mean(All_gb_score1, 50 , 50);
%     Mean_Haming_Distance = Compute_Mean(All_Haming_Distance, 50 , 50);
    Mean_Haming_Distance1 = Compute_Mean(All_Haming_Distance1, 20 , 50);


% figure(1)
% plot(gb_score1,'r-*','LineWidth',2);
% hold on;
% plot(gb_score,'b-.','LineWidth',2);
% % hold on;
% % plot(gb_score_standard,'g-*','LineWidth',2);
% % hold on;
% % plot(gb_score2,'g-s','LineWidth',2);
% % hold on;
% % plot(gb_score3,'y-+','LineWidth',2);
% % hold on;
% % plot(gb_score4,'k->','LineWidth',2);
% xlabel('运行代数');                                                         
% ylabel('BD评分值');
% % legend('I-BD-BPSO','BPSO');
% legend('基于改进评分的BPSO','经典BPSO');

figure(2)
% plot(Haming_Distance,'r-o','LineWidth',2);
% hold on;
plot(Haming_Distance1,'b-*','LineWidth',2);
% hold on;
% plot(Haming_Distance2,'g-s','LineWidth',2);
% hold on;
% plot(Haming_Distance3,'y-+','LineWidth',2);
% hold on;
% plot(Haming_Distance4,'k->','LineWidth',2);
xlabel('运行代数');                                                         
ylabel('汉明距离');
legend('基于改进评分的BPSO','经典BPSO');


% figure(3)
% plot(Mean_gb_score,'r-o','LineWidth',2);
% hold on;
% plot(Mean_gb_score1,'b-*','LineWidth',2);
% % hold on;
% % plot(Haming_Distance2,'g-s','LineWidth',2);
% % hold on;
% % plot(Haming_Distance3,'y-+','LineWidth',2);
% % hold on;
% % plot(Haming_Distance4,'k->','LineWidth',2);
% xlabel('运行代数');                                                         
% ylabel('BD 评分');
% legend('基于改进评分的BPSO','经典BPSO');
% % legend('I-BD-BPSO','BPSO');
% % figure(3)
% % draw_graph(gbest);
% % figure(4)
% % draw_graph(gbest1);


figure(4)
% plot(Mean_Haming_Distance,'r-o','LineWidth',2);
% hold on;
plot(Mean_Haming_Distance1,'b-*','LineWidth',2);
% hold on;
% plot(Haming_Distance2,'g-s','LineWidth',2);
% hold on;
% plot(Haming_Distance3,'y-+','LineWidth',2);
% hold on;
% plot(Haming_Distance4,'k->','LineWidth',2);
xlabel('运行代数');                                                         
ylabel('汉明距离');
legend('基于改进评分的BPSO','经典BPSO');


