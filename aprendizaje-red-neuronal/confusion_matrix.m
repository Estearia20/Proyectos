function l=confusion_matrix(y_t,y_v)
  # Se acceden a los indices de y_t
  [value2,index2]=max(y_t,[],2);

  # Se hace el one hot encoded segun donde esta el maximo determinado antes
  y_tm = eye(columns(y_t))(index2,:);

  # Se acceden a los indices de los maximos de cada matriz
  [c,d] = max(y_tm,[],2);
  [e,f] = max(y_v,[],2);

  # El accumarray permite obtener la matriz de confusion
  l_t = accumarray([f,d],1);

  # Revise que la matriz de salida sea cuadrada
  if(size(l_t,1)==size(l_t,2))
    l = l_t;
  
  # De no serlo le concatena las columnas restantes
  else
    while(size(l_t,1)!=size(l_t,2))
        l_t = horzcat(l_t, zeros(size(l_t,1),1));
    endwhile
    
    l = l_t;
  end
endfunction
