function [cm,P, R]=metricas_evalu (y_t,y_v)
  
  cm = confusion_matrix(y_t,y_v); #Se calcula la matriz de confusión
  
  %Calculo de las métricas
  
  VP = diag(cm)'; #Verdaderos positivos
  FN = sum(cm, 2)' - VP; #Falsos negativos
  FP = sum(cm, 1) - VP; #Falsos positivos
  P = VP./(VP+FP); #Se calcula la precisión
  R = VP./(VP+FN); #Se calcula exhaustividad
  %Revisa condiciones de NaN
  P(isnan(P)) = 0;
  R(isnan(R)) = 0;
 
endfunction