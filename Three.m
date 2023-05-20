% Given data
theta = 80; % fiber angle
sig_x = -3; % MPa
sig_y = 3; % MPa
tau_xy = 2; % MPa

% Convert fiber angle from degrees to radians
theta = theta*pi/180;

% Calculate the engineering constants
E1 = 204; % GPa
E2 = 18.5; % GPa
G12 = 5.59; % GPa
v12 = 0.26; % major Poisson's ratio

% Calculate the reduced stiffness matrix [Q]
Q11 = E1/(1-v12*v12);
Q12 = (v12*E1)/(1-v12*v12);
Q22 = E2/(1-v12*v12);
Q66 = G12;
Q = [Q11, Q12, 0;
     Q12, Q22, 0;
       0,   0, Q66];

% Calculate the transformed compliance matrix [S']
Q_inv = inv(Q); % Inverse of the reduced stiffness matrix [Q]
S11p = Q_inv(1,1);
S12p = Q_inv(1,2);
S22p = Q_inv(2,2);
S66p = Q_inv(3,3);
Sp = [S11p, S12p, 0;
      S12p, S22p, 0;
         0,    0, S66p];

% Calculate the compliance matrix [S]
S = inv(Sp);

% Calculate the transformation matrix [T]
T = [cos(theta)^2, sin(theta)^2, 2*sin(theta)*cos(theta);
     sin(theta)^2, cos(theta)^2, -2*sin(theta)*cos(theta);
     -sin(theta)*cos(theta), sin(theta)*cos(theta), cos(theta)^2-sin(theta)^2];

% Calculate the global strains
sigma = [sig_x; sig_y; tau_xy];
epsilon_global = inv(Q) * sigma;

% Calculate the local strains
epsilon_local = T * epsilon_global;

% Display the results
disp("Global Strains:")
disp(epsilon_global)
disp("Local Strains:")
disp(epsilon_local)
