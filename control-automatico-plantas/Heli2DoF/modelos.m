% Obtencion del modelo del HELI2DoF

% Se limpia el espacio de trabajo
close all
clc

% Se lee el archivo 
data_p1 = csvread('Exp_PITCH_May19_1.csv', 1, 0);   % FILE 1
data_y1 = csvread('Exp_YAW_May19_1.csv', 1, 0);     % FILE 2

data_p2 = csvread('Exp_PITCH_May19_2.csv', 1, 0);   % FILE 3
data_y2 = csvread('Exp_YAW_May19_2.csv', 1, 0);     % FILE 4

data_p3 = csvread('Exp_PITCH_May17.csv', 1, 0);     % FILE 5
data_y3 = csvread('Exp_YAW_May17.csv', 1, 0);       % FILE 6

% DATOS DE PITCH

% FILE 1
t_p1 = data_p1(22:624,1);
p_p1 = data_p1(22:624,3);
y_p1 = data_p1(22:624,2);
ep_p1 = data_p1(22:624,5);

% FILE 3
t_p2 = data_p2(22:624,1);
p_p2 = data_p2(22:624,3);
y_p2 = data_p2(22:624,2);
ep_p2 = data_p2(22:624,5);

% FILE 5
t_p3 = data_p3(22:624,1);
p_p3 = data_p3(22:624,3);
y_p3 = data_p1(22:624,2);
ep_p3 = data_p3(22:624,5);


% DATOS DE PITCH CORTADOS APROXIMADAMENTE EN 10

% FILE 1
t_p1c = data_p1(22:472,1);
p_p1c = data_p1(22:472,3);
y_p1c = data_p1(22:472,2);
ep_p1c = data_p1(22:472,5);

% FILE 3
t_p2c = data_p2(22:472,1);
p_p2c = data_p2(22:472,3);
y_p2c = data_p2(22:472,2);
ep_p2c = data_p2(22:472,5);

% FILE 5
t_p3c = data_p3(22:472,1);
p_p3c = data_p3(22:472,3);
y_p3c = data_p1(22:472,2);
ep_p3c = data_p3(22:472,5);


% DATOS DE YAW

% FILE 2
t_y1 = data_y1(22:end,1);
y_y1 = data_y1(22:end,3);
ey_y1 = data_y1(22:end,4);

% FILE 4
t_y2 = data_y2(22:end,1);
y_y2 = data_y2(22:end,3);
ey_y2 = data_y2(22:end,4);

% FILE 6
t_y3 = data_y3(22:end,1);
y_y3 = data_y3(22:end,3);
ey_y3 = data_y3(22:end,4);

% MODELO PITCH/PITCH

%tf_pitch = tf([0.55639 0.55639*0.06272],[1 0.7413 1.052]);
tf_pitch = tf([0.036997 0.036997*1.138],[1 0.6029 1.093]);
[num_pitch, den_pitch] = tfdata(tf_pitch,'v');

Apitch_p = [0 1; den_pitch(3) -den_pitch(2)];
Bpitch_p = [0; 1];
Cpitch_p = [num_pitch(3) num_pitch(2)];
Dpitch_p = 0;

pitchFCO = canon(tf_pitch, "companion");

pitchFCC.a = pitchFCO.a';
pitchFCC.b = pitchFCO.c';
pitchFCC.c = pitchFCO.b';

%Se verifica que se recupera la función de transferencia original
tf(ss(pitchFCC.a,pitchFCC.b,pitchFCC.c,0));

Apitch_ps = [0 0 0 0; 0 0 0 1; 0 0 0 0; 0 den_pitch(3) 0 -den_pitch(2)]; 
Bpitch_ps = [0; pitchFCC.b(1); 0; pitchFCC.b(2)];
Cpitch_ps = [0 1 0 0];

% MODELO YAW/YAW

tf_yaw = tf([-0.046437],[1 0.04661 0]);
[num_yaw, den_yaw] = tfdata(tf_yaw,'v');

Ayaw_p=[0 0 0 0; 0 0 0 1; 0 0 0 0; 0 0 0 -den_yaw(2)];
Byaw_p=[0; 0; 0; num_yaw(3)];
Cyaw_p=[0 1 0 0];

%Se verifica lo realizado para el angulo yaw
tf(ss(Ayaw_p,Byaw_p,Cyaw_p,0));

% MODELO YAW/PITCH

tf_combi = tf([0.01311], [1 0]);
[num_combi, den_combi] = tfdata(tf_combi, 'v');

Ayaw_pitch = [0 0 0 0; 0 0 0 1; 0 0 0 0; 0 0 0 0];
Byaw_pitch = [0; num_combi(2); 0; 0];
Cyaw_pitch = [0 1 0 0];

%Se verifica lo realizado para el angulo yaw con respecto a tension pitch
tf(ss(Ayaw_pitch, Byaw_pitch, Cyaw_pitch, 0));

% MODELO MIMO

A_mimo = [0 0 1 0; 0 0 0 1; -den_pitch(3) 0 -den_pitch(2) 0; 0 0 0 -den_yaw(2)];
B_mimo = [pitchFCC.b(1) 0; num_combi(2) 0; pitchFCC.b(2) 0; 0 num_yaw(3)];
C_mimo = [1 0 0 0; 0 1 0 0];

%Se verifican las tf a partir del MIMO
tf(ss(A_mimo, B_mimo, C_mimo, 0))


%Se extienden las matrices
As = [A_mimo, zeros(4,2); -C_mimo, zeros(2,2)];
Bs = [B_mimo; zeros(2,2)];

%%% Por Ackermann (Ubicación de Polos)
Ps =  [-0.8+0.16i -0.8-0.16i -0.7 -0.9 -1.4 -1.65]; % Ubicacion de los polos

Ks = place(As, Bs, Ps);
Ki = -Ks(:, 5:6);
K = Ks(:, 1:4);

%%% Por LQR
Q = [200 0 0 0 0 0; 0 20 0 0 0 0; 0 0 0.1 0 0 0; 0 0 0 5 0 0; 0 0 0 0 100 0; 0 0 0 0 0 80];
R = 0.1;
Kss = lqr(As, Bs, Q, R);
Ki_lqr = -Kss(:, 5:6);
K_lqr = Kss(:, 1:4);

%LQR DEFINITIVO
%Q = [200 0 0 0 0 0; 0 20 0 0 0 0; 0 0 0.1 0 0 0; 0 0 0 5 0 0; 0 0 0 0 100 0; 0 0 0 0 0 80];
%R = 0.1;





