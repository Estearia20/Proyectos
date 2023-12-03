## Copyright (C) 2021-2023 Pablo Alvarado
##
## Este archivo forma parte del material del Proyecto 1 del curso:
## EL5857 Aprendizaje Automático
## Escuela de Ingeniería Electrónica
## Tecnológico de Costa Rica
#a=0.1;
## "Capa" sigmoide, que aplica la función logística
classdef lelelu < handle
    properties    
        ## Resultados después de la propagación hacia adelante
        outputs=[];
        units=0;    
        ## Resultados después de la propagación hacia atrás
        inputsX=[];
        gradientX=[];
        gradienta=[];
        alpha=0.1;
    endproperties

    methods
        ## Constructor ejecuta un forward si se le pasan datos
        function self=lelelu(units)
        if (nargin > 0)
            self.units=units;
        else
            self.units=0;
        endif
        self.outputs=[];
        self.gradienta=[];
        self.inputsX=[];
        self.gradientX=[];
        endfunction

        ## En funciones de activación el init no hace mayor cosa más que
        ## indicar que la dimensión de la salida es la misma que la entrada.
        ##
        ## La función devuelve la dimensión de la salida de la capa
        function outSize=init(self,inputSize)
        outSize=inputSize;
        self.alpha=rand(1);
        endfunction    
        
        ## Retorna false si la capa no tiene un estado que adaptar
        function st=hasState(self)
        st=true;
        endfunction

        function g=stateGradient(self)
        g=self.gradienta;
        endfunction
        
        ## Retorne el estado aprendido
        function st=state(self)
        st=self.alpha;
        endfunction
        
        ## Reescriba el estado aprendido
        function setState(self,alpha)
        self.alpha=alpha;
        self.units=columns(alpha);
        endfunction
            
        ## Propagación hacia adelante
        function y=forward(self,X,prediction=false)
        self.inputsX=X;
        self.outputs = lelelu_fun(X,self.alpha);
        y=self.outputs;
        self.gradientX = [];
        self.gradienta = [];
        endfunction

        ## Propagación hacia atrás recibe dJ/ds de siguientes nodos
        function g=backward(self,dJds)

        %assert(columns(dJds)==columns(self.alpha));
        %assert(rows(self.inputsX)==rows(dJds));

        if (size(dJds)!=size(self.outputs))
            error("backward de LeLeLu no compatible con forward previo");
        endif

        localGrad = self.alpha .* (self.inputsX > 0) + 0.1 * self.alpha .* (self.inputsX < 0);
        %size(localGrad)
        localGrad2=0.1*self.inputsX.*(self.inputsX>0)+self.inputsX.*(self.inputsX<0);
        %size(localGrad2)
        self.gradientX = localGrad.*dJds;
        self.gradienta =sum(sum(dJds.*localGrad2)); %CON SOLO 1 SUM se comporta bien
        g=self.gradientX;
        endfunction
    endmethods  
    endclassdef
