function [x, phi] = fSimulateModel(m, l, I)
    model = fCreateInvertedPendulumStateSpaceModel(m, l, I);
    u = ones(1, 101)*0.2;
    t = 0:0.01:1;
    out = lsim(model, u, t);
    x = out(:,1);
    phi = out(:,2);
end