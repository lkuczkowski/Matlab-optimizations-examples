function itae = fCalculateITAE(gain)
[time,~,error] = fSim_plant_and_actuator(gain(1), gain(2), gain(3));
itae = sum(time.*abs(error));