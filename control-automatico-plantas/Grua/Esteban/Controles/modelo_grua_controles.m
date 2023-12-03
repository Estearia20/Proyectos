close all
s = tf('s');
matriz1 = csvread('Grua_Modelo1(304s).CSV',1,0); %Se exportan los datos obtenidos de la planta

matriz2 = csvread('Grua_Modelo2(18s).CSV',1,0); %Se exportan los datos obtenidos de la planta

matriz3 = csvread('Grua_Modelo3(22s).CSV',1,0);

matriz4 = csvread('Grua_Modelo4(55s).CSV',1,0);


tiempo1 = matriz1(22:2772,1);        
entrada1 = matriz1(22:2772,2);
angulo1 = matriz1(22:2772,3);
posicion1 = matriz1(22:2772,4);

tiempo2 = matriz2(:,1);        
entrada2 = matriz2(:,2);
angulo2 = matriz2(:,3);
posicion2 = matriz2(:,4);

tiempo3 = matriz3(:,1);        
entrada3 = matriz3(:,2);
angulo3 = matriz3(:,3);
posicion3 = matriz3(:,4);


tiempo4 = matriz4(:,1);        
entrada4 = matriz4(:,2);
angulo4 = matriz4(:,3);
posicion4 = matriz4(:,4);

%systemIdentification('ident_grua.sid');     % Abre el system identification, de donde se sacaron los modelos%


 %                       0.23472
 % Posicion(s)=  -------------------------
 %                     s^2 + 9.678 s

tf_posicion304 = tf([0.23472], [1 9.678 0]);
[nump, denp]=tfdata(tf_posicion304,'v');

 %               -0.3469 s - 0.3444
 % Angulo(s)=  -----------------------
 %             s^2 + 0.01053 s + 35.33

 tf_angulo304 = tf([-0.3469 -0.3444],[1 0.01053 35.33]);
 [numa, dena]=tfdata(tf_angulo304,'v');
 
 

 
 %Se sacan las matrices de estado para la posicion
 Ap=[0 0 1 0;0 0 0 0; 0 0 -denp(2) 0;0 0 0 0];
 Bp=[0;0;nump(3);0];
 Cp=[1 0 0 0];
 
 %Se sacan las matrices de estado para el ángulo
 g_ktecho = 0.9756;
 Aa=[0 0 0 0;0 0 0 1; 0 0 0 0; 0 -dena(3) 0 -dena(2)];
 Bp=[0;numa(2);0; g_ktecho*numa(3)];
 Cp=[0 1 0 0];
 
 
 %Modelo SIMO completo, uniendo posicion y ángulo
 At=[0 0 1 0;0 0 0 1;0 0 -denp(2) 0; 0 -dena(3) 0 -dena(2)];
 Bt=[0;numa(2);nump(3);g_ktecho*numa(3)];
 Ct=[1 0 0 0;0 1 0 0];
 Ctc=[1 0 0 0];
%Verificaciones
sys = ss(At, Bt, Ct, [0; 0]);
funciones = tf(sys);




%Se extienden las matrices
As = [At, zeros(4, 1); -Ctc, 0];
Bs = [Bt; 0];

%%% Por Ackermann
Ps =  [-2+1i -2-1i -3 -1 -2]; % Ubicacion de los polos

Ks = acker(As, Bs, Ps);
K = Ks(1:4);
Ki  = -Ks(5);

%%% Por LQR
Q = [70 0 0 0 0; 0 20 0 0 0;  0 0 0.3 0 0; 0 0 0 0.4 0; 0 0 0 0 100];
R = 0.3;

Kss = lqr(As, Bs, Q, R);

% Constantes del control
Ki_lqr = -Kss(5);
K_lqr  = Kss(1:4);




