% Material properties of the lamina
E1 = 204;   % GPa
E2 = 18.5;  % GPa
v12 = 0.26;
v21 = v12 * E1 / E2;
G12 = 5.59; % GPa

% Calculate reduced stiffness matrix [Q]
Q11 = E1 / (1 - v12 * v21);
Q12 = v21 * E2 / (1 - v12 * v21);
Q21 = v12 * E1 / (1 - v12 * v21);
Q22 = E2 / (1 - v12 * v21);
Q66 = G12;
Q = [Q11 Q12 0; Q21 Q22 0; 0 0 Q66];

% Calculate compliance matrix [S]
S11 = 1 / E1;
S12 = -v12 / E1;
S21 = -v21 / E2;
S22 = 1 / E2;
S66 = 1 / G12;
S = [S11 S12 0; S21 S22 0; 0 0 S66];
% Display the [Q] and [S] matrices
disp("[Q] = ");
disp(Q);
disp("[S] = ");
disp(S);
