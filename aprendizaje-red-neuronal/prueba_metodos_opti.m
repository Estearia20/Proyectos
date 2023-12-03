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


% DESEMPEÑO DE LOS MÉTODOS DE OPTIMIZACIÓN
o={"batch", "momentum", "sgd", "rmsprop", "adam", "autoclip"};

figure(1, "name", "Perdida con diferentes métodos de optimización");
hold on;

cm = {};
P = {};
R = {};
loss = {};

for i=1:6
    ann=sequential("maxiter",1000,
               "alpha",0.1,
               "beta2",0.99,
               "beta1",0.9,
               "minibatch",32,
               "method", o{i},
               "decay_rate",0.001,
               "use_decay_rate",false,
               "show","loss");

    file="ann.dat";

    reuseNetwork = false;
    
    
    if (reuseNetwork && exist(file,"file")==2)
        ann.load(file);
    else
      ann.add({input_layer(2),
           dense(16),
           relu(),
           dense(16),
           relu(),
           dense(numClasses),
           sigmoid()});
 ann.add(mseloss());
    endif

  loss{i} = ann.train(X, Y, vX, vY);

  plot(loss{i}, 'linewidth', 1.5);

  Yp = ann.test(vX);
  
  [cm{i}, P{i}, R{i}] = metricas_evalu(Yp, vY);

endfor

xlabel("Epoca", 'fontsize', 17);
ylabel("Error", 'fontsize', 17);
hold on
grid on;
set(gca, 'fontsize', 14);

legend("batch", "momentum", "sgd", "rmsprop", "adam", "autoclip", 'fontsize', 13)

figure(2,'name','Frente de pareto para métodos de optimización');
for i=1:6
    scatter(P{i}, R{i}, 'filled');
    hold on
endfor

    xlabel("Precisión", 'fontsize', 17);
    ylabel("Exhaustividad", 'fontsize', 17);
    grid on;
    set(gca, 'fontsize', 14);
    legend("batch", "momentum", "sgd", "rmsprop", "adam", "autoclip", 'fontsize', 12, 'Location', 'southwest', 'Orientation', 'horizontal')
