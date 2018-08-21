function errorVector = fObjectiveFunctionReturnVector(lambda, desiredOutput)
m = lambda(1);
l = lambda(2);
I = lambda(3);

systemOutput = fSimulateModel(m, l, I);

errorVector = [ desiredOutput(1) - systemOutput(1);
                desiredOutput(2) - systemOutput(2) ];

end