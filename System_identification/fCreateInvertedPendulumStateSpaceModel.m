function model = fCreateInvertedPendulumStateSpaceModel(m, l, I)
M = 0.5;
b = 0.1;
g = 9.8;

den = I*(M+m)+M*m*l^2;
A = [0      1              0           0;
     0 -(I+m*l^2)*b/den  (m^2*g*l^2)/den   0;
     0      0              0           1;
     0 -(m*l*b)/den       m*g*l*(M+m)/den  0];
B = [     0;
     (I+m*l^2)/den;
          0;
        m*l/den];
C = [1 0 0 0;
     0 0 1 0];
D = [0;
     0];

states = {'x' 'x_dot' 'phi' 'phi_dot'};
inputs = {'u'};
outputs = {'x'; 'phi'};

model = ss(A,B,C,D,'statename',states,'inputname',inputs,'outputname',outputs);
end