function score = I_score_family(j, ps, node_type, scoring_fn, ns, discrete, data, args)
% SCORE_FAMILY_COMPLETE Compute the score of a node and its parents given completely observed data
% score = score_family(j, ps, node_type, scoring_fn, ns, discrete, data, args)
%
% data(i,m) is the value of node i in case m (can be a cell array)
% args is a cell array containing optional arguments passed to the constructor,
% or is [] if none
%
% We create a whole Bayes net which only connects parents to node,
% where node has a CPD of the specified type (with default parameters).
% We then evaluate its score ('bic' or 'bayesian')

% We should use a cache to avoid unnecessary computation.
% In particular, log_marginal_prob_node for tabular CPDs calls gammaln
% and compute_counts, both of which are slow.

[n ncases] = size(data);
dag = zeros(n,n);
for i1 = 1 : n
    for j1 = 1 : n
       expertmatrix(i1,j1) = 0.333 ;
    end
end
expertmatrix(2,4) = 0.9;expertmatrix(4,2) = 0.05;
expertmatrix(4,6) = 0.9;expertmatrix(6,4) = 0.05;
expertmatrix(2,6) = 0.05;expertmatrix(6,2) = 0.05;
% SML added to sort ps b/c mk_bnet, learn_params use sorted ps to make
% CPTs
% Kevin had: if ~isempty(ps), dag(ps, j) = 1; end
if ~isempty(ps), dag(ps, j) = 1;, ps = sort(ps);, end

bnet = mk_bnet(dag, ns, 'discrete', discrete);
%bnet.CPD{j} = xxx_CPD(bnet, j);
%eval(sprintf('bnet.CPD{j} = %s_CPD(bnet, j);', node_type));
fname = sprintf('%s_CPD', node_type);
%fprintf('score CPD %d\n', j);
if isempty(args)
  bnet.CPD{j} = feval(fname, bnet, j);
else
  bnet.CPD{j} = feval(fname, bnet, j, args{:});
end

switch scoring_fn
 case 'bic',
  fam = [ps j];
  %score = BIC_score_CPD(bnet.CPD{j}, fam, data, ns, bnet.cnodes);
  %bnet.CPD{j} = learn_params(bnet.CPD{j}, fam, data, ns, bnet.cnodes);
  
  % SML 03/16/04 had to special case gaussian b/c generic_CPD/learn_params
  % no longer supported because of simple interface to learn_params
  % introduced by KPM for tabular nodes below:
  % KPM 9 June 04 - tabular nodes have changed back!
  if 1 % (isempty(find(j==discrete)))
     bnet.CPD{j} = learn_params(bnet.CPD{j},  fam, data, ns, bnet.cnodes);
  else 
  	bnet.CPD{j} = learn_params(bnet.CPD{j}, data(fam, :));
  end
  L = log_prob_node(bnet.CPD{j}, data(j,:), data(ps,:));
  S = struct(bnet.CPD{j}); % violate object privacy
    
  score = L - 0.5*S.nparams*log(ncases);
   %????????????????????????
     if(size(ps)==0)                                                                  
         a = expertmatrix(j,j);
%          score = score;
         score = L + log(a)-0.5*S.nparams*log(ncases);
% 
      end
      if (size(ps)==1)
          a = expertmatrix(ps,j);
%          score = score*a;
%           score = score - score*a*(10/ncases);
            score = L + log(a)-0.5*S.nparams*log(ncases);
%             score = L + log(1+(10*a)/ncases)-0.5*S.nparams*log(ncases);
      end
        s = size(ps);
       if (s(2)==2)
           a = ps(1);
           b = ps(2);
           a = expertmatrix(a,j);
           b = expertmatrix(b,j);
 %          c = max(a,b);
%          score = score*a*b;
%           score = score - score*a*b*(10/ncases);
          score = L + log(a*b)-0.5*S.nparams*log(ncases);
%           score = L + log(1+(10*b)/ncases)-0.5*S.nparams*log(ncases);
       end
  
  
 
 case 'bayesian', 
  %score = bayesian_score_CPD(bnet.CPD{j}, data(fam, :));
  score = log_marg_prob_node(bnet.CPD{j}, data(j,:), data(ps,:));
   if(size(ps)==0)                                                                  
         a = expertmatrix(j,j);
%          score = score;
         score = score + log(a);
% 
      end
      if (size(ps)==1)
          a = expertmatrix(ps,j);
%          score = score*a;
%           score = score - score*a*(10/ncases);
            score = score + log(a);
%             score = L + log(1+(10*a)/ncases)-0.5*S.nparams*log(ncases);
      end
        s = size(ps);
       if (s(2)==2)
           a = ps(1);
           b = ps(2);
           a = expertmatrix(a,j);
           b = expertmatrix(b,j);
 %          c = max(a,b);
%          score = score*a*b;
%           score = score - score*a*b*(10/ncases);
          score = score + log(a*b);
%           score = L + log(1+(10*b)/ncases)-0.5*S.nparams*log(ncases);
       end
 otherwise,
  error(['unrecognized scoring fn ' scoring_fn]);
end