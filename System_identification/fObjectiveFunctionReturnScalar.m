function error = fObjectiveFunctionReturnScalar(lambda, xRef, phiRef)
m = lambda(1);
l = lambda(2);
I = lambda(3);

[x, phi] = fSimulateModel(m, l, I);

error = sum([ (xRef - x).^2;
              (phiRef - phi).^2 ]);
end