matriz = csvread('MotorCD_GRE.csv',1,0);

t1 = matriz(1:288,1);
t2 = matriz(288:688,1);
t3 = matriz(688:1165,1);

velocidad1 = matriz(1:288,2);
velocidad2 = matriz(288:688,2);
velocidad3 = matriz(688:1165,2);

corriente1 = matriz(1:288,3);
corriente2 = matriz(288:688,3);
corriente3 = matriz(688:1165,3);

entrada1 = matriz(1:288,4);
entrada2 = matriz(288:688,4);
entrada3 = matriz(688:1165,4);

% Funcion de transferencia obtenida usando
% 'systemIdentification' con el primer set de datos
%systemIdentification('planta.sid')


funct = tf(14.6961, [1 10.9934]);

%sisotool(funct);


figure('name', 'Datos usado para obtener el modelo');
hold on;
grid on;
plot(matriz(:,1), matriz(:,2));
plot(matriz(:,1), matriz(:,4));
xlabel('t [s]');
ylabel('Amplitud [V]');

% kp = 1.2199
%ki = 12.1989
[ki p kp] = residue(tf(C).numerator{1}, tf(C).denominator{1});


