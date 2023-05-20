% Given data
theta_range = -90:15:90; % range of fiber angles in degrees
E1 = 204; % longitudinal elastic modulus in GPa
E2 = 18.50; % transverse elastic modulus in GPa
nu12 = 0.26; % major Poisson's ratio
G12 = 5.59; % shear modulus in GPa

% Convert fiber angle from degrees to radians
theta_rad = deg2rad(theta_range);

% Calculate the engineering constant of the lamina for each fiber angle
Q11 = E1 ./ (1 - nu12^2 .* cos(theta_rad).^2);
Q12 = (nu12 .* E1) ./ (1 - nu12^2 .* cos(theta_rad).^2);
Q21 = Q12;
Q22 = E2 ./ (1 - nu12^2 .* cos(theta_rad).^2);
Q44 = G12;

% Plot the results
figure;
subplot(2,2,1);
plot(theta_range,Q11);
xlabel('Fiber angle, degrees');
ylabel('Q_{11}, GPa');
title('Longitudinal modulus');
grid on;

subplot(2,2,2);
plot(theta_range,Q12);
xlabel('Fiber angle, degrees');
ylabel('Q_{12}, GPa');
title('Shear modulus');
grid on;

subplot(2,2,3);
plot(theta_range,Q22);
xlabel('Fiber angle, degrees');
ylabel('Q_{22}, GPa');
title('Transverse modulus');
grid on;


