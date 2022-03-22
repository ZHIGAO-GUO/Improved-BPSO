function [maxf gbest]=I_gb_d(x,n,ns,data,g,gbestdag,J,N,Tag)
for i=1:20
    if Tag == 0
        score = Improve_score_dags(data, ns, x(i,n),J,N, 'scoring_fn', 'bic', 'params', []);
    end
    if Tag == 1
        score = I_score_dags(data, ns, x(i,n), 'scoring_fn', 'bic', 'params', []);              %将先验以分解的形式加入到评分函数中
    end
  
%      score = score_dags(data, ns, x(i,n), 'scoring_fn', 'bic', 'params', []);
     f(i) = score;
end
  [maxf,i_index] = max(f);
if maxf>g   
    gbest = x{i_index,n};
else
    gbest =  gbestdag;
    maxf = g;
end

