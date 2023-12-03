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
