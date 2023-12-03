## Copyright (C) 2021-2023 Pablo Alvarado
##
## Este archivo forma parte del material del Proyecto 1 del curso:
## EL5857 Aprendizaje Automático
## Escuela de Ingeniería Electrónica
## Tecnológico de Costa Rica

## Capa densa sin sesgo
##
## Este código es un ejemplo de implementación de una capa de conexión.
## 
## La capa implementada es totalmente conectada, pero sin sesgo.
## Es decir, se calcula un plano de separación que siempre pasa por
## el origen.
##
## En principio, X es una matriz de diseño que tiene a los datos
## en sus FILAS.  Esta es la convención.  Eligiremos W para producir
## las salidas correspondientes también en las FILAS con Y = X W.  
##
## Las entradas SIEMPRE deben ser brindadas como vectores FILA, se
## supone así que la entrada es una matriz convencional de diseño.
classdef dense_unbiased < handle

  ## En GNU/Octave "< handle" indica que la clase se deriva de handle
  ## lo que evita que cada vez que se llame un método se cree un 
  ## objeto nuevo.  Es decir, en esta clase forward y backward modifican
  ## la instancia actual y no una copia, como sería el caso si no
  ## se usara "handle".

  properties
    ## Número de unidades (neuronas) en la capa
    units=0;
    
    ## Pesos de la capa densa sin sesgo
    W=[];
    
    ## Entrada de valores en la propagación hacia adelante
    inputsX=[];
    
    ## Resultados después de la propagación hacia adelante
    outputs=[];

    ## Resultados después de la propagación hacia atrás
    gradientW=[];
    gradientX=[];
  endproperties

  methods
    ## Constructor inicializa todo vacío
    ## units: número de neuronas en la capa, que es igual al número de
    ##        salidas de la capa
    function self=dense_unbiased(units)
      if (nargin > 0)
        self.units=units;
      else
        self.units=0;
      endif

      self.inputsX=[];
      self.W=[];
      self.outputs=[];
      
      self.gradientX=[];
      self.gradientW=[];
    endfunction

    ## Inicializa los pesos de la capa, considerando que la entrada
    ## de la capa tendrá un vector de entrada con el número dado de 
    ## dimensiones.
    ##
    ## La función devuelve la dimensión de la salida de la capa
    function outSize=init(self,inputSize)

      ## Dimensiones de la matriz de pesos para calcular Y=XW
      cols = self.units;
      rows = inputSize;
      
      ## LeCun Normal (para selu)
      self.W=normrnd(0,1/sqrt(cols),rows,cols);
      outSize=self.units;
    endfunction
   
    ## Retorna true si la capa tiene un estado que adaptar.
    ##
    ## En ese caso, es necesario tener las funciones stateGradient(),
    ## state() y setState()
    function st=hasState(self)
      st=true;
    endfunction
   
    ## Retorne el gradiente del estado, que existe solo si esta capa tiene
    ## algún estado que debe ser aprendido
    ##
    ## Este gradiente es utilizado por el modelo para actualizar el estado
    ## 
    function g=stateGradient(self)
      g=self.gradientW;
    endfunction
    
    ## Retorne el estado aprendido
    function st=state(self)
      st=self.W;
    endfunction
    
    ## Reescriba el estado aprendido
    function setState(self,W)
      self.W=W;
      self.units=columns(W);
    endfunction
   
    ## Propagación hacia adelante realiza Y=XW
    function y=forward(self,X,prediction=false)
      ## X debe tener sus datos en las filas
      assert(columns(X) == rows(self.W));
      
      self.inputsX=X;
      self.outputs = X*self.W; %% X matriz de diseño, asuma datos en filas
      y=self.outputs;
      
      # limpie el gradiente en el paso hacia adelante
      self.gradientX = [];
      self.gradientW = [];
    endfunction

    ## Propagación hacia atrás recibe dJ/ds de siguientes nodos del grafo,
    ## y retorna el gradiente necesario para la retropropagación. que será
    ## pasado a nodos anteriores en el grafo.
    function g=backward(self,dJds)

      assert(columns(dJds)==columns(self.W));
      assert(rows(self.inputsX)==rows(dJds));
      
      self.gradientW = self.inputsX'*dJds;
      self.gradientX = dJds*self.W';
      
      g=self.gradientX;
    endfunction
  endmethods
endclassdef
