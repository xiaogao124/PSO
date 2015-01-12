function Index_Replaced= rdt_replaced(index,fitness)

j=1;
Index_Replaced(1)=0;

for i=1:size(index,1)
    if i ~= index(i)
        if fitness(i) == fitness(index(i))
            Index_Replaced(j,1) = i;
            j=j+1;
        end
    end
    
end