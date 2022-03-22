function score = resolve_1(score)                                  
m = length(score);
for i = 1 : m-1   
       if score(i) > score(i+1) 
       
       else   score(i+1) = score(i); 
      
       end
         
end