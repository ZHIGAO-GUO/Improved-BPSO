function Score_Hanmin = Mean_Score_Hanmin(cell_Score_Hanmin , n , m)
for j = 1 : m
    for i = 1 : n 
          sum = sum + cell_Score_Hanmin{i}(j);    
    end
   Score_Hanmin(j) = sum/n;
   sum = 0;
end


