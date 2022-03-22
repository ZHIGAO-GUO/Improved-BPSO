function [maxf gbest]=gb_d(x,n,ns,data,g,gbestdag)
for i=1:20
     score = score_dags(data, ns, x(i,n), 'scoring_fn', 'bic', 'params', []) ;
     f(i) = score;
end
[maxf,i_index] = max(f);%有改动
if maxf>g   %有改动
    gbest = x{i_index,n};
else
    gbest =  gbestdag;
    maxf = g;
end
