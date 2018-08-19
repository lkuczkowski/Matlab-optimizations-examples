function [x, phi] = fSimulateModel(m, l, I)
    model = fCreateInvertedPendulumStateSpaceModel(m, l, I);
    u = ones(1, 101);
    t = 0:100;
    out = lsim(model, u, t);
    x = out(:,1);
    phi = out(:,2);
end