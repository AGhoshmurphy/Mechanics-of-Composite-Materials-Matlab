%% Maximum Strain Theory
sigma_x = -3;
nu12 = 0.26;
sigma_y = 3;
ult_1= 1260;
ult_2 = 61;
f_1t = 1032.86;
f_1c = -610;
f_2t = 40.11;
f_2c = -118;
% Calculate the longitudinal and transverse strains
epsilon_1 = (1/E1)*(-sigma_x - nu12*sigma_y);
epsilon_2 = (1/E2)*(-sigma_y - nu12*sigma_x);
gamma_12 = (1/G12)*tau_xy;

% Calculate the strain in the fiber direction
epsilon_fiber = cosd(theta)^2*epsilon_1 + sind(theta)^2*epsilon_2 + 2*cosd(theta)*sind(theta)*gamma_12;

% Calculate the strain in the transverse direction
epsilon_transverse = sind(theta)^2*epsilon_1 + cosd(theta)^2*epsilon_2 - 2*cosd(theta)*sind(theta)*gamma_12;

% Calculate the maximum positive and negative values of SR
SR_max_pos = min((ult_1/abs(epsilon_fiber)), (ult_2/abs(epsilon_transverse)));
SR_max_neg = max((ult_1/abs(epsilon_fiber)), (ult_2/abs(epsilon_transverse)));

% Display the results
disp("Maximum Strain Theory");
fprintf("SR_max_pos = %.2f MPa\n", SR_max_pos);
fprintf("SR_max_neg = %.2f MPa\n\n", SR_max_neg);
%% Tsai-Wu Theory

% Calculate the strength ratios
R_1 = ult_1/f_1t;
R_2 = ult_2/f_2t;

% Calculate the Tsai-Wu parameters
F1 = 1/(f_1t*f_1c);
F2 = 1/(f_2t*f_2c);
F11 = 1/(f_1t^2);
F22 = 1/(f_2t^2);
F12 = -0.5*sqrt(F1*F2);
x_bar = 0.8377;
y_bar= 0.246;
z_bar = 0.1235;
% Calculate the quadratic coefficients
A = F11*(sigma_x - x_bar)^2 + F22*(sigma_y - y_bar)^2 + 2*F12*(sigma_x - x_bar)*(sigma_y - y_bar);
B = 2*F11*(sigma_x - x_bar)*(tau_xy - z_bar) + 2*F22*(sigma_y - y_bar)*(tau_xy - z_bar) + 2*F12*(sigma_x - x_bar)*(sigma_y - y_bar);
C = F11*(tau_xy - z_bar)^2 + F22*(tau_xy - z_bar)^2 + 2*F12*(sigma_x - x_bar)*(tau_xy - z_bar)*(sigma_y - y_bar) - 1;

% Solve the quadratic equation
SR_max_pos = (-B + sqrt(B^2 - 4*A*C))/(2*A);
SR_max_neg = (-B - sqrt(B^2 - 4*A*C))/(2*A);

% Display the results
disp("Tsai-Wu Theory");
fprintf("SR_max_pos = %.2f MPa\n", SR_max_pos);
fprintf("SR_max_neg = %.2f MPa\n", SR_max_neg);