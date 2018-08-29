function fPlot_result_PID(t, y1, y2)
figure;
subplot(2, 1, 1);
plot(t, y1,'r','LineWidth',2)
title('Step response with gains: P = 0.9; I = 0.1; D = 3')
xlabel('Time [s]')
ylabel('y(t)')

subplot(2,1,2);
plot(t, y2,'b','LineWidth',2)
title('Step respones after PID gains optimization')
xlabel('Time [s]')
ylabel('y(t)')
end