function C = Pre_Treament(C)
C = C - diag(diag(C));              %将对角线所有元素置为0
s = length(C);
 for m=1:s
         for n=1:s
            if (C(m,n)==1 && C(n,m)==1)
                if m>n
                     C(m,n)=0;
                 else C(n,m)=0;
                end
            end
         end
     end
     for k=1:s
         for m=k+1:s
             for n=1:s
                 if (C(n,k)==1 && C(k,m)+C(m,n)==2*C(n,k))
                     C(m,n)=0;
                 end
             end
         end
     end
     for k=1:s
         for m=1:s
             for n=1:s
                 for p=1:s
                 if (C(p,k)==1 && C(k,m)+C(m,n)+C(n,p)==3*C(p,k))
                     C(n,p)=0;
                 end
                 end
             end
         end
     end
