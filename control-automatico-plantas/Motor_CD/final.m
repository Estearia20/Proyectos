matriz = csvread('MotorCD.CSV', 1, 0);

tiempo = matriz(:,1);

control = matriz(:,2);

velocidad = matriz(:,3);

referencia = matriz(:,4);

velocidad_max = max(velocidad(1:221,1));

%---------------------ess------------------

v_min = min(velocidad(421:821,1));

v_max = max(velocidad(421:821,1));