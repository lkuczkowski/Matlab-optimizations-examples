function [time, y, error] = fSim_plant_and_actuator(P_pid, I_pid, D_pid)
P = P_pid;
I = I_pid;
D = D_pid;
simOut = sim("models\plant_and_actuator.slx",...
            'SaveOutput','on',...
            'OutputSaveName','outSignals',...
            'SrcWorkspace','current');
time = simOut.get('tout');
outSignals = simOut.get('outSignals');
y = outSignals.signals(2).values;
error = outSignals.signals(1).values;
end
