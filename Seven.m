% Constants given in the problem statement
nu12 = 0.2;
E1 = 55e9;
E2 = 10e9;
G12 = 4e9;
alpha = -1.5e-6;

% Create theta values from -90 to 90 degrees in increments of 15 degrees
theta_vals = -90:15:90;

% Initialize transformed reduced stiffness matrix and transformed compliance matrix
Q_bar = zeros(3,3,length(theta_vals));
S_bar = zeros(3,3,length(theta_vals));

% Calculate transformed reduced stiffness matrix and transformed compliance matrix for each theta
for i = 1:length(theta_vals)
    theta = deg2rad(theta_vals(i));
    c = cos(theta);
    s = sin(theta);
    T = [c^2, s^2, 2*c*s;         s^2, c^2, -2*c*s;         -c*s, c*s, c^2-s^2];
    Q_bar(:,:,i) = T * [1/E1, -nu12/E2, 0;                        -nu12/E2, 1/E2, 0;                        0, 0, 1/G12] * inv(T);
    S_bar(:,:,i) = inv(Q_bar(:,:,i));
end

% Plot transformed compliance matrix values as a function of theta
figure
hold on
for i = 1:3
    for j = 1:3
        plot(theta_vals,squeeze(S_bar(i,j,:)))
    end
end
xlabel('Angle (degrees)')
ylabel('Transformed Compliance Matrix Values')
legend('S_{11}', 'S_{12}', 'S_{13}', 'S_{21}', 'S_{22}', 'S_{23}', 'S_{31}', 'S_{32}', 'S_{33}')
