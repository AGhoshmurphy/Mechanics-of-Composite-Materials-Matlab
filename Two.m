% Calculate the transformed compliance matrix [S']
Q_inv = inv(Q); % Inverse of the reduced stiffness matrix [Q]

% Calculate the elements of the transformed compliance matrix [S']
S11p = Q_inv(1,1);
S12p = Q_inv(1,2);
S22p = Q_inv(2,2);
S66p = Q_inv(3,3);

% Assemble the transformed compliance matrix [S']
Sp = [S11p, S12p, 0;
      S12p, S22p, 0;
         0,    0, S66p];

% Display the transformed compliance matrix [S']
disp("[S'] = ");
disp(Sp);