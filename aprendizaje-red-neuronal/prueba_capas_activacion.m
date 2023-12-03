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

#figure(1,"name","Datos de entrenamiento");
#hold off;
#plot_data(X,Y);

% DESEMPEÑO DE LAS CAPAS DE ACTIVACION

% Se crea un arreglo que contiene las diferentes capas de activacion y como capa de salida el sigmoid

a={};
a{1}={input_layer(2),dense(16),sigmoid(),dense(numClasses),sigmoid(),mseloss()};
a{2}={input_layer(2),dense(16),relu(),dense(numClasses),sigmoid(),mseloss()};
a{3}={input_layer(2),dense(16),softmax(),dense(numClasses),sigmoid(),mseloss()};
a{4}={input_layer(2),dense(16),prelu(),dense(numClasses),sigmoid(),mseloss()};
a{5}={input_layer(2),dense(16),lelelu(),dense(numClasses),sigmoid(),mseloss()};

cm = {};
P = {};
R = {};
loss = {};


figure(1, "name", "Perdida según capa activación");
hold on;
for i=1:5
    ann=sequential("maxiter",1500,
               "alpha",0.1,
               "beta2",0.99,
               "beta1",0.9,
               "minibatch",32,
               "method","batch",
               "decay_rate",0.001,
               "use_decay_rate",false,
               "show","loss");

    ann.add(a{i});
  

loss{i}=ann.train(X,Y,vX,vY);
plot(loss{i}, 'linewidth', 1.5);

Yp = ann.test(vX);
  
[cm{i}, P{i}, R{i}] = metricas_evalu(Yp, vY);


endfor

xlabel("Epoca", 'fontsize', 17);
ylabel("Error", 'fontsize', 17);
hold on
grid on;
set(gca, 'fontsize', 14);

legend("sigmoidT","sigmoidV","reluT","reluV","softmaxT","softmaxV","preluT","preluV","leleluT","leleluV", 'fontsize', 13)


figure(2,'name','Frente de pareto para métodos capas de activación');
for i=1:5
    scatter(P{i}, R{i}, 'filled');
    hold on
endfor

    xlabel("Precisión", 'fontsize', 17);
    ylabel("Exhaustividad", 'fontsize', 17);
    grid on;
    set(gca, 'fontsize', 14);
    legend("sigmoid", "relu", "softmax", "prelu", "lelelu",'fontsize', 12, 'Location', 'southwest', 'Orientation', 'horizontal')