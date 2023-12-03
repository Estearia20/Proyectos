## Copyright (C) 2021-2023 Pablo Alvarado
##
## Este archivo forma parte del material del Proyecto 1 del curso:
## EL5857 Aprendizaje Automático
## Escuela de Ingeniería Electrónica
## Tecnológico de Costa Rica

## "Capa" ReLU, que aplica la función max(0,x)
classdef leaky_relu < handle
  properties    
    ## Entradas de la propagación hacia adelante
    inputs=[];
    ## Resultados después de la propagación hacia atrás
    gradient=[];
  endproperties

  methods
    ## Constructor ejecuta un forward si se le pasan datos
    function self=leaky_relu()
      self.inputs=[];
      self.gradient=[];
    endfunction

    ## En funciones de activación el init no hace mayor cosa más que
    ## indicar que la dimensión de la salida es la misma que la entrada.
    ##
    ## La función devuelve la dimensión de la salida de la capa
    function outSize=init(self,inputSize)
      outSize=inputSize;
    endfunction    
    
    ## Retorna false si la capa no tiene un estado que adaptar
    function st=hasState(self)
      st=false;
    endfunction
        
    ## Propagación hacia adelante
    function y=forward(self,a,prediction=false)
      self.inputs = a;
      y = leaky_relu_fun(a);
      self.gradient = [];
    endfunction

    ## Propagación hacia atrás recibe dJ/ds de siguientes nodos
    function g=backward(self,dJds)
      if (size(dJds)!=size(self.inputs))
        error("backward de relu no compatible con forward previo");
      endif
      localGrad = self.inputs>0+(self.inputs<0)/10;
      self.gradient = localGrad.*dJds;
      g=self.gradient;
    endfunction
  endmethods
endclassdef
