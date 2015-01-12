function [Index seed_index]= select_seed(population,particle,fitness,radius)

[tmp sort_index] = sort(fitness);   % tmp is not used variable;


Index = zeros(population,1);
seed_num = 1;

Index(sort_index) = sort_index(1);
seed_index = sort_index(1);

for i = 1:population
    
    found = false;
    
    for j=1:seed_num
        
        if norm(particle(seed_index(j),:) - particle(sort_index(i),:),2) <= radius
            Index(sort_index(i)) = seed_index(j);
            found = true;
            break;
        end

    end
    
    if found == false;
        Index(sort_index(i)) = sort_index(i);
        seed_num = seed_num + 1;
        seed_index(seed_num) = sort_index(i);
    end

end


