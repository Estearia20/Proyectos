# Funcion para visualizar los resultados
function img = show_image(X,Y,Hipo)
  # Normaliza la matriz Y xque ingresa para que los valores de -1 a 1
  norm = normalizer("normal");
  Yn = norm.fit_transform(Y);

  # Asegura normalizacion sobre cada fila
  Hipo = Hipo./sum(Hipo, 2);
  
  # Extrae las posiciones en donde vale 1 la matriz Y
  [~,Ymax]=max(Yn,[],2);

  # Extrae las posiciones de los maximos de Hipo
  [~,Hipok] = max(Hipo, [], 2); 
  
  # Se define color purple
  c = [0.5, 0, 0.5];
  
  # Se realiza el coloreo de la imagen
  figure('name', 'Clases ganadoras');
  winner = (uint8(reshape(Hipok, [512 512])));
  cmap = [    0  ,0  ,0  ;
              1  ,0  ,0  ;
              0  ,0.7,0  ;
              0  ,0  ,0.8; 
              1  ,0  ,1  ;
              0  ,0.7,0.7;
              0.8,0.6,0.0; 
              0.8,0.5,0.2;
              0.2,0.5,0.3;
              0.6,0.3,0.8;
              0.6,0.1,0.4;
              0.6,0.8,0.3;
              0.1,0.4,0.6;
              0.5,0.5,0.5];

  minx = min(X(:,1));
  maxx = max(X(:,1));
  miny = min(X(:,2));
  maxy = max(X(:,2));

  wimg = ind2rgb(winner,cmap);
  img = image([minx,maxx],[miny,maxy],wimg);
  
  hold on;

  plot_data(X,Y,"brighter")
  # Realiza el scatter para las distintas clases
  %{
  %scatter(X(Ymax==1,1), X(Ymax==1,2), 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'c');
  %scatter(X(Ymax==2,1), X(Ymax==2,2), 'MarkerEdgeColor', 'k', 'MarkerFaceColor', c);
  %scatter(X(Ymax==3,1), X(Ymax==3,2), 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'b');
  %scatter(X(Ymax==4,1), X(Ymax==4,2), 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'g');
  %scatter(X(Ymax==5,1), X(Ymax==5,2), 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'r');
  %}

  # Muestra la figura con los bordes ponderados
  figure('name', 'Ponderación de colores para las clases');
  # Color map incluye rojo, verde, azul, morado y cian
  cmap  = [ 1  ,0  ,0  ;
              0  ,0.7,0  ;
              0  ,0  ,0.8; 
              1  ,0  ,1  ;
              0  ,0.7,0.7;
              0.8,0.6,0.0; 
              0.8,0.5,0.2;
              0.2,0.5,0.3;
              0.6,0.3,0.8;
              0.6,0.1,0.4;
              0.6,0.8,0.3;
              0.1,0.4,0.6;
              0.5,0.5,0.5];
  ccmap = cmap(1:columns(Hipo),:);
  # Se estiman las probabilidades de los colores
  cwimg = ccmap'*Hipo';

  # Toma los canales para colorear la imagen
  redChnl   = reshape(cwimg(1,:), [512 512]);
  greenChnl = reshape(cwimg(2,:), [512 512]);
  blueChnl  = reshape(cwimg(3,:), [512 512]);

  # Forma la imagen
  mixed = (cat(3,redChnl,greenChnl,blueChnl));
  image([minx,maxx],[miny,maxy], mixed);  
endfunction

