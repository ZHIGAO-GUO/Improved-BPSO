function p = pb(x,n,ns,data)

for i=1:20
  for j=1:n
%      time1 = cputime;
     score= score_dags(data, ns, x(i,j), 'scoring_fn', 'bic', 'params', []) ;
%      time = cputime - time1
     f(j)=score;
   end
   [maxf,i_index]=max(f);%ÓÐ¸Ä¶¯
   p(i)={x{i,i_index}};
end