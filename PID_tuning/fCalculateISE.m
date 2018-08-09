function ise = CalculateISE(gain)
[~,~,error] = Sim_plant_and_actuator_function(gain(1), gain(2), gain(3));
ise = sum(error.^2);
end