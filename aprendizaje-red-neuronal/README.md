# Proyecto 1 : Redes Neuronales Artificiales.

El archivo principal para poder observar lo realizado es el llamado `train.m`, el cual muestra los resultados obtenidos al implementar una red neural con sus diferentes capas de activación, su capa de pérdida, y sus respectivos ajustes. Sin embargo existen otros códigos los cuales permiten mostrar las pruebas realizadas como lo son los archivos:

- `prueba_capas_activacion.m`: Este archivo muestra el experimento realizado para comparar cuantitativamente la variación del desempeño de las 5 capas de activación implementadas. 
- `prueba_capas_perdida.m`: Este archivo muestra el experimento realizado para comparar cuantitativamente el efecto de las funciones de pérdida disponibles.
- `prueba_metodos_opti.m`: Este archivo muestra el experimento realizado para comparar el desempeño de los métodos de implementación implementados.
- `prueba_hiper.m`: Este archivo muestra el experimento realizado para evaluar el efecto de los hiperparámetros del entrenamiento. 

Además se realizó un experimento con datos reales por lo se elaboró otro archivo especificamente para esto, el nombre de este archivo es `train_penguin.m`, el cual muestra la clasificación realizada para unos datos de pingüinos, utilizando diferentes caracteristicas.

Cabe recalcar que los diferentes códigos en su versión final y la documentación se encuentra en la rama principal `master`. El procedimiento para correr los diferentes códigos se muestra a continuación.

## 1. Instrucciones para ejecutar los códigos

### Ejecución del archivo principal `train.m`

Para utilizar el código ejecute los siguientes comandos en la consola, ubicado en el directorio que corresponde:
```bash
    octave
```
El comando anterior ejecuta la versión desde línea de comandos **(CLI)** de `Octave`, dentro del **CLI** que se ha abierto, ejecute:
```bash
    train
```
Al ejecutar estos comandos, se generan **4** figuras las se pueden modificar al cambiar la configuración del `sequential`, este se encuentra entre las líneas **46** y **54**:
```matlab
    ann = sequential("maxiter",1500,
                     "alpha",10.9,
                     "beta2",0.99,
                     "beta1",0.9,
                     "minibatch",32,
                     "method","autoclip",
                     "decay_rate",0.001,
                     "use_decay_rate",true,
                     "show","loss");
```

Los parámetros del `sequential` se pueden cambiar de la siguiente forma:

- **maxiter**: Corresponde al máximo número de iteracione, tiene que ser un número entero y mayor a 0.
- **alpha**: Corresponde al learning rate y su única restricción es que debe ser mayor a 0.
- **beta2**: Corresponde a un parámetro que se utiliza algunos métodos de optimización y su valor se encuentra entre 0 y 1.
- **beta1**: Corresponde a un parámetro que se utiliza algunos métodos de optimización y su valor se encuentra entre 0 y 1.
- **minibath**: Corresponde al tamaño del minibatch y debe ser un valor entero mayor que 0.
- **method**: Corresponde al método de optimización, puede escoger entre **batch**, **sgd**, **momentum**, **rmsprop**, **adam** y **autoclip**.
- **decay_rate**: Corresponde al factor de decaimiento y su valor se encuentra entre 0 y 1.
- **use_decay_rate**: Corresponde a un booleano (**true** o **false**) para activar o desactivar el *learning rate decay*.
- **show**: Corresponde a la forma de mostrar información del progreso, es de tipo string y puede tomar los valores de **nothing**, **dots**, **loss** y **progress**.

Los parámetros `beta2` y `beta1` van a tener algún efecto en el resultado dependiendo del método de optimización a utilizar, ya que no todos utilizan estos parámetros. 

Además también se puede modificar la configuración de la red neural, cambiando las capas de activación, agregando más capas o bien, cambiendo la función de pérdida a utilizar. Esta configuración se puede modificar en el código que se encuentra entre las líneas **63** y **83**:
```matlab
    ann.add({input_layer(2),
             batchnorm(),
             dense(16),
             relu(),
             batchnorm(),
             dense(16),
             relu(),
             batchnorm(),
             dense(numClasses),
             sigmoid()});
             
    ann.add(maeloss());
```

La configuración de la red cuenta con 3 capas de activación que se pueden cambiar a como el usuario desee, las capas de activación que se pueden utilizar son:

- **sigmoid**
- **softmas**
- **prelu**
- **relu**
- **lelelu**
- **leaky_relu**

De igual forma se puede configurar la función de pérdidas a utilizar en este caso se está utilizando **maeloss** pero se puede cambiar por :

- **olsloss**
- **mseloss**
- **xent**

Cabe recalcar que al correr este archivo, se genera un archivo `ann.dat` el cual contiene los datos entrenados, si se desea volver a entrar sobre estos mismos datos se debe cambiar el valor de la variable `reuseNetwork`, la cual se encuentra en la línea **58**: 
```matlab
    reuseNetwork = false;
```

La información que muestran las figuras al ejecutar el código `train.m` es la siguiente:

#### Figura 1: Datos de entranamiento
Esta figura permite la visualización del entrenamiento para los datos utilizados, los cuales corresponden a un conjunto de datos bidimensionales siguiendo varias distribuciones y varios números de clases, creados apartir del archivo `create_data.m`. Para esta figura no hay parámetros que se puedan modificar, ya que depende de los datos de entrenamiento utilizados. Sin embargo se puede cambiar la cantidad de clases y la forma en la que se muestran los datos. La cantidad de clases se puede modificar al cambiar el valor de la variable `numClasses`, la cual se encuentra en la línea **18** del código.

```matlab
    numClasses = 5;
```

Y la forma de los datos se puede cambiar al utilizar una forma diferente según el valor que tenga `datashape`, hay 6 formas que se pueden utilizar, predeterminadamente se está utilizando la forma `pie`, si desea cambiar, descomente la forma que desea utilizar, las cuales se encuntran entre la linea **20** y **25**:
```matlab
    ##datashape='spirals';
    ##datashape='laidar';
    ##datashape='curved';
    ##datashape='voronoi';
    ##datashape='vertical';
    datashape='pie';
```

#### Figura 2: Curvas de pérdida en función de las épocas
Esta figura muestra las curvas de pérdida en función de las épocas para el conjunto de entrenamiento y otro de validación. La respuesta de esta gráfica depende de la configuración que se coloque en el en `sequential`, al cambiar el valor del *learning rate* `alpha`, el *learning rate decay* `decay_rate` y `use_decay_rate` o bien el `method`, la forma de la gráfica y su comportamiento puede cambiar significativamente.

#### Figura 3: Clases ganadoras
Esta gráfica muestra como con 5 clases, se logra ilustrar el concepto de frontera de decisión, el cual representa el límite entre la región del espacio de entrada que el clasificador asigna a la clase. Para esta gráfica se puede cambiar el número de clases en la variable `numClasses` y de igual forma al cambiar parámetros en la configuración del `sequential` o en la configuración de las capas de la red.


#### Figura 4: Ponderación de colores para las clases
Esta gráfica muestra de una manera más segura la asignación del clasificador. En esta figura se realiza la mezcla de los colores, ponderada por la probabilidad, logrando apreciar qué tan seguro está el clasificador. Por lo tanto se muestra la ponderación de colores asignados a las clases, de acuerdo a la probabilidad de pertenecer a esa clase. Para esta gráfica se puede cambiar el número de clases en la variable `numClasses` y de igual forma al cambiar parámetros en la configuración del `sequential` o en la configuración de las capas de la red.

### Ejecución del archivo de experimentación `prueba_capas_activacion.m`

Para utilizar el código ejecute los siguientes comandos en la consola, ubicado en el directorio que corresponde:
```bash
    octave
```
El comando anterior ejecuta la versión desde línea de comandos **(CLI)** de `Octave`, dentro del **CLI** que se ha abierto, ejecute:
```bash
    prueba_capas_activacion
```
El objetivo de este archivo es presentar un experimento para comparar cuantitativamente la variación del desempeño de las cinco capas de activación implementadas, para esto se graficó la perdida en función de la época manteniendo la capa de salida y la función de pérdida fijas y se cambia únicamente las capas de activación. Además obtener la matriz de confusión y las métricas de evaluación para cada configuración utilizada.

Como se mencionó anteriormente se utilizaron varias configuraciones donde solo se cambiara la capa de activación para poder visualizalir el efecto al cambiar estas capas, por lo que las configuraciones utilizadas para la red se muestran en las líneas **51** hasta la **55**:

```matlab
    a={};
    a{1}={input_layer(2),dense(16),sigmoid(),dense(numClasses),sigmoid(),mseloss()};
    a{2}={input_layer(2),dense(16),relu(),dense(numClasses),sigmoid(),mseloss()};
    a{3}={input_layer(2),dense(16),softmax(),dense(numClasses),sigmoid(),mseloss()};
    a{4}={input_layer(2),dense(16),prelu(),dense(numClasses),sigmoid(),mseloss()};
    a{5}={input_layer(2),dense(16),lelelu(),dense(numClasses),sigmoid(),mseloss()};    
```
De forma similar que para el archivo `train.m` se realizó una configuración del `sequential` sin embargo esta no es recomendable cambiarla ya que lo que el objetivo de este archivo es comparar las capas de activación, manteniendo el resto de las configuraciones fijas, por lo que no se muestra, si desea observar la configuración, esta se encuentra entre las lineas **66** y **74**.

Al ejecutar los comandos necesarios para correr este archivo, se muestran 2 figuras, la cuál contienen la siguiente información:

#### Figura 1: Perdida según capa activación
Esta gráfica muestra el experimento realizado para comparar la variación del desempeño de las 5 capas de activación implementadas, donde se muestran las curvas de pérdida en función de las épocas para el conjunto de entrenamiento y otro de validación utilizando las diferentes capas de activación, según las 5 configuraciones de la red que se mostraron. Esta imagen se puede modificar al agregar más capas de activación en las 5 configuraciones de la red mostradas, cambiando la capa de salida o cambiando la función de pérdida , otra opción es cambiar la configuración del `sequential`, sin embargo esta última modificación no es recomendada. 


#### Figura 2: Frente de pareto para métodos capas de activación
Esta gráfica muestra el frente de pareto el cual muestra las métricas de precisión P y exhaustividad R , para comparar de forma más gráfica las métricas de evalución apartir de la matriz de confusión al utilizar una capa de activación específica . Esta gráfica no presenta parámetros a modificar.

Además del frente de pareto, se puede utilizar otro método de comparación utilizando las métricas de exhaustividad y precisión, calculadas para cada configuración de la red, estas métricas se pueden observar en consola escribiendo:

```bash
    P
```
Este mostrará 5 matrices con el valor de la precisición para cada clase según las 5 configuraciones de red. Y para la exhaustividad, se debe escribir en consola:
```bash
    R
```
Donde de igual forma se mostraran 5 matrices con el valor de exhaustividad de las 5 clases para las diferentes configuraciones de la red. 


### Ejecución del archivo de experimentación `prueba_capas_perdida.m`
Para utilizar el código ejecute los siguientes comandos en la consola, ubicado en el directorio que corresponde:
```bash
    octave
```
El comando anterior ejecuta la versión desde línea de comandos **(CLI)** de `Octave`, dentro del **CLI** que se ha abierto, ejecute:
```bash
    prueba_capas_perdida
```
El objetivo de este archivo es presentar un experimento para comparar cuantitativamente el efecto de las tres funciones de pérdida disponibles, para esto se graficó la perdida en función de la época manteniendo una configuración fija en la red y variando unicamente la función de pérdida. De igual forma que para las pruebas de las capas de activación, se puede obtener la matriz de confusión y las métricas de evaluación para cada configuración utilizada.

Como se mencionó anteriormente se utilizaron varias configuraciones donde solo se cambia la función de pérdida, por lo que las configuraciones utilizadas para la red se muestran en las líneas **45** hasta la **49**:


```matlab
    c={};
    c{1}={input_layer(2),dense(16),relu(),dense(16),relu(),dense(numClasses),softmax(),olsloss()};
    c{2}={input_layer(2),dense(16),relu(),dense(16),relu(),dense(numClasses),softmax(),maeloss()};
    c{3}={input_layer(2),dense(16),relu(),dense(16),relu(),dense(numClasses),softmax(),xent()};
    c{4}={input_layer(2),dense(16),relu(),dense(16),relu(),dense(numClasses),softmax(),mseloss()};
```

Al ejecutar los comandos necesarios para correr este archivo, se generan 4 gráficas, la cuales contienen la siguiente información:

#### Figura 1: Perdida del entrenamiento con diferentes capas de pérdida con alpha pequeño
Esta gráfica muestra el experimento realizado para comparar el efecto al cambiar las 4 funciones de pérdida y utilizar un $\alpha$ pequeño, donde se muestran las curvas de pérdida en función de las épocas, según las 4 configuraciones de la red que se mostraron. Esta imagen se puede modificar al agregar más capas de activación o cambiando las capas de activación, otra opción es cambiar la configuración del `sequential`, sin embargo esta última modificación no es recomendada.


#### Figura 2: Frente de pareto para capas de pérdida y alpha pequeño
Esta gráfica muestra el frente de pareto el cual muetra las métricas de precisión P y exhaustividad R , para comparar de forma más gráfica las métricas de evalución apartir de la matriz de confusión al utilizar una capa de pérdida específica y un valor de $\alpha$ pequeño. Esta gráfica no presenta parámetros a modificar. Lo único que se puede ajustar son los parámetros del `sequential` que se encuentran entra la línea **61** y **69** :

```matlab
    ann=sequential("maxiter",1500,
                   "alpha",0.001,
                   "beta2",0.99,
                   "beta1",0.9,
                   "minibatch",32,
                   "method","batch",
                   "decay_rate",0.000001,
                   "use_decay_rate",false,
                   "show","loss");
```

#### Figura 3: Perdida del entrenamiento con diferentes capas de pérdida con alpha grande
Esta gráfica muestra el experimento realizado para comparar el efecto al cambiar las 4 funciones de pérdida y utilizar un $\alpha$ más grande, donde se muestran las curvas de pérdida en función de las épocas, según las 4 configuraciones de la red que se mostraron. Esta imagen se puede modificar al agregar más capas de activación o cambiando las capas de activación, otra opción es cambiar la configuración del `sequential`, sin embargo esta última modificación no es recomendada.

#### Figura 4 : Frente de pareto para funciones de pérdida y alpha grande
Esta gráfica muestra el frente de pareto el cual muetra las métricas de precisión P y exhaustividad R , para comparar de forma más gráfica las métricas de evalución apartir de la matriz de confusión al utilizar una capa de pérdida específica y un valor de $\alpha$ grande. Esta gráfica no presenta parámetros a modificar. Lo único que se puede ajustar son los parámetros del `sequential` que se encuentran entra la línea **110** y **118** :

```matlab
    ann=sequential("maxiter",1500,
                   "alpha",0.1,
                   "beta2",0.99,
                   "beta1",0.9,
                   "minibatch",32,
                   "method","batch",
                   "decay_rate",0.000001,
                   "use_decay_rate",false,
                   "show","loss");
```

Además de las figuras, de forma similar que para las pruebas de las capas de activación, se puede realizar una comparación con las métricas de evaluación de la matriz de confusión, escribiendo en la línea de comandos: 

```bash
    P
```
Este mostrará 4 matrices con el valor de la precisición para cada clase según las 4 configuraciones de red. Y para la exhaustividad, se debe escribir en consola:
```bash
    R
```

### Ejecución del archivo de experimentación `prueba_hiper.m`
Para utilizar el código ejecute los siguientes comandos en la consola, ubicado en el directorio que corresponde:
```bash
    octave
```
El comando anterior ejecuta la versión desde línea de comandos **(CLI)** de `Octave`, dentro del **CLI** que se ha abierto, ejecute:
```bash
    prueba_hiper
```
El objetivo de este archivo es presentar un experimento para evaluar el efecto de hiperparámetros del entrenamiento como la tasa de aprendizaje, el decaimiento de la tasa de aprendizaje, etc. Para este se realizaron varias configuraciones , según el hiperparámetro que se desea variar. La configuración utilizada cambiando unicamente el *learning rate* $\alpha$ se muestra en la línea **46** :
```matlab
    p=[1500,9,0.99,0.9,32,0.001;
       1500,3,0.99,0.9,32,0.001;
       1500,1,0.99,0.9,32,0.001;
       1500,0.1,0.99,0.9,32,0.001;
       1500,0.01,0.99,0.9,32,0.001]; 
```

Posteriormente se realizó una configuración donde unicamente se cambia el tamaño del *minibatch*, este se encuentra en la línea **114**:
```matlab
    p=[1500,0.1,0.99,0.9,16,0.001;
       1500,0.1,0.99,0.9,32,0.001;
       1500,0.1,0.99,0.9,64,0.001;
       1500,0.1,0.99,0.9,128,0.001;
       1500,0.1,0.99,0.9,256,0.001];
```
Y se realizó una última configuración donde se varía unicamente el valor de *learning rate decay* y manteniendo el resto de parámetros constantes, la configuración se muestra en la línea **182** del código:
```matlab
    p=[1500,0.1,0.99,0.9,32,0.01;
       1500,0.1,0.99,0.9,32,0.008;
       1500,0.1,0.99,0.9,32,0.005;
       1500,0.1,0.99,0.9,32,0.003;
       1500,0.1,0.99,0.9,32,0.001];
```
Cabe recalcar que estas configuraciones de hiperparámetros son los que se colocan en las configuraciones del `sequential`, a esta configuración se le está pasando cada uno de los valores de `p` y el método de optimización que se está utilizando para las 3 pruebas realizadas es **momentum**.

Además la configuración de las capas de la red, siempre es la misma para las 3 pruebas realizadas, esta configuración es:
```matlab
    ann.add({input_layer(2),
             dense(16),
             relu(),
             dense(16),
             relu(),
             dense(numClasses),
             sigmoid(),
             mseloss()});
```



Al ejecutar los comando se obtienen 3 figuras, las cuales tienen la siguiente información:

#### Figura 1: Perdida del entrenamiento cambiando alpha
Esta gráfica muestra el experimento al cambiar únicamente en los hiperparámetros el valor del *learning rate*, en esta grafica se observan las curvas de pérdida en función de las épocas para el conjunto de entrenamiento y otro de validación, con un cierto valor de $\alpha$. Esta gráfica se puede modificar cambiando los valores de la configuración del `sequential`, ubicada en la línea **46**.

#### Figura 2: Perdida del entrenamiento cambiando el tamaño del minibatch
Esta gráfica muestra el experimento al cambiar únicamente en los hiperparámetros el valor del *minibath*, en esta grafica se observan las curvas de pérdida en función de las épocas para el conjunto de entrenamiento y otro de validación, con un cierto valor de *minibatch*. Esta gráfica se puede modificar cambiando los valores de la configuración del `sequential`, ubicada en la línea **114**.


#### Figura 3: Perdida del entrenamiento cambiando el learning rate decay
Esta gráfica muestra el experimento al cambiar únicamente en los hiperparámetros el valor del *learning rate decay*, en esta grafica se observan las curvas de pérdida en función de las épocas para el conjunto de entrenamiento y otro de validación, con un cierto valor de *learning rate decay*. Esta gráfica se puede modificar cambiando los valores de la configuración del `sequential`, ubicada en la línea **182**.


### Ejecución del archivo de experimentación `prueba_metodos_opti.m`
Para utilizar el código ejecute los siguientes comandos en la consola, ubicado en el directorio que corresponde:
```bash
    octave
```
El comando anterior ejecuta la versión desde línea de comandos **(CLI)** de `Octave`, dentro del **CLI** que se ha abierto, ejecute:
```bash
    prueba_metodos_opti
```

El objetivo de este archivo es presentar un experimento para evaluar el desempeño de los métodos de optimización implementados. Para esto se realizó una configuración de los parámetros del `sequential` fija, donde únicamente se cambia el método de optimización, la configuración se muestra en la línea **48** y **59**:

```matlab
    o={"batch", "momentum", "sgd", "rmsprop", "adam", "autoclip"};

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

```
Además se utiliza una configuración fija para la red, utilizando una serie de capas de activación y función de pérdida, esta se muestra en la línea **77**:
```matlab
    ann.add({input_layer(2),
             dense(16),
             relu(),
             dense(16),
             relu(),
             dense(numClasses),
             sigmoid()});
    ann.add(mseloss());
```

Al ejecutar los comandos para correr el código, se muestran 2 figuras, las cuales tienen la siguiente información:

#### Figura 1: Perdida con diferentes métodos de optimización
Esta gráfica muestra la perdida en función de la época al utilizar una configuración del `sequential` y de la red fijas, cambiando únicamente el método de optimización. Esta figura se puede modificar al cambiar valores en los parámetros del `sequential` o bien cambiando las capas de la red.

#### Figura 2: Frente de pareto para métodos de optimización
Esta gráfica muestra el frente de pareto el cual muetra las métricas de precisión `P` y exhaustividad `R` , para comparar de forma más gráfica las métricas de evalución apartir de la matriz de confusión al utilizar un método de optimización . Esta gráfica no presenta parámetros a modificar.

Como se muestra en la figura 2, el frente de pareto, es necesario calcular antes las métricas `P` y `R`, estas se puede mostrar en consola, escribiendo: 
```bash
    P
```
Este mostrará la métrica de precisión. Y para la exhaustividad, se debe escribir en consola:
```bash
    R
```


### Ejecución del archivo para datos reales `train_penguin.m`

Para utilizar el código ejecute los siguientes comandos en la consola, ubicado en el directorio que corresponde:
```bash
    octave
```
El comando anterior ejecuta la versión desde línea de comandos **(CLI)** de `Octave`, dentro del **CLI** que se ha abierto, ejecute:
```bash
    train_penguin
```
Este archivo realizará un proceso similar que el archivo principal de `train.m` solo que con datos reales. Primeramente se utilizó los datos de pingüinos usados en la tarea 3 y se compararon tres arquitecturas de red neuronal para clasificar esos datos con
las 4 características disponibles. Las 3 configuraciones utilizadas se muestran 
entre las líneas **29** y **36**
```matlab
    alpha = {0.01, 0.9, 0.1};
    o = {"batch", "batch", "batch"};
    use_decay = {false, false, false};

    c={};
    c{1}={input_layer(4), dense(16), relu(), batchnorm(), dense(16), prelu(), batchnorm(), dense(16), relu(), batchnorm(), dense(numClasses), sigmoid(), mseloss()};
    c{2}={input_layer(4), dense(16), lelelu(), batchnorm(), dense(16), lelelu(), batchnorm(), dense(16), prelu(), batchnorm(), dense(numClasses), softmax(), mseloss()};
    c{3}={input_layer(4), dense(16), relu(), batchnorm(), dense(16), relu(), batchnorm(), dense(16), prelu(), batchnorm(), dense(numClasses), softmax(), mseloss()};
```

Por lo tanto la configuración del `sequential` y de la red se muestran de la siguiente forma:
```matlab
    for i=1:3
        ann = sequential("maxiter", 1500,
                         "alpha", alpha{i},
		         "beta2", 0.99,
                         "beta1", 0.9,
                         "minibatch", 32,
		         "method", o{i},
		         "decay_rate", 0.000001,
                         "use_decay_rate",use_decay{i}, 
                         "show", "loss");
        ann.add(c{i});

```
Al ejecutar los comandos, se obtendran 6 figuras, las dos primera figuras tendrá la siguiente información:

#### Figura 1: Perdida del entrenamiento con las 3 arquitecturas
Esta gráfica muestra el experimento realizado para comparar el efecto de las 3 arquitecturas propuestas, donde se muestran las curvas de pérdida en función de las épocas para el conjunto de entrenamiento y otro de validación. La respuesta de esta gráfica depende de las 3 configuraciones mostradas anteriormente por lo que si se desea cambiar la respuesta se debe cambiar alguna de las configuraciones propuestas.

#### Figura 2: Diagrama de pareto para las 3 distintas configuraciones
Esta gráfica muestra el frente de pareto el cual muestra las métricas de precisión P y exhaustividad R , para comparar de forma más gráfica las métricas de evalución apartir de la matriz de confusión al utilizar las 3 configuraciones de red propuestas. Esta gráfica no presenta parámetros a modificar a menos de que se cambien las configuraciones de red propuestas.

Como se muestra en la figura 2, el frente de pareto, es necesario calcular antes las métricas `P` y `R`, estas se puede mostrar en consola, escribiendo: 
```bash
    P
```
Este mostrará la métrica de precisión. Y para la exhaustividad, se debe escribir en consola:
```bash
    R
```


Las siguientes figuras corresponden al utilizar las dos características seleccionadas en Tarea 3 para entrenar otra red neuronal, y producir las imágenes de clase ganadora y probabilidad de clase. Las dos caracteristicas utilizadas corresponden a **culmen\_length\_mm** y  **culmen\_depth\_mm** . Por lo tanto para entrenar esta red neural se utilizó la siguiente configuración del `sequential` :

```matlab
    ann=sequential("maxiter",1500,
                   "alpha",0.01,
                   "beta2",0.99,
                   "beta1",0.9,
                   "minibatch",32,
                   "method","rmsprop",
                   "decay_rate",0.001,
                   "use_decay_rate",false,
                   "show","loss");

```
Y la configuración de las capas de la red :
```matlab
    ann.add({input_layer(2),
            dense(16),
            relu(),
            batchnorm(),
            dense(16),
            relu(),
            batchnorm(),
            dense(numClasses),
            softmax()});

    ann.add(xent()); 

```
Al utilizar estas configuraciones y ejecutar el archivo, se obtienen el resto de figuras, las cuales tienen la siguiente información:

#### Figura 3: Datos de entrenamiento con primeras 2 caracteristicas
Esta figura permite la visualización del entrenamiento para los datos utilizados, los cuales corresponden a las dos mejores caracteristicas, provenientes del archivo `penguins_size.csv`. Para esta figura no hay parámetros que se puedan modificar, ya que depende de los datos de entrenamiento utilizados. Sin embargo se puede las configuraciones anteriormente mostradas.

#### Figura 4: Perdida del entrenamiento con 2 caracteristicas
Esta figura muestra las curvas de pérdida en función de las épocas para el conjunto de entrenamiento y otro de validación, utilizando las dos mejores caracteristicas. La respuesta de esta gráfica depende de la configuración que se coloque en el en `sequential` y la configuración de las capas de la red.



#### Figura 5: Clases ganadoras
Esta gráfica muestra como con 2 caracteristicas, se logra ilustrar el concepto de frontera de decisión, el cual representa el límite entre la región del espacio de entrada que el clasificador asigna a la clase. Para esta gráfica se puede cambiar la configuració del `sequential` y la configuración de las capas de la red.

#### Figura 6: Ponderación de colores para las clase
Esta gráfica muestra de una manera más segura la asignación del clasificador. En esta figura se realiza la mezcla de los colores, ponderada por la probabilidad, logrando apreciar qué tan seguro está el clasificador. Por lo tanto se muestra la ponderación de colores asignados a las clases, de acuerdo a la probabilidad de pertenecer a esa clase. Esta imagen se puede modificar al cambiar la configuració del `sequential` y la configuración de las capas de la red, si se cambia la Figura 5 de clases ganadoras, esta también se ve afectada.


## 2. Archivos

- `batchnorm.m`: Capa de normalizacíón por lotes.
- `confusion_matrix.m`: Implementación de la matriz de confusión.
- `create_data.m`: Módulo usado para crear conjuntos de datos bidimensionales siguiendo varias distribuciones y varios números de clases.
- `dense.m`: Capa densa con sesgo.
- `dense_unbiased.m`: Capa densa sin sesgo.
- `input_layer.m`: Capa de entrada.
- `layer_template.m`: Plantilla para cualquier tipo de capa.
- `lelelu_fun.m`: Función de lelelu.
- `lelelu.m`: Capa de activación que usa la función de lelelu (implementada en `lelelu_fun.m`).
- `leaky_relu_fun` : Función de leaky relu.
- `leaky_relu` : Capa de activación que usa la función leaky relu (implementada en `leaky_relu_fun.m`)
- `loadpenguindata.m`: Función para leer archivo penguins_size.csv.
- `logistic.m`: Función sigmoide.
- `maeloss.m`: Capa de cálculo de pérdida con MAE.
- `metricas_evalu.m`: Implementación de métricas de evaluación de clasificación que se pueden derivar de la matriz de confusión.
- `mseloss.m`: Capa de cálculo de pérdida con MSE.
- `normalizer.m`: Clase para normalizar los datos.
- `olsloss.m`: Capa de cálculo de pérdida con OLS.
- `penguins_size.csv`: Datos utilizados para los experimentos con datos reales.
- `plot_data.m`: Módulo para mostrar los datos creados con `create_data.m`.
- `prelu_fun.m`: Función de prelu.
- `prelu.m`: Capa de activación que usa la función de prelu (implementada en `prelu_fun.m`).
- `prueba_capas_activacion.m`: Implementación de experimento para comparar capas de activación.
- `prueba_capas_perida.m`: Implementación de experimento para comparar funciones de pérdida.
- `prueba_hiper.m`: Implementación de experimento para comparar hiperparámetros.
- `prueba_metodos_opti.m`: Implementación de experimento para comparar métodos de optimización.
- `relu_fun.m`: Función de relu.
- `relu.m`: Capa de activación que usa la función de relu (implementada en `relu_fun.m`).
- `sequential.m`: Modelo secuencial, encargado de encadenar capas y pasar la información hacia adelante y hacia atrás, así como aplicar las técnicas de optimización de parámetros (aprendizaje).
- `show_image.m`: Función que se encarga producir las imágenes de clase ganadora y probabilidad de clase.
- `sigmoide.m`: Capa de activación que usa la función sigmoide (implementada en `logistic.m`) para cada entrada, e implementa los métodos hacia adelante y hacia atrás.
- `softmax_fun.m`: Función de softmax.
- `softmax.m`: Capa de activación que usa la función de softmax (implementada en `softmax_fun.m`).
- `train.m`: Archivo general usado para crear y mostrar datos, armar una red neuronal y entrenarla.
- `train_penguin.m`: Archivo similar al `train.m`, para entrenar los datos reales de los pingüinos.
- `xent.m`: Capa de cálculo de pérdida con Entropía Cruzada.

## 3. Referencias:
[1] Maniatopoulos, A., & Mitianoudi, N. (2021). Learnable Leaky ReLU (LeLeLU): An Alternative Accuracy-Optimized Activation Function: [Lelelu](https://www.mdpi.com/2078-2489/12/12/513/htm)

[2] Seetharaman, P., Wichern, G., Pardo, B., & Le Roux, J. (2020). AUTOCLIP: ADAPTIVE GRADIENT CLIPPING FOR SOURCE SEPARATION NETWORKS. 1Northwestern University, Evanston, IL, USA. Mitsubishi Electric Research Laboratories (MERL), Cambridge, MA, USA: [Autoclip](https://arxiv.org/abs/2007.14469)

## 4. Link del Archivo de Overleaf 
[Informe](https://www.overleaf.com/4188716587qvmtpxwdkmjq)
