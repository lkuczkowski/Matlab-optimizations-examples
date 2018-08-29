% Created by Lukasz Kuczkowski
% Full repository available at https://github.com/lkuczkowski

clear all;
clc;
addpath(genpath('PID_tuning'));
loopVar = true;

disp('This m-file contains example of tuning PID controller gains using optimization methods.')
disp('Except lsqnonlin, which requires explicitly least-squares definition,')
disp('you can choose between three integral criterias: ')
disp('    * Integral of the absolute value of error (IAE)')
disp('    * Integral of the squared error (ISE)')
disp('    * Integral of the time weighted absolute error (ITAE)')
disp('No default lower and upper bounds are set')
disp('Default start point is [0.6, 0.5, 2]')
disp('See detailed description at https://github.com/lkuczkowski/Matlab-optimizations-examples')
disp(' ')

while (loopVar)    
    
    disp('Choose algorithm to perform optimization: ')
    disp('(1) lsqnonlin (levenberg-marquardt method)')
    disp('(2) fminunc (quasi-newton, bfgs method)')
    disp('(3) fminsearch (simplex search method)')
    disp('(4) ga (genetic algorithm)')
    disp('(5) particleswarm (particle swarm optimization)')
    disp('(6) ant colony optimization')
    disp('(7) Exit')
    alg = input('Select the algorithm: ');

    startingPoint = [0.9, 0.1, 3];
    lb = [];
    ub = [];

    if (alg == 1)
        options = optimoptions(@lsqnonlin,'Algorithm', 'levenberg-marquardt',...
                                            'Display', 'off',...
                                            'StepTolerance', 0.001,...
                                            'OptimalityTolerance', 0.001);
        disp('It may take a while ...')
        [pid_gains, error] = lsqnonlin(@fCalculateError, startingPoint, lb, ub, options);
        fPrintResults(pid_gains, error, startingPoint);
    elseif (alg == 7)
        loopVar = false;
    elseif (alg > 1) & (alg < 7)
        DisplayCriteriaQuestion()
        CFunction = fSelectIntegralCriteria(input('Select criteria: '));
        
        if not(isa(CFunction, 'function_handle'))
            disp('No such a criteria')
        
        elseif (alg == 2)
            options = optimoptions(@fminunc, 'Algorithm', 'quasi-newton',...
                                            'Display', 'off',...
                                            'HessUpdate', 'bfgs',...
                                            'StepTolerance', 0.001,...
                                            'OptimalityTolerance', 0.001);
            disp('It may take a while ...')
            [pid_gains, error] = fminunc(CFunction, startingPoint, options);
            fPrintResults(pid_gains, error, startingPoint);

        elseif (alg == 3)

            options = optimset('Display', 'off');
            disp('It may take a while ...')
            [pid_gains, error] = fminsearch(CFunction, startingPoint, options);
            fPrintResults(pid_gains, error, startingPoint);
    
        elseif (alg == 4)

%             options = optimoptions(@ga, 'Display', 'off',...
%                                         'CreationFcn', 'gacreationuniform',...
%                                         'CrossoverFcn', 'crossoverscattered',...
%                                         'CrossoverFraction', 0.8,...
%                                         'EliteCount', 6,...
%                                         'MaxGenerations', 100,...
%                                         'MutationFcn', 'mutationuniform',...
%                                         'PopulationSize', 30,...
%                                         'SelectionFcn', {@selectiontournament, 10});
            disp('It may really take a while ...')
            [pid_gains, error] = ga(CFunction, length(startingPoint)); %, [], [], [], [], [], [], [], options);
            fPrintResults(pid_gains, error, startingPoint);
        
        elseif (alg == 5)

%             options = optimoptions(@particleswarm, 'Display', 'off',...
%                                         'MaxIterations', 300,...
%                                         'SwarmSize', 30);
            disp('It may really take a while ...')
            [pid_gains, error] = particleswarm(CFunction, length(startingPoint)); %, [], [], options);
            fPrintResults(pid_gains, error, startingPoint);
    
        elseif (alg == 6)

            disp('It may really take a while ...')
            [pid_gains, error] = aco(CFunction, length(startingPoint), [0, 0, 0], [100, 100, 100]);
            fPrintResults(pid_gains, error, startingPoint);   
        
        end
    else
        disp('No such algorithm')   
    end
end

function DisplayCriteriaQuestion()
disp('(1) Integral of the absolute value of error (IAE)')
disp('(2) Integral of the squared error (ISE)')
disp('(3) Integral of the time weighted absolute error (ITAE)')
end

function criteria = fSelectIntegralCriteria (number)
if (number == 1)
    criteria = @fCalculateISE;
elseif (number == 2)
    criteria = @fCalculateIAE;
elseif (number == 3)
    criteria = @fCalculateITAE;
else
    criteria = false;
end
end

function fPrintResults(gains, err, startingPoint)
    disp(['Total error rate was: ', num2str(err)])
    disp('Calculated PID gains:')
    disp(['P: ', num2str(gains(1))])
    disp(['I: ', num2str(gains(2))])
    disp(['D: ', num2str(gains(3))])
    [time, y1, ~] = fSim_plant_and_actuator(startingPoint(1), startingPoint(2), startingPoint(3));
    [~, y2, ~] = fSim_plant_and_actuator(gains(1), gains(2), gains(3));
    fPlot_result_PID(time, y1, y2);
end
