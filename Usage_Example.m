
Fnc=@(x) cos(x(1))^2+cos(x(2))^2;
nVar = 2;
lb = [-pi -pi];
ub = [ pi  pi];

option.population=50;
option.radius=2;
option.max_iter=1000;

[fval fitness]=spso(Fnc,nVar,lb,ub,option)