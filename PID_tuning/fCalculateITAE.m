function itae = CalculateITAE(gain)
[time,~,error] = Sim_plant_and_actuator_function(gain(1), gain(2), gain(3));
itae = sum(time.*abs(error));