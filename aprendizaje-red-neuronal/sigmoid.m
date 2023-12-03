## Copyright (C) 2021-2023 Pablo Alvarado
##
## Este archivo forma parte del material del Proyecto 1 del curso:
## EL5857 Aprendizaje Automático
## Escuela de Ingeniería Electrónica
## Tecnológico de Costa Rica

## "Capa" sigmoide, que aplica la función logística
classdef sigmoid < handle
  properties    
    ## Resultados después de la propagación hacia adelante
    outputs=[];
    ## Resultados después de la propagación hacia atrás
    gradient=[];
  endproperties

  methods
    ## Constructor ejecuta un forward si se le pasan datos
    function self=sigmoid()
      self.outputs=[];
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
      self.outputs = logistic(a);
      y=self.outputs;
      self.gradient = [];
    endfunction

    ## Propagación hacia atrás recibe dJ/ds de siguientes nodos
    function g=backward(self,dJds)
      if (size(dJds)!=size(self.outputs))
        error("backward de sigmoide no compatible con forward previo");
      endif
      localGrad = self.outputs.*(1-self.outputs);
      self.gradient = localGrad.*dJds;
      g=self.gradient;
    endfunction
  endmethods
endclassdef
