% Obtencion del modelo
% File: Grua_Modelo3(22s)

% Se limpia el espacio de trabajo
close all
clc

% Se lee el archivo 
data = csvread('Grua_Modelo3(22s).csv', 1, 0);
data2 = csvread('Grua_Modelo4(55s).csv', 1, 0);
data3 = csvread('Grua_Modelo1(304s).csv', 1, 0);

% Se ordenan los datos del archivo de 22 s
tiempo = data(:,1);
entrada = data(:,2);
angulo = data(:,3);
posicion = data(:,4);

% Se ordenan los datos del archivo de 55 s
tiempo2 = data2(:,1);
entrada2 = data2(:,2);
angulo2 = data2(:,3);
posicion2 = data2(:,4);

% Se ordenan los datos del archivo de 304 s
tiempo3 = data3(:,1);
entrada3 = data3(:,2);
angulo3 = data3(:,3);
posicion3 = data3(:,4);

% Se grafican los datos
figure('name', 'Datos de la planta para posicion')
plot(data(:,1), data(:,4))

figure('name', 'Datos de la planta para angulo')
plot(data(:,1), data(:,3))

figure('name', 'Datos de la planta para entrada')
plot(data(:,1), data(:,2))

% Funcion de transferencia obtenida usando
%systemIdentification('planta.sid')

% A partir del systemIdentification se obtiene para la posicion y el angulo
% POSICION
%tf_pos = tf([0.2334], [1 9.735 0]); %ESTEBAN
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

za = num_d(3)/ka;

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
       
C_deg_s = [ka*za ka];       

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
         ka*kt*za];
     
C_sys = [1 0 0 0;
         0 1 0 0];
     
D = 0;

% Funciones del sistema
sys = ss(A_sys, B_sys, C_sys, [0; 0]);

funciones = tf(sys);

