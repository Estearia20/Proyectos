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

numClasses = 3;

[Xtr, Ytr, Xte, Yte, names] = loadpenguindata("species");

normalizer_type = "normal";
nx = normalizer(normalizer_type);

Xtrn = nx.fit_transform(Xtr);
Xten = nx.transform(Xte);


alpha = {0.01, 0.9, 0.1};
o = {"batch", "batch", "batch"};
use_decay = {false, false, false};

c={};
c{1}={input_layer(4), dense(16), relu(), batchnorm(), dense(16), prelu(), batchnorm(), dense(16), relu(), batchnorm(), dense(numClasses), sigmoid(), mseloss()};
c{2}={input_layer(4), dense(16), lelelu(), batchnorm(), dense(16), lelelu(), batchnorm(), dense(16), prelu(), batchnorm(), dense(numClasses), softmax(), mseloss()};
c{3}={input_layer(4), dense(16), relu(), batchnorm(), dense(16), relu(), batchnorm(), dense(16), prelu(), batchnorm(), dense(numClasses), softmax(), mseloss()};

cm = {};
P = {};
R = {};
loss = {};

figure(1, "name", "Perdida del entrenamiento con las 3 arquitecturas");
hold on;

for i=1:3
  ann = sequential("maxiter", 1500,
		   "alpha", alpha{i},
		   "beta2", 0.99,
		   "beta1", 0.9,
		   "minibatch", 32,
		   "method", o{i},
		   "decay_rate", 0.000001,
		   "use_decay_rate", use_decay{i},
		   "show", "loss");

  ann.add(c{i});

  loss{i} = ann.train(Xtrn, Ytr, Xten, Yte);

  plot(loss{i});

  Yp = ann.test(Xten);
  
  [cm{i}, P{i}, R{i}] = metricas_evalu(Yp, Yte);
endfor

xlabel("Epoca");
ylabel("Error");
title("Perdida del entrenamiento con las 3 arquitecturas");
legend("Training_1", "Validation_1", "Training_2", "Validation_2", "Training_3", "Validation_3");

markers = {"x", "+", "s"};
color_marker = {"r", "b", "m"};
figure(2, "name", "Diagrama de pareto para las 3 distintas configuraciones");
for i=1:3
    scatter(P{i}, R{i}, markers{i}, "markerfacecolor", "none", "markeredgecolor", color_marker{i});
    hold on
endfor

xlabel("Precisión", 'fontsize', 17);
ylabel("Exhaustividad", 'fontsize', 17);
grid on;
title("Diagrama de pareto para las distintas configuraciones");
set(gca, 'fontsize', 14);
legend("Primera", "Segunda", "Tercera", 'Location', 'southwest', 'Orientation', 'horizontal')


# Entrenamiento con las mejores 2 clases
# Estas son culmen length y culmen depth

Xtrn_b = Xtrn(:,1:2);
Xten_b = Xten(:,1:2);

figure(3, "name", "Datos de entrenamiento con primeras 2 caracteristicas");
hold off;
plot_data(Xtr(:,1:2), Ytr);
hold on;

xlabel("culmen length [mm]", 'fontsize', 17);
ylabel("culmen depth [mm]", 'fontsize', 17);
grid on;
set(gca, 'fontsize', 14);


ann=sequential("maxiter",1500,
               "alpha",0.01,
               "beta2",0.99,
               "beta1",0.9,
               "minibatch",32,
               "method","rmsprop",
               "decay_rate",0.001,
               "use_decay_rate",false,
               "show","loss");

ann.add({input_layer(2),
          dense(16),
          relu(),
          batchnorm(),
          dense(16),
          relu(),
          batchnorm(),
          dense(numClasses),
          softmax()}
          );
ann.add(xent()); 

loss = ann.train(Xtrn_b, Ytr, Xten_b, Yte);

figure(4, "name", "Perdida del entrenamiento con 2 caracteristicas");
plot(loss);
hold on
xlabel("Epoca", 'fontsize', 17);
ylabel("Error", 'fontsize', 17);
grid on;
set(gca, 'fontsize', 14);
legend("Training", "Validation", 'fontsize', 12);


# Se generan predicicones
Yp = ann.test(Xten_b);

# Se llama la funcion que crea la matriz de confusion y sus metricas
[cm_b, P_b, R_b] = metricas_evalu(Yp, Yte);

# Visualizacion de los resultados
# Se generan puntos para hacer dos espacios lineales
minx = min(Xtrn_b(:,1));
maxx = max(Xtrn_b(:,1));
miny = min(Xtrn_b(:,2));
maxy = max(Xtrn_b(:,2));

partition = 512;

# Se construye la malla

[spacex,spacey] = meshgrid(linspace(minx,maxx,partition),
                           linspace(miny,maxy,partition));
NXn = [spacex(:),spacey(:)];

Hmalla = ann.test(NXn);

img = show_image(Xte(:,1:2), Yte, Hmalla);



