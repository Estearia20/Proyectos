%-------------------------------
%-        Proyecto: PAMH       -
%-                             -
%- Equipo: E                   -
%- GR3                         -
%- Integrantes:                -
%-     David Herrera Castro    -
%-     David Monge Naranjo     -
%- Esteban Arias Rojas         -
%-------------------------------

close all;
clear all;

syms KP KD KI N S
s = tf("s");

% Lectura de los datos para estimación de modelo empirico
matriz = csvread('PAMH_3Set.CSV', 1, 0);

% Se separan cada una de las variables en vectores
% Los rangos en que se toman es para eliminar fragmentos no deseados al
% inicio y final del experimento
tiempo = matriz(74:2022,1);
angulo = matriz(74:2022,2);
estimulo = matriz(74:2022,3);

% abre el system identification, da un porcentaje de 86%
% systemIdentification('modelo.sid');

% Función de transferencia que da el System Identification
tf3 = tf([5.3807], [1 0.1984 15.6570]);

% Estimación a pie de la función de transferencia
gmax = 1.14;
gmax1 = 1.031;

T = 1.62;

delta = log(1.14/1.031);

xi = delta/(sqrt((2*pi)^2+delta^2));

k = gmax/1.7;

w = 2*pi/(T*sqrt(1-xi^2));

% Modelo estimado a pie
model = k*w^2/(s^2+2*xi*w*s+w^2);


% Transformacion de la funcion de transferencia a matrices de estado
Ac = [0, 1; -tf3.denominator{1}(3), -tf3.denominator{1}(2)];
Bc = [0; tf3.numerator{1}(3)];
Cc = [1, 0];

As = [Ac [0; 0]; -Cc 0];
Bs = [Bc; 0];

% Comprobacion de matriz de controlabilidad
Ms = [Bs As*Bs As^2*Bs];

rango_M = rank(Ms);

% Calculo del control IPD por medio de LQR

Q = [0.5 0 0; 0 6 0;  0 0 9];
R = 2.2;

Kss = lqr(As, Bs, Q, R);

% Ubicacion de los polos por lqr
polos = eig(As - Bs*Kss);

% Cosntantes del control
Ki = -Kss(3)
Kd = Kss(2)
Kp = Kss(1)
N = 20

% Funcion de transferencia del filtro utilizado para el termino derivativo
tf1 = tf([N 0],[1 N]);
