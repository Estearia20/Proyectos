 %                       0.23472
 % Posicion(s)=  -------------------------
 %                     s^2 + 9.678 s

 %               -0.3469 s - 0.3444
 % Angulo(s)=  -----------------------
 %             s^2 + 0.01053 s + 35.33
 
posicion = tf([0.23472], [1 9.678 0]);
angulo = tf([-0.3469 -0.3444], [1 0.01053 35.33]);

[num_p, den_p] = tfdata(posicion, 'v');
[num_a, den_a] = tfdata(angulo, 'v');

k_techo = 0.97;

A = [0 0 1 0; 0 0 0 1; 0 0 -den_p(2) 0; 0 -den_a(3) 0 -den_a(2)];
B = [0; num_a(2); num_p(3); k_techo*num_a(2)*(num_a(3)/num_a(2))];
C = [1 0 0 0; 0 1 0 0];

sys = ss(A, B, C, [0; 0]);

funciones = tf(sys);


As = [A [0; 0; 0; 0]; -C(1,:) 0];
Bs = [B; 0];


% Ubicacion de los polos 
Ps = [-2+1i -2-1i -12 -12 -15];

% Ps = [-2+1.2i -2-1.2i -3 -1 -2];

% Se ubican los polos por medio de ackermann
Ks = acker(As, Bs, Ps);
K1 = Ks(1:4);
Ki1  = -Ks(5);




% Calculo del control IPD por medio de LQR

Q = [70 0 0 0 0; 0 20 0 0 0; 0 0 0.3 0 0; 0 0 0 0.4 0; 0 0 0 0 100];
R = 0.3;

% Q = [70 0 0 0 0; 0 20 0 0 0;  0 0 0.3 0 0; 0 0 0 0.4 0; 0 0 0 0 100];
% R = 0.3;

Kss = lqr(As, Bs, Q, R);

% Ubicacion de los polos por lqr
polos = eig(As - Bs*Kss)

% Cosntantes del control
Ki2 = -Kss(5);
K2 = Kss(1:4);


% Valores a usar

Ki = Ki2;
K = K2;
