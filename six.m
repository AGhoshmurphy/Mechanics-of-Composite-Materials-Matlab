% Given data
theta = 80; % fiber angle
T = -150; % temperature change in degrees Celsius
sigma_x = -3; % MPa
sigma_y = 3; % MPa
tau_xy = 2; % MPa

% Material properties from Table 2
E1 = 204; % GPa
E2 = 18.50; % GPa
G12 = 5.59; % GPa
v12 = 0.26;
alpha1 = 8.6e-6; % /°C
alpha2 = 30.3e-6; % /°C

% Convert temperature change to strain
epsilon_T1 = alpha1 * T;
epsilon_T2 = alpha2 * T;

% Convert stresses to strains using global engineering constants
Q = [E1/(1-v12*v12), v12*E2/(1-v12*v12), 0; v12*E2/(1-v12*v12), E2/(1-v12*v12), 0; 0, 0, G12];
epsilon_global = Q * [sigma_x; sigma_y; tau_xy];

% Convert global strains to local strains
theta_rad = deg2rad(theta);
T = [cos(theta_rad)^2, sin(theta_rad)^2, 2*sin(theta_rad)*cos(theta_rad); sin(theta_rad)^2, cos(theta_rad)^2, -2*sin(theta_rad)*cos(theta_rad); -sin(theta_rad)*cos(theta_rad), sin(theta_rad)*cos(theta_rad), cos(theta_rad)^2-sin(theta_rad)^2];
epsilon_local = T \ epsilon_global;

% Add thermal strains to global and local strains
epsilon_global = epsilon_global + [epsilon_T1; epsilon_T2; 0];
epsilon_local = epsilon_local + [epsilon_T1; epsilon_T2; 0];

% Display the results
fprintf("Global strains due to stress and temperature change:\n");
fprintf("epsilon_x = %.6f\n", epsilon_global(1));
fprintf("epsilon_y = %.6f\n", epsilon_global(2));
fprintf("gamma_xy = %.6f\n", epsilon_global(3));
fprintf("\nLocal strains due to stress and temperature change:\n");
fprintf("epsilon_1 = %.6f\n", epsilon_local(1));
fprintf("epsilon_2 = %.6f\n", epsilon_local(2));
fprintf("gamma_12 = %.6f\n", epsilon_local(3));
