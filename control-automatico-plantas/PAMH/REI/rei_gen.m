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

%-------------------------------
%-  REI - UBICACION DE POLOS   -
%-------------------------------

close all
% Modelo de la planta usado
tf3 = tf([5.3807], [1 0.1984 15.6570]);

% Se determinar matrices del espacio de estados
Ac = [0, 1; -tf3.denominator{1}(3), -tf3.denominator{1}(2)];

Bc = [0; tf3.numerator{1}(3)];

Cc = [1, 0];

[ Aa, Ba, Ca, Da] = tf2ss([5.3807], [1 0.1984 15.6570]);

sys = ss(Ac, Bc, Cc, 0);

% Se ajustan las matrices A y B para poder hacer el REI
As = [Ac [0; 0]; -Cc 0];

Bs = [Bc; 0];

% Ubicacion de los polos 
Ps = [-3+3i -3-3i -0.7];

% Se ubican los polos por medio de ackermann
Ks = acker(As, Bs, Ps);
K12 = Ks(1:2)
K3  = -Ks(3)

% Valores utilizados para la planta fisica
%K12 = 1.2160 1.2083
%K3  = 2.3417 


% Figura del control
tiempo = Tiempo;
control = CONTROL;
angulo = ANGULO;
referencia = REFERENCIA;

figure('name', 'Control REI');
plot(tiempo, angulo, 'linewidth', 1.5);
hold on;
plot(tiempo, control, 'color', [0.2 0.6 0.2], 'linewidth', 1.2);
plot(tiempo, referencia, 'linewidth', 1.5);
set(findall(gcf,'type','line'),'linewidth',2);
legend('Ángulo', 'Control', 'Referencia', 'location', 'southeast', 'fontsize', 11);

% Detalles para la figura
axis([0 30 0 2])
title('Respuesta de la planta con el control REI', 'fontsize', 13);
xlabel('Tiempo [s]');
ylabel('Ángulo [rad]');
grid on;
set(gca, 'fontsize', 11);

% Guarda la figura
saveas(gcf, 'rei_p.png', 'png');

figure('name', 'Control Simulado REI')
plot(out_sink, 'linewidth', 1.5);
hold on;
plot(control_sink, "g", 'color', [0.2 0.6 0.2], 'linewidth', 1.2);
plot(step_sink, 'linewidth', 1.5);
%set(findall(gcf,'type','line'),'linewidth',2);
legend('Ángulo', 'Control', 'Referencia', 'location', 'southeast', 'fontsize', 11);

% Detalles para la figura
axis([0 30 0 2])
title('Respuesta de la planta con el control REI simulado', 'fontsize', 13);
xlabel('Tiempo [s]');
ylabel('Ángulo [rad]');
grid on;
set(gca, 'fontsize', 11);

% Guarda la figura
saveas(gcf, 'rei_s.png', 'png');

% IMAGENES EN NEGRO

fig1 = figure('name', 'Control REI', 'Color', 'k');
hold on;
set(gca, 'Color', 'k'); % fondo de la figura negro
plot(tiempo, angulo, 'color', [0 1 1], 'linewidth', 1.5);
plot(tiempo, control, 'color', [0 0.8 0], 'linewidth', 1.2);
plot(tiempo, referencia, 'color', [1 1 0], 'linewidth', 1.5);

% Configuracion para la leyenda
leg1 = legend('Ángulo', 'Control', 'Referencia', 'location', 'southeast', 'fontsize', 13);
set(leg1, 'Color', 'k', 'TextColor', 'w');

% Configuracion de la grid y los ejes
set(gca, 'Box', 'off', 'XColor', 'w', 'YColor', 'w', 'GridColor', 'w', 'LineWidth', 2);

% Configuracion de los titulos
axis([0 30 0 2])
title('Respuesta de la planta con el control REI', 'fontsize', 15, 'Color', 'w');
xlabel('Tiempo [s]', 'Color', 'w');
ylabel('Ángulo [rad]', 'Color', 'w');
grid on;
set(gca, 'fontsize', 14);
set(gcf, 'Color', 'k');

