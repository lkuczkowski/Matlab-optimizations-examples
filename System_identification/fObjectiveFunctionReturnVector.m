function errorVector = fObjectiveFunctionReturnVector(lambda, xRef, phiRef)
m = lambda(1);
l = lambda(2);
I = lambda(3);

[x, phi] = fSimulateModel(m, l, I);

errorVector = [ xRef - x;
                phiRef - phi ];
end