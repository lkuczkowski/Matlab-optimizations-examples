function fPlotResponseComparison(mRef, lRef, Iref, m, l, I)

[xRef, phiRef] = fSimulateModel(mRef, lRef, Iref);
[x, phi] = fSimulateModel(m, l, I);

time = 0:0.01:1;

subplot(2,1,1);
xlabel('Time [s]');
ylabel('Cart position');
p1 = plot(time, xRef, time, x, '--');
title('Open-loop step response for cart position (x)');
p1(1).LineWidth = 2;
p1(2).Marker = 'o';
legend('Reference cart position', 'Estimated cart position');

subplot(2,1,2);
xlabel('Time [s]');
ylabel('Angle from vertical');
p2 = plot(time, phiRef, time, phi, '--');
title('Open-loop step response for pendulum angle from vertical (phi)');
p2(1).LineWidth = 2;
p2(2).Marker = 'o';
legend('Reference angle', 'Estimated angle');

end

