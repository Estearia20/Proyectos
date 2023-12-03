## Copyright (C) 2021-2023 Pablo Alvarado
##
## Este archivo forma parte del material del Proyecto 1 del curso:
## EL5857 Aprendizaje Automático
## Escuela de Ingeniería Electrónica
## Tecnológico de Costa Rica

## Función softmax
function l=softmax_fun(x)
  c = max(x');
  expo = exp(x'-c);
  suma = sum(expo);
  l = (expo./suma)';
endfunction