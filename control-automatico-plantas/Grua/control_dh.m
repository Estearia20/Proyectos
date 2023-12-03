% Obtencion del modelo
% File: Grua_Modelo3(22s)

% Se limpia el espacio de trabajo
close all
clc

tf_pos = tf([0.024254/0.10333], [1 1/0.10333 0]);
[num_p, den_p] = tfdata(tf_pos, 'v');

% Valores de la funcion de transferencia
ax = -den_p(2);
kp = num_p(3);

% Matriz del espacio de estados
A_pos = [0 0 1  0;
         0 0 0  0;
         0 0 ax 0;
         0 0 0  0];

B_pos = [0;
         0;
         kp;
         0];
     
C_pos = [1 0 0 0];

% Matrices pequeñas de posicion 
A_pos_s = [0 1;
           0 ax];
     
B_pos_s = [0;
           kp];
       
C_pos_s = [1 0];       

D = 0;

% Se valida la funcion obtenida desde el modelo
[num_pv, den_pv] = ss2tf(A_pos_s, B_pos_s, C_pos_s, D);
tf_pos_v = tf(num_pv, den_pv);

% ANGULO
tf_deg = tf([-0.3469 -0.3444], [1 0.01053 35.33]);
[num_d, den_d] = tfdata(tf_deg, 'v');

% Valores de la funcion de transferencia
wn = sqrt(den_d(3));

zeta = den_d(2)/(2*wn);

ka = num_d(2);

za = -num_d(3)/ka;

kt = 0.9756;

% Matriz del espacio de estados
A_deg = [0 0     0  0;
         0 0     0  1;
         0 0     0  0;
         0 -wn^2 0  -2*zeta*wn];

B_deg = [0;
         ka;
         0;
         ka*kt*za];
     
C_deg = [0 1 0 0];

% Matrices pequeñas de angulo
A_deg_s = [0      1;
           -wn^2 -2*zeta*wn];
      
B_deg_s = [0;
           1];
       
C_deg_s = [-ka*za ka];       

% Se valida la funcion obtenida desde el modelo
[num_dv, den_dv] = ss2tf(A_deg_s, B_deg_s, C_deg_s, D);
tf_deg_v = tf(num_dv, den_dv);

% Matriz de espacio de estados del sistema
A_sys = [0 0     1  0;
         0 0     0  1;
         0 0     ax 0;
         0 -wn^2 0  -2*zeta*wn];
     
B_sys = [0;
         ka;
         kp;
         -ka*kt*za];
     
C_sys = [1 0 0 0;
         0 1 0 0];
     
C_sys_cortada = [1 0 0 0];
     
D = [0;
     0];

% Extension de las matrices
As = [A_sys [0; 0; 0; 0]; -C_sys_cortada 0];
Bs = [B_sys; 0];
 
% DISEÑO DE LOS CONTROLES

% UBICACION DE POLOS
Ps = [-2+1.2i -2-1.2i -3 -1 -2];

% Se ubican los polos por medio de ackermann
Ks = acker(As, Bs, Ps);
K14 = Ks(1:4);
K5  = -Ks(5);

% 
% OPCIONES PARA UBICACION DE POLOS
%

% ts=6, mp=0, ess=0, ang=-0.11
% Ps = [-2+1.2i -2-1.2i -3 -1 -2];

% LQR
Q = [70  0  0   0   0;
     0   20 0   0   0;
     0   0  0.3 0   0;
     0   0  0   0.4 0;
     0   0  0   0   100];
 
R = 0.3;

Kss = lqr(As, Bs, Q, R);
K14 = Kss(1:4);
K5 = -Kss(5);

%
%   OPCIONES PARA LQR
%

% ts=6, mp=0.515, ess=0, ang=-0.12
%Q = [70  0  0   0   0;
%     0   20 0   0   0;
%     0   0  0.3 0   0;
%     0   0  0   0.4 0;
%     0   0  0   0   100];
 
%R = 0.3;






