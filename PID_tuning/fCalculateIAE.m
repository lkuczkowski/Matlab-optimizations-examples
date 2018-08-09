function iae = CalculateIAE(gain)
[~,~,error] = Sim_plant_and_actuator_function(gain(1), gain(2), gain(3));
iae = sum(abs(error));
end