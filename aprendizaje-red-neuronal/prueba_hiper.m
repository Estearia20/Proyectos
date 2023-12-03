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

a={};
p=[1500,9,0.99,0.9,32,0.001;
   1500,3,0.99,0.9,32,0.001;
   1500,1,0.99,0.9,32,0.001;
   1500,0.1,0.99,0.9,32,0.001;
   1500,0.01,0.99,0.9,32,0.001];

%a={"maxiter",1500,"alpha",0.9,"beta2",0.99,"beta1",0.9,"minibatch",32,"method","momentum","decay_rate",0.001,"use_decay_rate",false,"show","loss"};

b={};
b={"sigmoid","relu","prelu","lelelu","softmax"};


for i=1:5
    ann=sequential("maxiter",p(i,1),"alpha",p(i,2),"beta2",p(i,3),"beta1",p(i,4),"minibatch",p(i,5),"method","momentum","decay_rate",p(i,6),"use_decay_rate",false,"show","loss");

    file="ann.dat";

    reuseNetwork = false;
    
    
    if (reuseNetwork && exist(file,"file")==2)
        ann.load(file);
    else
        ann.add({input_layer(2),dense(16),relu(),dense(16),relu(),dense(numClasses),sigmoid(),mseloss()});
    endif

loss=ann.train(X,Y,vX,vY);
ann.save(file);


## TODO: falta agregar el resto de pruebas y visualizaciones
figure(1, "name", "Perdida del entrenamiento cambiando alpha");
plot(loss, 'linewidth', 1.5);
hold on
xlabel("Epoca", 'fontsize', 17);
ylabel("Error", 'fontsize', 17);
grid on;
set(gca, 'fontsize', 14);
legend("Training", "Validation", 'fontsize', 12);

hold on;
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

%img = show_image(vX,vY,Hmalla);    
endfor

legend("Talpha=9","Valpha=9","Talpha=3","Valpha=3","Talpha=1","Valpha=1","Talpha=0.1","Valpha=0.1","Talpha=0.01","Valpha=0.01", 'fontsize', 12)



a={};
p=[1500,0.1,0.99,0.9,16,0.001;
   1500,0.1,0.99,0.9,32,0.001;
   1500,0.1,0.99,0.9,64,0.001;
   1500,0.1,0.99,0.9,128,0.001;
   1500,0.1,0.99,0.9,256,0.001];

%a={"maxiter",1500,"alpha",0.9,"beta2",0.99,"beta1",0.9,"minibatch",32,"method","momentum","decay_rate",0.001,"use_decay_rate",false,"show","loss"};

b={};
b={"sigmoid","relu","prelu","lelelu","softmax"};


for i=1:5
    ann=sequential("maxiter",p(i,1),"alpha",p(i,2),"beta2",p(i,3),"beta1",p(i,4),"minibatch",p(i,5),"method","momentum","decay_rate",p(i,6),"use_decay_rate",false,"show","loss");

    file="ann.dat";

    reuseNetwork = false;
    
    
    if (reuseNetwork && exist(file,"file")==2)
        ann.load(file);
    else
        ann.add({input_layer(2),dense(16),relu(),dense(16),relu(),dense(numClasses),sigmoid(),mseloss()});
    endif

loss=ann.train(X,Y,vX,vY);
ann.save(file);


## TODO: falta agregar el resto de pruebas y visualizaciones
figure(2, "name", "Perdida del entrenamiento cambiando el tamaño del minibatch");
plot(loss, 'linewidth', 1.5);
hold on
xlabel("Epoca", 'fontsize', 17);
ylabel("Error", 'fontsize', 17);
grid on;
set(gca, 'fontsize', 14);
legend("Training", "Validation", 'fontsize', 12);
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

%img = show_image(vX,vY,Hmalla);    
endfor

legend("Tminibatch=16","Vminibatch=16","Tminibatch=32","Vminibatch=32","Tminibatch=64","Vminibatch=64","Tminibatch=128","Vminibatch=128","Tminibatch=256","Vminibatch=256", 'fontsize',12)



a={};
p=[1500,0.1,0.99,0.9,32,0.01;
   1500,0.1,0.99,0.9,32,0.008;
   1500,0.1,0.99,0.9,32,0.005;
   1500,0.1,0.99,0.9,32,0.003;
   1500,0.1,0.99,0.9,32,0.001];

%a={"maxiter",1500,"alpha",0.9,"beta2",0.99,"beta1",0.9,"minibatch",32,"method","momentum","decay_rate",0.001,"use_decay_rate",false,"show","loss"};

b={};
b={"sigmoid","relu","prelu","lelelu","softmax"};


for i=1:5
    ann=sequential("maxiter",p(i,1),"alpha",p(i,2),"beta2",p(i,3),"beta1",p(i,4),"minibatch",p(i,5),"method","momentum","decay_rate",p(i,6),"use_decay_rate",true,"show","loss");

    file="ann.dat";

    reuseNetwork = false;
    
    
    if (reuseNetwork && exist(file,"file")==2)
        ann.load(file);
    else
        ann.add({input_layer(2),dense(16),relu(),dense(16),relu(),dense(numClasses),sigmoid(),mseloss()});
    endif

loss=ann.train(X,Y,vX,vY);
ann.save(file);


## TODO: falta agregar el resto de pruebas y visualizaciones
figure(3, "name", "Perdida del entrenamiento cambiando el learning rate decay");
plot(loss, 'linewidth', 1.5);
hold on
xlabel("Epoca", 'fontsize', 17);
ylabel("Error", 'fontsize', 17);
legend("Training", "Validation");
grid on;
set(gca, 'fontsize', 14);
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

%img = show_image(vX,vY,Hmalla);    
endfor

legend("Talphadecay=0.01","Valphadecay=0.01","Talphadecay=0.008","Valphadecay=0.008","Talphadecay=0.005","Valphadecay=0.005","Talphadecay=0.003","Valphadecay=0.003","Talphadecay=0.001","Valphadecay=0.001", 'fontsize',12)