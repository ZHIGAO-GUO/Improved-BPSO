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

N = 6;
node_number = 6;
nsamples = 1000;
samples = cell(N, nsamples);    
for i = 1:nsamples
    samples(:,i) = sample_bnet(bnet);
end
r = samples;
data1 = cell2num(r);
data = data1(:,1:50);
Experiment_Matrix = [0.9 0.05 0.05;0.9 0.05 0.05;0.05 0.05 0.9];
Jc = Compute_Jc(Experiment_Matrix);


for i = 1 :27
    Nc(i) = 3781503/27;
end
All_gb_score = cell(1,50);
All_gb_score1 = cell(1,50);
All_Haming_Distance = cell(1,50);
All_Haming_Distance1 = cell(1,50);
for Experiment_Number = 1 : 5
    Experiment_Number
    for i = 1 : 20  % Initialize the particle
        particle = rand(N,N) >= 0.5;
        particle = Pre_Treament(particle);
        dags1(i,1) = {particle};
        pbest1(i) = {particle};
        dags(i,1) = {particle};
        pbest(i) = {particle};    
end


iterative = 50; 
f_Type = 'bic';         
w = 0.8*blkdiag(1,1,1,1,1,1); %Inertia weights
c1 = blkdiag(2,2,2,2,2,2);    %Weights of particles atrracks the history optimum 
c2 = blkdiag(2,2,2,2,2,2);    %Weights of particles atrracks the colony optimum
ns = [2 2 2 2 2 2];
velmin = -4;
velmax = 4;
vel = cell(20,100);
vel1 = cell(20,100);
vel3 = cell(20,100);
vel4 = cell(20,100);

for i=1:20
  vel{i,1} = dags{i,1}; 
  vel1{i,1} = dags1{i,1};
end

%% **************************经典BPSO算法***************************************************
for i = 1:20
     score = score_dags(data, ns, dags1(i,1), 'scoring_fn',f_Type, 'params', []);
     f1(i) = score;
end

[maxscore1,i_index] = max(f1);
gbest1 = dags1{i_index,1};

for j=1:iterative
    j
    for i=1:20
      vel1{i,j+1} = w*vel1{i,j}+c1*0.6*(pbest1{i}-dags1{i,j})+c2*0.8*(gbest1-dags1{i,j});% BPSO added with velocity
      C = vel1{i,j+1};
      for m=1:node_number
          for n=1:node_number
             if C(m,n)>velmax
                 C(m,n)=velmax;
             else
                 if C(m,n)<velmin
                     C(m,n)=velmin;
                 end
             end
             if  sigmoid(C(m,n))>rand
                  C(m,n)=1;
             else
                 C(m,n)=0;
             end 
          end
     end 
     C = Pre_Treament(C);  %Remove the cycles
     dags1(i,j+1)={C}; 
    end
    pbest1 = pb(dags1,j+1,ns,data);
    [maxscore1, gbest1] = gb_d(dags1,j+1,ns,data,maxscore1,gbest1);
    gb_score1(j) = score_dags(data1, ns, {gbest1}, 'scoring_fn',f_Type, 'params', []);
    Haming_Distance1(j) = Comupute_Haming_Distance(gbest1,adjacency);
end
All_Haming_Distance1(Experiment_Number) = {Haming_Distance1};
end
Mean_Haming_Distance1 = Compute_Mean(All_Haming_Distance1, 5, 50);


figure
plot(Haming_Distance1,'b-*','LineWidth',2);
xlabel('Iterations');                                                         
ylabel('Hamming distance');
legend('Improved BPSO','Classic BPSO');




