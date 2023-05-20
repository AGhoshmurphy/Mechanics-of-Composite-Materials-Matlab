% Define necessary variables
theta = 80; % fiber angle in degrees
SR = 1; % applied load in MPa
Q11 = E1/(1 - v12*v21);
Q12 = v12*E2/(1 - v12*v21);
Q21 = v21*E1/(1 - v12*v21);
Q22 = E2/(1 - v12*v21);
Q66 = G12;

% Convert angle to radians
theta = theta*pi/180;

% Calculate transformation matrix
T = [cos(theta)^2, sin(theta)^2, 2*sin(theta)*cos(theta);
     sin(theta)^2, cos(theta)^2, -2*sin(theta)*cos(theta);
     -sin(theta)*cos(theta), sin(theta)*cos(theta), cos(theta)^2-sin(theta)^2];

% Calculate reduced stiffness matrix
Q_bar = inv(T) * [Q11, Q12, 0; Q21, Q22, 0; 0, 0, Q66] * T^-1;

% Calculate compliance matrix
S = inv(Q_bar);

% Calculate transformed compliance matrix
S_bar = T * S * T^-1;

% Calculate global strains
eps_x = -1/SR * (S_bar(1,1)*(-3) + S_bar(1,2)*3 + S_bar(1,3)*2);
eps_y = -1/SR * (S_bar(2,1)*(-3) + S_bar(2,2)*3 + S_bar(2,3)*2);
gamma_xy = -1/SR * (S_bar(3,1)*(-3) + S_bar(3,2)*3 + S_bar(3,3)*2);

% Calculate local strains
eps_1 = cos(theta)^2 * eps_x + sin(theta)^2 * eps_y + 2*sin(theta)*cos(theta) * gamma_xy;
eps_2 = sin(theta)^2 * eps_x + cos(theta)^2 * eps_y - 2*sin(theta)*cos(theta) * gamma_xy;
gamma_12 = -sin(theta)*cos(theta) * eps_x + sin(theta)*cos(theta) * eps_y + (cos(theta)^2-sin(theta)^2) * gamma_xy;

% Calculate engineering constants
Q_bar_inv = inv(Q_bar);
E_11 = 1/Q_bar_inv(1,1);
v_12 = -Q_bar_inv(1,2)*E_11;
G_12 = 1/Q_bar_inv(3,3);

% Display results
disp("Reduced stiffness matrix [Q_bar]:")
disp(Q_bar)
disp("Compliance matrix [S]:")
disp(S)
disp("Transformed compliance matrix [S_bar]:")
disp(S_bar)
disp("Global strains:")
disp(["eps_x = ", eps_x])
disp(["eps_y = ", eps_y])
disp(["gamma_xy = ", gamma_xy])
disp("Local strains:")
disp(["eps_1 = ", eps_1])
disp(["eps_2 = ", eps_2])
disp(["gamma_12 = ", gamma_12])
disp("Engineering constants:")
disp(["E_11 = ", E_11])
disp(["v_12 = ", v_12])
disp(["G_12 = ", G_12])
