clear all;
clc;
addpath(genpath('System_identification'));

% mRef = 2.5;
% lRef = 1.1;
% IRef = 0.45;
% 
% [xRef, phiRef] = fSimulateModel(mRef, lRef, IRef);
% 
% objective = @(lambda)(fObjectiveFunctionReturnVector(lambda, xRef, phiRef));
% 
% solution = lsqnonlin(objective, [0.4, 1.1, 1.35])
% [x, phi] = fSimulateModel(solution(1), solution(2), solution(3));
% 
% error = abs(solution - [mRef, lRef, IRef])
% 
% fPlotResponseComparison(mRef, lRef, IRef, solution(1), solution(2), solution(3))