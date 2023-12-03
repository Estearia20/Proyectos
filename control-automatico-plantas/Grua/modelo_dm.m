s = tf("s");

matriz = csvread("Grua_Modelo4(55s).csv", 1, 0);

matriz_val = csvread("Grua_Modelo1(304s).csv", 1, 0);

tiempo = matriz(:, 1);
entrada = matriz(:, 2);
angulo = matriz(:, 3);
posicion = matriz(:, 4);

tiempo_val = matriz_val(:, 1);
entrada_val = matriz_val(:, 2);
angulo_val = matriz_val(:, 3);
posicion_val = matriz_val(:, 4);

% Se grafica los datos
figure('name', 'Datos de la planta para posicion')
plot(tiempo, posicion)

figure('name', 'Datos de la planta para angulo')
plot(tiempo, angulo)

figure('name', 'Datos de la planta para entrada')
plot(tiempo, entrada)

% systemIdentification()

% funcion de posicion
tf_22 = tf([0.23472], [1 9.678 0]);

% funcion de angulo
tf_300 = tf([-0.3573 -0.4939], [1 0.0154 35.32]);

% calculos de las matrices posicion

[num_p, den_p] = tfdata(tf_22, 'v');
[num_a, den_a] = tfdata(tf_300, 'v');

k_techo = 0.97;

A = [0 0 1 0; 0 0 0 1; 0 0 -den_p(2) 0; 0 -den_a(3) 0 -den_a(2)];
B = [0; num_a(2); num_p(3); k_techo*num_a(2)*(num_a(3)/num_a(2))];
C = [1 0 0 0; 0 1 0 0];

sys = ss(A, B, C, [0; 0]);

funciones = tf(sys);

 %                       0.23472
 % Posicion(s)=  -------------------------
 %                     s^2 + 9.678 s

 %               -0.3469 s - 0.3444
 % Angulo(s)=  -----------------------
 %             s^2 + 0.01053 s + 35.33
