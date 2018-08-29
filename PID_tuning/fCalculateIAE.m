function iae = fCalculateIAE(gain)
[~,~,error] = fSim_plant_and_actuator(gain(1), gain(2), gain(3));
iae = sum(abs(error));
end