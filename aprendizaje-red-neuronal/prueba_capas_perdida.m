## Copyright (C) 2021-2023 Pablo Alvarado
##
## Este archivo forma parte del material del Proyecto 1 del curso:
## EL5857 Aprendizaje Automático
## Escuela de Ingeniería Electrónica
## Tecnológico de Costa Rica

## Ejemplo de configuración de red neuronal y su entrenamiento

1;

close all;

warning('off','Octave:shadowed-function');
pkg load statistics;
pkg load image;

numClasses=5;

##datashape='spirals';
##datashape='laidar';
##datashape='curved';
##datashape='voronoi';
##datashape='vertical';
datashape='pie';

[oX,oY]=create_data(numClasses*100,numClasses,datashape); ## Training

## Partition created data into training (60%) and test (40%) sets
idx=randperm(rows(oX));

tap=round(0.6*rows(oX));
idxTrain=idx(1:tap);
idxTest=idx(tap+1:end);

X = oX(idxTrain,:);
Y = oY(idxTrain,:);

vX = oX(idxTest,:);
vY = oY(idxTest,:);

% DESEMPEÑO DE LAS CAPAS DE PERDIDA

% Se parte de una cierta configuracion de capas de perdida y se varia unicamente las de perdida
c={};
c{1}={input_layer(2),dense(16),relu(),dense(16),relu(),dense(numClasses),softmax(),olsloss()};
c{2}={input_layer(2),dense(16),relu(),dense(16),relu(),dense(numClasses),softmax(),maeloss()};
c{3}={input_layer(2),dense(16),relu(),dense(16),relu(),dense(numClasses),softmax(),xent()};
c{4}={input_layer(2),dense(16),relu(),dense(16),relu(),dense(numClasses),softmax(),mseloss()};

# Para alpha pequeño, 0.001

cm1 = {};
P1 = {};
R1 = {};

figure(1, "name", "Perdida del entrenamiento con diferentes capas de pérdida y alpha pequeño");
hold on;

for i=1:4
    ann=sequential("maxiter",1500,
               "alpha",0.001,
               "beta2",0.99,
               "beta1",0.9,
               "minibatch",32,
               "method","batch",
               "decay_rate",0.000001,
               "use_decay_rate",false,
               "show","loss");

    ann.add(c{i});
    loss=ann.train(X,Y,vX,vY);
    plot(loss);
    Yp = ann.test(vX);
    [cm1{i}, P1{i}, R1{i}] = metricas_evalu(Yp, vY);
endfor

xlabel("Epoca");
ylabel("Error");
legend('Ols_T', 'Ols_V', 'Mae_T', 'Mae_V', 'Xent_T', 'Xent_V', 'Mse_T', 'Mse_V');
title("Perdida del entrenamiento con diferentes capas de perdida");

markers = {"x", "*", "s", "o"};
color_marker = {"r", "g", "b", "m"};
figure(2, "name", "Frente de pareto para capas de perdida y alpha pequeño");
for i=1:4
    scatter(P1{i}, R1{i}, markers{i}, "markerfacecolor", "none", "markeredgecolor", color_marker{i});
    hold on
endfor

xlabel("Precisión", 'fontsize', 17);
ylabel("Exhaustividad", 'fontsize', 17);
grid on;
title("Frente de pareto para capas de perdida y alpha pequeño");
set(gca, 'fontsize', 14);
legend("Ols", "Mae", "Xent", "Mse", 'Location', 'southwest', 'Orientation', 'horizontal')



# Para alpha mas grande, 0.1

cm2 = {};
P2 = {};
R2 = {};

figure(3, "name", "Perdida del entrenamiento con diferentes capas de pérdida y alpha mayor");
hold on;

for i=1:4
    ann=sequential("maxiter",1500,
               "alpha",0.1,
               "beta2",0.99,
               "beta1",0.9,
               "minibatch",32,
               "method","batch",
               "decay_rate",0.000001,
               "use_decay_rate",false,
               "show","loss");

    ann.add(c{i});
    loss=ann.train(X,Y,vX,vY);
    plot(loss);
    Yp = ann.test(vX);
    [cm2{i}, P2{i}, R2{i}] = metricas_evalu(Yp, vY);
endfor

xlabel("Epoca");
ylabel("Error");
legend('Ols_T', 'Ols_V', 'Mae_T', 'Mae_V', 'Xent_T', 'Xent_V', 'Mse_T', 'Mse_V');
title("Perdida del entrenamiento con diferentes capas de perdida");

markers = {"x", "*", "s", "o"};
color_marker = {"r", "g", "b", "m"};
figure(4, "name", "Frente de pareto para capas de perdida y alpha mayor");
for i=1:4
    scatter(P2{i}, R2{i}, markers{i}, "markerfacecolor", "none", "markeredgecolor", color_marker{i});
    hold on
endfor

xlabel("Precisión", 'fontsize', 17);
ylabel("Exhaustividad", 'fontsize', 17);
grid on;
title("Frente de pareto para capas de perdida y alpha mayor");
set(gca, 'fontsize', 14);
legend("Ols", "Mae", "Xent", "Mse", 'Location', 'southwest', 'Orientation', 'horizontal')
