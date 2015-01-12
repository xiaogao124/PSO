function [fval fitness]=spso(Fnc,nVar,lb,ub,option)


%Fnc=@(x) cos(x(1))^2+cos(x(2))^2;
%nVar = 2;
%lb = [-pi -pi];
%ub = [ pi pi];

% enviornment variable

% customer setting
population = option.population;
radius = option.radius;
iteration = option.max_iter;

phi1=2.05;
phi2=2.05;
phi = phi1 + phi2;
chi = 2/abs(2-phi-(phi^2-4*phi)^0.5);


% Initialize particles
Range=kron(ones(population,1),(ub-lb));
LBound=kron(ones(population,1),lb);
particle = LBound + rand(population,nVar).*Range;

% first setting 
m_fitness=zeros(population,1);
for i=1:population
    m_fitness(i) = Fnc(particle(i,:));
end

i_best = particle;  % individual_best
velocity = zeros(population,nVar); 
p_fitness = m_fitness;
index = select_seed(population,particle,p_fitness,radius);   

% start to iterate
for i = 1:iteration

    % update the particle 
    for j=1:population     
        velocity(j,:) = chi*( velocity(j,:)+phi1*rand*(i_best(j,:)-particle(j,:)) ...
                        + phi2*rand*(particle(index(j),:)-particle(j,:)) );
        next_p = particle(j,:)+velocity(j,:);     
        
        if (sum( next_p >= lb ) == nVar) && (sum( next_p <= ub) == nVar)
            particle(j,:) = next_p;
        end
        
        
        p_fitness(j) = Fnc(particle(j,:));
        if p_fitness(j) < m_fitness(j)
            i_best(j,:) = particle(j,:);
            m_fitness(j) = p_fitness(j);
        end        
    end

    [index seed]= select_seed(population,particle,p_fitness,radius);
    
    % replaced the redundant with randomly generating particles
    % index_rdt is refered to i-th particle needed to be replaced.
    index_rdt = rdt_replaced(index,p_fitness);     
    
    if index_rdt(1) ~=0
       replaced_num=size(index_rdt,1);
       replaced_p = rand(replaced_num,nVar).*(ones(replaced_num,1)*(ub-lb))...
                    + ones(replaced_num,1)*lb;
       
       particle(index_rdt,:) = replaced_p;
       i_best(index_rdt,:) = replaced_p;
       
       % initialize the individual best fitness
       % and index_rdt is transposed to row vector for "for loop"
       for j=index_rdt' 
           m_fitness(j) = Fnc(particle(j,:));
       end
       
    end
    %}
    
end

fval=particle(seed,:); % final solution

fitness=zeros(size(seed))'; % final fitness
for i=1:size(seed,1)
    fitness(i,1)=Fnc(fval(i,:));     
end