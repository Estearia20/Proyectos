%-------------------------------
%-        Proyecto: PAMH       -
%-                             -
%- Equipo: E                   -
%- GR3                         -
%- Integrantes:                -
%-    David Herrera Castro     -
%-    David Monge Naranjo      -
%-    Esteban Arias Rojas      -
%------------------------------- 

close all
s = tf('s');
syms KP KI KD N S
matriz = csvread('PAMH_3Set.CSV', 1, 0); %Se exportan los datos obtenidos de la planta

tiempo = matriz(74:2022,1);        
angulo = matriz(74:2022,2);
estimulo = matriz(74:2022,3);

tf3 = tf([5.3807], [1 0.1984 15.6570]);  % Se obtiene la función de transferencia por medio del system identification

%systemIdentification('modelo.sid');     % Abre el system identification, da un porcentaje de 86%

%Se realiza una comprobación matemática para la función de tranferencia
%obtenida del system identification

gmax = 1.14;
gmax1 = 1.031;
T = 1.62;

delta = log(1.14/1.031);

xi = delta/(sqrt((2*pi)^2+delta^2));
k = 0.583/1.7;

w = 2*pi/(T*sqrt(1-xi^2));

model = k*w^2/(s^2+2*xi*w*s+w^2);  % Función que se obtiene al realizar el procedimiento matemático

%Se grafica la función obtenida por el system identification y la obtenida
%por el procedimiento matemático
figure(1)
step(tf3);
hold on
step(model, 'y');
hold on
legend('Modelo', 'Matemático')
xlabel('Time');
ylabel('Ángulo (rad)');
xlim([0, 40])
ylim([0, 1.4])
hold off


%Por medio de la herramienta sisotool, utilizando el tuneo del controlador
%por IMC , se obtuvo la siguente función para el controlador

 %                      0.23814 (s^2 + 0.1984s + 15.66)
 %             C(s)=    -------------------------------
 %                                s (s+2.247)

%Se guarda el controlador como función de transferencia para poder utilizarla 
C= tf([0.23814 0.23814*0.1984 0.23814*15.66], [1 2.247 0]);

%Se realiza la descomposición en paralelo
[num, den]=tfdata(C,'v');
PID=KP+KI/S+(KD*N*S)/(S+N);
collect(PID);
N=den(2);         %Se obtiene el valor de N
KI=num(3)/N;      %Se obtiene el valor de Ki
KP=(num(2)-KI)/N; %Se obtiene el valor de Kp
KD=(num(1)-KP)/N; %Se obtiene el valor de Kd
%Se compone el controlador nuevamente para verificar que la función
%obtenida se la misma que la obtenida del sisotool
PID_IMC=zpk(KP+KI/s+(KD*N*s)/(N+s));

%Se cambió el valor de N manualmente, ya que a la hora de hacer la
%implementación física ya que la planta no cumplia los requerimientos,
%por lo que aumentando el N ya se obtiene una mejor respuesta.
N=19;  


%Por lo tanto los valores utilizados en la planta física son:
%Kp=-0.7176
%Ki=1.6597
%Kd=0.4253
%N=19
 
