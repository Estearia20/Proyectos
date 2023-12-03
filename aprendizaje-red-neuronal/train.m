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

figure(1,"name","Datos de entrenamiento");
hold off;
plot_data(X,Y);

ann=sequential("maxiter",1500,
               "alpha",10.9,
               "beta2",0.99,
               "beta1",0.9,
               "minibatch",32,
               "method","autoclip",
               "decay_rate",0.001,
               "use_decay_rate",true,
               "show","loss");

file="ann.dat";

reuseNetwork = false;

if (reuseNetwork && exist(file,"file")==2)
  ann.load(file);
else
  ann.add({input_layer(2),
           batchnorm(),
           dense(16),
           leaky_relu(),
           batchnorm(),
           dense(16),
           relu(),
           batchnorm(),
           dense(numClasses),
           sigmoid()});
  
  #ann.add(input_layer(2));
  #ann.add(dense_unbiased(16));
  #ann.add(sigmoide());
  #ann.add(dense_unbiased(16));
  #ann.add(sigmoide());
  #ann.add(dense_unbiased(numClasses));
  #ann.add(sigmoide());
  
  
  ann.add(maeloss());
endif

loss=ann.train(X,Y,vX,vY);
ann.save(file);


## TODO: falta agregar el resto de pruebas y visualizaciones
figure(2, "name", "Curvas de pérdida en función de las épocas");
plot(loss);

xlabel("Epoca");
ylabel("Error");
legend("Training", "Validation");

# Se generan las predicciones
Yp=ann.test(vX);

# Se llama a la función que crea la matriz de confusión y sus métricas
[cm,P, R] = metricas_evalu (Yp,vY);

# Visualizacion de los resultados
# Se generan puntos para hacer dos espacios lineales
minx = min(X(:,1));
maxx = max(X(:,1));
miny = min(X(:,2));
maxy = max(X(:,2));

partition = 512;

# Se construye la malla
[spacex,spacey] = meshgrid(linspace(minx,maxx,partition),
                           linspace(miny,maxy,partition));

Hmalla = ann.test([spacex(:) spacey(:)]);

img = show_image(vX,vY,Hmalla);
