%Limpia espacio de trabajo
close all
s = tf('s');

%Valores de las constantes
Jp = 0.0023255;
Jy = 0.0023255;
Kp = 0.00038;
Ky = 0.00038;
rp = 0.335;
ry = 0.24;
up = 0.01325;
uy = 0.8513;
Fg = 9.81;
lcm = 0.045;

% -----------------------------------------------------------------------------
%                           ESCALÓN UNITARIO
% -----------------------------------------------------------------------------

% H(s) para el pitch
Hp = (rp*Kp/Jp)/(s^2+s*up*rp/Jp+Fg*lcm/Jp);
figure("name","Respuesta del Pitch ante escalón unitario")
step(Hp);
figure("name","Respuesta del Pitch ante escalón con realimentación unitaria")
step(feedback(Hp,1));


% H(s) para el yaw
Hy = (ry*Ky/Jy)/(s^2+s*uy*ry/Jy);
figure("name","Respuesta del Yaw ante escalón unitario")
step(Hy);
figure("name","Respuesta del Yaw ante escalón con realimentación unitaria")
step(feedback(Hy,1));

% -----------------------------------------------------------------------------
%                           IMPULSO UNITARIO
% -----------------------------------------------------------------------------

% H(s) para el pitch
Hp = (rp*Kp/Jp)/(s^2+s*up*rp/Jp+Fg*lcm/Jp);
figure("name","Respuesta del Pitch ante impulso unitario")
impulse(Hp);
figure("name","Respuesta del Pitch ante impulso con realimentación unitaria")
impulse(feedback(Hp,1));


% H(s) para el yaw
Hy = (ry*Ky/Jy)/(s^2+s*uy*ry/Jy);
figure("name","Respuesta del Yaw ante impulso unitario")
impulse(Hy);
figure("name","Respuesta del Yaw ante impulso con realimentación unitaria")
impulse(feedback(Hy,1));
