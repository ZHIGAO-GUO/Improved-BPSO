function score = Improve_score_dags(data, ns, dags,J,N ,varargin)
% SCORE_DAGS Compute the score of one or more DAGs
% score = score_dags(data, ns, dags, varargin)
%
% data{i,m} = value of node i in case m (can be a cell array).
% node_sizes(i) is the number of size of node i.
% dags{g} is the g'th dag
% score(g) is the score of the i'th dag
%
% The following optional arguments can be specified in the form of name/value pairs:
% [default value in brackets]
%
% scoring_fn - 'bayesian' or 'bic' [ 'bayesian' ]
%              Currently, only networks with all tabular nodes support Bayesian scoring.
% type       - type{i} is the type of CPD to use for node i, where the type is a string
%              of the form 'tabular', 'noisy_or', 'gaussian', etc. [ all cells contain 'tabular' ]
% params     - params{i} contains optional arguments passed to the CPD constructor for node i,
%              or [] if none.  [ all cells contain {'prior', 1}, meaning use uniform Dirichlet priors ]
% discrete   - the list of discrete nodes [ 1:N ]
% clamped    - clamped(i,m) = 1 if node i is clamped in case m [ zeros(N, ncases) ]
%
% e.g., score = score_dags(data, ns, mk_all_dags(n), 'scoring_fn', 'bic', 'params', []);
%
% If the DAGs have a lot of families in common, we can cache the sufficient statistics,
% making this potentially more efficient than scoring the DAGs one at a time.
% (Caching is not currently implemented, however.)

[n ncases] = size(data);

% set default params
type = cell(1,n);
params = cell(1,n);
for i=1:n
  type{i} = 'tabular';
  params{i} = { 'prior_type', 'dirichlet', 'dirichlet_weight', 1 };
end
scoring_fn = 'bayesian';
discrete = 1:n;

u = [1:ncases]'; % DWH
isclamped = 0; %DWH
clamped = zeros(n, ncases);

args = varargin;
nargs = length(args);
for i=1:2:nargs
  switch args{i},
   case 'scoring_fn', scoring_fn = args{i+1};
   case 'type',       type = args{i+1}; 
   case 'discrete',   discrete = args{i+1}; 
   case 'clamped',    clamped = args{i+1}, isclamped = 1; %DWH
   case 'params',     if isempty(args{i+1}), params = cell(1,n); else params = args{i+1};  end
  end
end

NG = length(dags);
score = zeros(1, NG);
for g=1:NG
  dag = dags{g};
  for j=1:n
    if isclamped %DWH
        u = find(clamped(j,:)==0);    
    end
    ps = parents(dag, j);
    score(g) = score(g) + score_family(j, ps, type{j}, scoring_fn, ns, discrete, data(:,u), params{j});
  end
end
    n = 1;m = 0;
    if dag(2,4)==1&&dag(4,6)==1&&dag(2,6)==1&&dag(4,2)==0&&dag(6,4)==0&&dag(6,2)==0
        score = score + n*log(m+J(1)/N(1));
    end
    if dag(2,4)==1&&dag(4,6)==1&&dag(6,2)==1&&dag(4,2)==0&&dag(6,4)==0&&dag(2,6)==0
        score = -1.0e+015;
    end
    if dag(2,4)==1&&dag(4,6)==1&&dag(2,6)==0&&dag(6,2)==0&&dag(4,2)==0&&dag(6,4)==0
        score = score + n*log(m+J(3)/N(3));
    end
    if dag(2,4)==1&&dag(6,4)==1&&dag(2,6)==1&&dag(4,2)==0&&dag(4,6)==0&&dag(6,2)==0
        score = score +  n*log(m+J(4)/N(4));
    end
    if dag(2,4)==1&&dag(6,4)==1&&dag(6,2)==1&&dag(4,2)==0&&dag(4,6)==0&&dag(2,6)==0
        score = score +  n*log(m+J(5)/N(5));
    end

    if dag(2,4)==1&&dag(6,4)==1&&dag(6,2)==0&&dag(4,2)==0&&dag(4,6)==0&&dag(2,6)==0
        score = score +  n*log(m+J(6)/N(6));
    end
    if dag(2,4)==1&&dag(6,4)==0&&dag(2,6)==1&&dag(4,2)==0&&dag(4,6)==0&&dag(6,2)==0
       score = score +  n*log(m+J(7)/N(7));
    end
    if dag(2,4)==1&&dag(6,4)==0&&dag(6,2)==1&&dag(4,2)==0&&dag(4,6)==0&&dag(2,6)==0
       score = score +  n*log(m+J(8)/N(8));
    end
    if dag(2,4)==1&&dag(6,4)==0&&dag(6,2)==0&&dag(4,2)==0&&dag(4,6)==0&&dag(2,6)==0
       score = score +  n*log(m+J(9)/N(9));
    end
    
     if dag(4,2)==1&&dag(4,6)==1&&dag(2,6)==1&&dag(2,4)==0&&dag(6,4)==0&&dag(6,2)==0
        score = score +  n*log(m+J(10)/N(10));
     end
     if dag(4,2)==1&&dag(4,6)==1&&dag(6,2)==1&&dag(2,4)==0&&dag(6,4)==0&&dag(2,6)==0
       score = score +  n*log(m+J(11)/N(11));
     end
     if dag(4,2)==1&&dag(4,6)==1&&dag(6,2)==0&&dag(2,4)==0&&dag(6,4)==0&&dag(2,6)==0
        score = score +  n*log(m+J(12)/N(12));
     end
     if dag(4,2)==1&&dag(6,4)==1&&dag(2,6)==1&&dag(2,4)==0&&dag(4,6)==0&&dag(6,2)==0
        score = -1.0e+015;
     end
     if dag(4,2)==1&&dag(6,4)==1&&dag(6,2)==1&&dag(2,4)==0&&dag(4,6)==0&&dag(2,6)==0
        score = score +  n*log(m+J(14)/N(14));
     end
     if dag(4,2)==1&&dag(6,4)==1&&dag(6,2)==0&&dag(2,4)==0&&dag(4,6)==0&&dag(2,6)==0
        score = score +  n*log(m+J(15)/N(15));
     end
     if dag(4,2)==1&&dag(6,4)==0&&dag(2,6)==1&&dag(2,4)==0&&dag(4,6)==0&&dag(6,2)==0
        score = score +  n*log(m+J(16)/N(16));
     end
     if dag(4,2)==1&&dag(6,4)==0&&dag(6,2)==1&&dag(2,4)==0&&dag(4,6)==0&&dag(2,6)==0
        score = score +  n*log(m+J(17)/N(17));
     end
     if dag(4,2)==1&&dag(6,4)==0&&dag(6,2)==0&&dag(2,4)==0&&dag(4,6)==0&&dag(2,6)==0
       score = score +  n*log(m+J(18)/N(18));
     end
     
     if dag(4,2)==0&&dag(4,6)==1&&dag(2,6)==1&&dag(2,4)==0&&dag(6,4)==0&&dag(6,2)==0
        score = score +  n*log(m+J(19)/N(19));
     end
     if dag(4,2)==0&&dag(4,6)==1&&dag(6,2)==1&&dag(2,4)==0&&dag(6,4)==0&&dag(2,6)==0
        score = score +  n*log(m+J(20)/N(20));
     end
     if dag(4,2)==0&&dag(4,6)==1&&dag(6,2)==0&&dag(2,4)==0&&dag(6,4)==0&&dag(2,6)==0
        score = score +  n*log(J(21)/N(21));
     end
     if dag(4,2)==0&&dag(6,4)==1&&dag(2,6)==1&&dag(2,4)==0&&dag(4,6)==0&&dag(6,2)==0
        score = score +  n*log(J(22)/N(22));
     end
      if dag(4,2)==0&&dag(6,4)==1&&dag(6,2)==1&&dag(2,4)==0&&dag(4,6)==0&&dag(2,6)==0
        score = score +  n*log(m+J(23)/N(23));
      end
      if dag(4,2)==0&&dag(6,4)==1&&dag(6,2)==0&&dag(2,4)==0&&dag(4,6)==0&&dag(2,6)==0
        score = score +  n*log(m+J(24)/N(24));
      end
      if dag(4,2)==0&&dag(6,4)==0&&dag(2,6)==1&&dag(2,4)==0&&dag(4,6)==0&&dag(6,2)==0
        score = score +  n*log(m+J(25)/N(25));
      end
      if dag(4,2)==0&&dag(6,4)==0&&dag(6,2)==1&&dag(2,4)==0&&dag(4,6)==0&&dag(2,6)==0
        score = score +  n*log(m+J(26)/N(26));
      end
      if dag(4,2)==0&&dag(6,4)==0&&dag(6,2)==0&&dag(2,4)==0&&dag(4,6)==0&&dag(2,6)==0
        score = score +  n*log(m+J(27)/N(27));
      end
 %%*************************************************************************************%%   
      
%     if dag(2,4)==1&&dag(4,6)==1&&dag(2,6)==1&&dag(4,2)==0&&dag(6,4)==0&&dag(6,2)==0
%         score = score + log(J(1));
%     end
%     if dag(2,4)==1&&dag(4,6)==1&&dag(6,2)==1&&dag(4,2)==0&&dag(6,4)==0&&dag(2,6)==0
%        score = score + log(0.00000000001);
%     end
%     if dag(2,4)==1&&dag(4,6)==1&&dag(2,6)==0&&dag(6,2)==0&&dag(4,2)==0&&dag(6,4)==0
%         score = score + log(J(3));
%     end
%     if dag(2,4)==1&&dag(6,4)==1&&dag(2,6)==1&&dag(4,2)==0&&dag(4,6)==0&&dag(6,2)==0
%         score = score + log(J(4));
%     end
%     if dag(2,4)==1&&dag(6,4)==1&&dag(6,2)==1&&dag(4,2)==0&&dag(4,6)==0&&dag(2,6)==0
%         score = score + log(J(5));
%     end
% 
%     if dag(2,4)==1&&dag(6,4)==1&&dag(6,2)==0&&dag(4,2)==0&&dag(4,6)==0&&dag(2,6)==0
%         score = score + log(J(6));
%     end
%     if dag(2,4)==1&&dag(6,4)==0&&dag(2,6)==1&&dag(4,2)==0&&dag(4,6)==0&&dag(6,2)==0
%        score = score + log(J(7));
%     end
%     if dag(2,4)==1&&dag(6,4)==0&&dag(6,2)==1&&dag(4,2)==0&&dag(4,6)==0&&dag(2,6)==0
%        score = score + log(J(8));
%     end
%     if dag(2,4)==1&&dag(6,4)==0&&dag(6,2)==0&&dag(4,2)==0&&dag(4,6)==0&&dag(2,6)==0
%        score = score + log(J(9));
%     end
%     
%      if dag(4,2)==1&&dag(4,6)==1&&dag(2,6)==1&&dag(2,4)==0&&dag(6,4)==0&&dag(6,2)==0
%         score = score + log(J(10));
%      end
%      if dag(4,2)==1&&dag(4,6)==1&&dag(6,2)==1&&dag(2,4)==0&&dag(6,4)==0&&dag(2,6)==0
%        score = score + log(J(11));
%      end
%      if dag(4,2)==1&&dag(4,6)==1&&dag(6,2)==0&&dag(2,4)==0&&dag(6,4)==0&&dag(2,6)==0
%         score = score + log(J(12));
%      end
%      if dag(4,2)==1&&dag(6,4)==1&&dag(2,6)==1&&dag(2,4)==0&&dag(4,6)==0&&dag(6,2)==0
%          score = score + log(0.00000000001);
%      end
%      if dag(4,2)==1&&dag(6,4)==1&&dag(6,2)==1&&dag(2,4)==0&&dag(4,6)==0&&dag(2,6)==0
%         score = score + log(J(14));
%      end
%      if dag(4,2)==1&&dag(6,4)==1&&dag(6,2)==0&&dag(2,4)==0&&dag(4,6)==0&&dag(2,6)==0
%         score = score + log(J(15));
%      end
%      if dag(4,2)==1&&dag(6,4)==0&&dag(2,6)==1&&dag(2,4)==0&&dag(4,6)==0&&dag(6,2)==0
%         score = score + log(J(16));
%      end
%      if dag(4,2)==1&&dag(6,4)==0&&dag(6,2)==1&&dag(2,4)==0&&dag(4,6)==0&&dag(2,6)==0
%         score = score + log(J(17));
%      end
%      if dag(4,2)==1&&dag(6,4)==0&&dag(6,2)==0&&dag(2,4)==0&&dag(4,6)==0&&dag(2,6)==0
%        score = score + log(J(18));
%      end
%      
%      if dag(4,2)==0&&dag(4,6)==1&&dag(2,6)==1&&dag(2,4)==0&&dag(6,4)==0&&dag(6,2)==0
%         score = score + log(J(19));
%      end
%      if dag(4,2)==0&&dag(4,6)==1&&dag(6,2)==1&&dag(2,4)==0&&dag(6,4)==0&&dag(2,6)==0
%         score = score + log(J(20));
%      end
%      if dag(4,2)==0&&dag(4,6)==1&&dag(6,2)==0&&dag(2,4)==0&&dag(6,4)==0&&dag(2,6)==0
%         score = score + log(J(21));
%      end
%      if dag(4,2)==0&&dag(6,4)==1&&dag(2,6)==1&&dag(2,4)==0&&dag(4,6)==0&&dag(6,2)==0
%         score = score + log(J(22));
%      end
%       if dag(4,2)==0&&dag(6,4)==1&&dag(6,2)==1&&dag(2,4)==0&&dag(4,6)==0&&dag(2,6)==0
%         score = score + log(J(23));
%       end
%       if dag(4,2)==0&&dag(6,4)==1&&dag(6,2)==0&&dag(2,4)==0&&dag(4,6)==0&&dag(2,6)==0
%         score = score + log(J(24));
%       end
%       if dag(4,2)==0&&dag(6,4)==0&&dag(2,6)==1&&dag(2,4)==0&&dag(4,6)==0&&dag(6,2)==0
%         score = score + log(J(25));
%       end
%       if dag(4,2)==0&&dag(6,4)==0&&dag(6,2)==1&&dag(2,4)==0&&dag(4,6)==0&&dag(2,6)==0
%         score = score + log(J(26));
%       end
%       if dag(4,2)==0&&dag(6,4)==0&&dag(6,2)==0&&dag(2,4)==0&&dag(4,6)==0&&dag(2,6)==0
%         score = score + log(J(27));
%      end