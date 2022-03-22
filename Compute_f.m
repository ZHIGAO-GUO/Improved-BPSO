function f = Compute_f(n)
    f = 0;
if n == 0
    f = 1;
end
if n == 1
    f = 1;
end
if n ~= 1&& n ~= 0
    for i = 1 : n
      f = f + Compute_w(n,i) *  Compute_f(n-i);
    end
    
end