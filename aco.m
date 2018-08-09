function [x, fval] = aco (fun, nvars, lb, ub)

res = 1000;
antCount = 30;
iter = 100;
pheromoneGain = 2.5;
pheromoneScale = 0.2;
evaporationRate = 0.05;

pheromone = zeros(H,n);
route = zeros(iter, antCount, nvars);
errorMatrix = zeros(iter, nvars);
bestAnt = [0, 0];

X1min = lb(1);
X1max = ub(1);
X2min = lb(2);
X2max = ub(2);
X3min = lb(3);
X3max = ub(3);

X1(1) = X1min;
X1(H) = X1max;
stepX1 = (X1max - X1min)/(H-1);
X2(1) = X2min;
X2(H) = X2max;
stepX2 = (X2max - X2min)/(H-1);
X3(1) = X3min;
X3(H) = X3max;
stepX3 = (X3max - X3min)/(H-1);

for j=2:H-1
    X1(j) = j*stepX1;
    X2(j) = j*stepX2;
    X3(j) = j*stepX3;
end

X1_0 = X1(randi([1, res],1,1));
X2_0 = X2(randi([1, res],1,1));
X3_0 = X3(randi([1, res],1,1));
X0 = [X1_0, X2_0, X3_0];

initialError = fun(X0);
initialPheromone = 1/initialError;
minError = initialError;

pheromone(:) = initialPheromone;

for l=1:iter
    
    for g=1:n
        alfa_pheromone=pheromone.^pheromoneGain;
        s=sum(alfa_pheromone(:,g));
        probabilityMatrix=(1/s).*alfa_pheromone;
    end
    for i=1:M
        for j=1:n
            r=rand;
            s=0;
            for k=1:H 
                s=s+probabilityMatrix(k,j);
                if r<=s
                    route(l,i,j) = k;
                    break
                end
            end    
        end
        errorMatrix(l,i)=fun([X1(route(l,i,1)), X2(route(l,i,2)), X3(route(l,i,3))]);

        if (errorMatrix(l,i) < minError)
            minError = errorMatrix(l,i);
            bestAnt = [l ,i];
        end
        pheromone(route(l,i,1),1) = pheromone(route(l,i,1),1) + (pheromoneScale/errorMatrix(l,i));
        pheromone(route(l,i,2),2) = pheromone(route(l,i,2),2) + (pheromoneScale/errorMatrix(l,i));
        pheromone(route(l,i,3),3) = pheromone(route(l,i,3),3) + (pheromoneScale/errorMatrix(l,i));
    end
    
    for jj=1:n
        for ii=1:H
            pheromone(ii,jj)=(1-evaporationRate).*pheromone(ii,jj)+(1/minError);
        end
    end
end
 
x = [X1(route(bestAnt(1,1), bestAnt(1,2), 1)),...
                 X2(route(bestAnt(1,1), bestAnt(1,2), 2)),... 
                 X3(route(bestAnt(1,1), bestAnt(1,2), 3))];
fval = fun(x);
end