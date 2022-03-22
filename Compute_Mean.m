function m = Compute_Mean(a,E_number,Step_number)
total = zeros(1,Step_number);

for i = 1 : Step_number
    for j = 1 : E_number
        total(i) = total(i) + a{j}(i)
    end
    m = total/E_number;
end
