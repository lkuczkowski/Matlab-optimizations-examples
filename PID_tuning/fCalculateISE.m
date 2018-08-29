function ise = fCalculateISE(gain)
[~,~,error] = fSim_plant_and_actuator(gain(1), gain(2), gain(3));
ise = sum(error.^2);
end