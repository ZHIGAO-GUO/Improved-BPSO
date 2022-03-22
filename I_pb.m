function p = I_pb(x,n,ns,data,J,N,Tag)

for i = 1:20
  for j = 1:n
    if Tag == 0
        score = Improve_score_dags(data, ns, x(i,n),J,N, 'scoring_fn', 'bic', 'params', []);
    end
    if Tag == 1
        score = I_score_dags(data, ns, x(i,n), 'scoring_fn', 'bic', 'params', []);              %将先验以分解的形式加入到评分函数中
    end
     f(j) = score;
   end
   [maxf,i_index] = max(f);
   p(i) = {x{i,i_index}};
end
