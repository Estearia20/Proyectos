%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                                     %
% En este bloque se realiza la modulacion GFSK y demodulacion mediante discriminador  %
% FM de una señal sinusoidal a partir de una señal de informacion binaria.            %
%                                                                                     %
% Se genera y grafica una señal de informacion NRZ Unipolar y una señal               %
% portadora modulada por la primera, luego se utiliza un discriminador de frecuencia  %
% para la demodulacion de la señal, dando como resultado una nueva señal de           %
% informacion NRZ.                                                                    %
%                                                                                     %
%     Integrantes:                                                                    %
%                                                                                     %  
% -Esteban Arias                                                                      %
% -David Herrera                                                                      %
% -David Monge                                                                        %
% -Federico Rivera                                                                    %
%                                                                                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;
clear all;
close all;

%Se inicia funcion tic toc para medir el tiempo de ejecucion del codigo
tic

%Se utiliza un menu para realizar la seleccion entre los dos sets de datos codificados, carga la informacion desde un archivo .txt
%Si no se realiza una seleccion valida el script carga el set de datos 7,4 como predeterminado
Menu = true;
while Menu == true
    fprintf('Menu:\n');
    fprintf('1. Cargar datos codificados 7,4 1\n');
    fprintf('2. Cargar datos codificados 15,11 2\n');

    choice = input('Cual set de datos desea cargar, digite 1 o 2: ');


    switch choice
            case 1
                data = load('datos_codificados_74.txt');
                data = textread('datos_codificados_74.txt');
                Menu = false;
            case 2
                data = load('datos_codificados_1511.txt');
                data = textread('datos_codificados_1511.txt');
                Menu = false;
    end
end

x = data(:);

%Se define el periodo de bit para todo el script
bp=.000001;

%%%%%%%% Parametros para filtro gaussiano  %%%%%%%%%%


sigma = 10; %Desviacion estandar del filtro, controla su ancho
largo_filtro = 61; %Determina cuantos puntos se utilizan en el nucleo gaussiano, idealmente debe ser un nimero impar para mantener un punto central
t3 = -(largo_filtro - 1)/2:(largo_filtro - 1)/2;  % Crea un vector de tiempo para la aplicacion del filtro


%%%%%%%%%%   Se define el filtro gaussiano   %%%%%%%%%%%%%%
filtro_gauss = exp(-t3.^2 / (2 * sigma^2)) / (sigma * sqrt(2 * pi));


%%%%%%%%%%   Se normaliza el filtro gaussiano para que tenga un area igual a la unidad, se evitan errores de amplitud    %%%%%%%%%%%
filtro_gauss = filtro_gauss / sum(filtro_gauss);

%Se grafica la forma del filtro gaussiano
subplot(4,1,1)
stem(t3, filtro_gauss, 'filled');
title('Forma del filtro gaussiano');
grid on;

%%%%%%%%%%%%%%%   Generacion de una señal NRZ bipolar filtrada por el filtro gaussiano, esta es basada en los datos del archivo de informacion codificada      %%%%%%%%%%%%%%%%%%%%%%%%%%%
bit=[];
for n=1:1:length(x)
  if x(n)==1;
    s=ones(1,100);
  else x(n)==0;
    s=ones(1,100);
    s = -s;
  end
  s_filt = conv(s, filtro_gauss, 'same');
  bit=[bit s_filt];
 end

 %Vector de tiempo para la señal generada
 t1=bp/100:bp/100:100*length(x)*(bp/100);

 %Se grafica la señal NRZ obtenida
 subplot(4,1,2);
 plot(t1,bit);grid on;
 ylabel('Amplitud(V)');
 xlabel('Tiempo(s)');
 title('Señal NRZ Bipolar');

 %%%%%%%%%%%%%%%%%%%%   Modulacion GFSK de la señal de informacion NRZ generada     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


 %%%%%% Parametros para la señal modulada %%%%%%%%

 A=5; %Amplitud de la señal de carry
 br=1/bp; %bit rate
 f1=linspace(br.*3,br.*5,100); %transicion de frecuencias de 0 a 1
 f2=linspace(br.*4,br.*3,100); %transicion de frecuencias de 1 a 0
 f1c=br.*6; %Frecuencia de la señal cuando se envia un 1
 f2c=br.*2; %Frecuencia de la señal cuando se envia un 0
 t2=bp/100:bp/100:bp; %vector de tiempo para la señal modulada


 %%%%%%%%%%%%%%%%%%     Se realiza la modulacion de la señal de informacion con una portadora sinusoidal   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 %Se definen los parametros bit anterior y actual para poder realizar una comparacion, se le asignan valores opuestos para inicializar la modulacion segun el primer dato de la señal de entrada
 bit_ant = 0;
 bit_act = 1;

 m=[];   %Array de modulacion
 k=[];   %Array de control para el receptor
 for i=1:100:length(bit)
   if bit(i) > 0
     if bit_act == bit_ant && bit_act == 1
        y=A .* cos(2 .* pi .* f1c .* t2);
        w=A .* cos(2 .* pi .* f1c .* t2);
        bit_act = 1;
     else
        y=A .* cos(2 .* pi .* f1 .* t2);
        w=A .* cos(2 .* pi .* f1c .* t2);
        bit_act = 1;1
     end
   elseif bit(i) < 0
     if bit_act == bit_ant && bit_act == 0
        y=A .* cos(2 .* pi .* f2c .* t2);
        w=A .* cos(2 .* pi .* f2c .* t2);
        bit_act = 0;
     else
        y=A .* cos(2 .* pi .* f2 .* t2);
        w=A .* cos(2 .* pi .* f2c .* t2);
        bit_act = 0;
     end
   end
   m=[m y];
   k=[k w];
   bit_ant = bit_act;
 end

%vector de tiempo para la señal generada
 t4=bp/100:bp/100:bp*length(bit)/100;

 %Se grafica la señal GFSK modulada
 subplot(4,1,3);
 plot(t4,m);grid on;
 ylabel('Amplitud(V)');
 xlabel('Tiempo(s)');
 title('Señal Digital Modulada');

 %%%%%%%%%%%%%%%%%%%% DEMODULADOR %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%captura del vector de tiempo de la señal modulada y almacena en un array %
CT = length(t2);
mdemo = [];

%inicializa el loop de captura de datos
for n=CT:CT:length(k)
  t=bp/100:bp/100:bp; %vector de tiempo para la captura

  %Definicion de señal cuando llega un 1 o un 0 segun frecuencias portadoras
  y1 = cos(2 * pi * t * f1c);
  y2 = cos(2 * pi * t * f2c);

  % Mutiplica las señales coseno de bit 1 o 0 con el segmento actual de la señal modulada
  demof1 = y1 .* k((n-(CT-1)):n);
  demof2 = y2 .* k((n-(CT-1)):n);


  t5=bp/100:bp/100:bp; % Crea un vector de tiempo para un bit

  % Integracion y redondeo de la señal resultante de la multiplicacion
  z1=trapz(t5,demof1);
  z2=trapz(t5,demof2);
  zz1=round(2 * z1/bp);
  zz2=round(2 * z2/bp);

  % Condicionales para definir un 1 o un 0 segun el resultado de la integracion

  % Si el resultado de la integración para el bit 1 es mayor que la mitad de la amplitud el bit demodulado es 1
  if(zz1 > A/2)
    a=1;
  % Si el resultado de la integración para el bit 0 es mayor que la mitad de la amplitud el bit demodulado es 0
   else(zz2 > A/2)
    a=0;
  end

  % Agrega el bit demodulado al arrray de bits demodulados
  mdemo = [mdemo a];
end

% Muestra los bits demodulados
disp('Informacion capturada: ');
disp(mdemo);

%%%%%%%%%% representacion de la informacion binaria como señal digital  %%%%%%
%%%%%%%%%% luego de la demodulacion                                     %%%%%%


bit = []; % Inicializa un vector vacío para almacenar la señal digital demodulada

% Itera sobre los bits demodulados y genrea una señal NRZ polar
for n=1:length(mdemo)

  % Si el bit demodulado es 1 la señal se posiciona en amplitud 1
  if mdemo(n)==1;
    se=ones(1,100);

  % Si el bit demodulado es 0 la señal se posiciona en amplitud -1
  else mdemo(n)==0;
    se=ones(1,100);
    se=-se;
  end
  bit=[bit se]; % Agrega la señal generada a la señal digital demodulada
end

% Grafica la señal digital demodulada

t6=bp/100:bp/100:100*length(mdemo)*(bp/100); % Crea un vector de tiempo para la señal digital demodulada
subplot(4,1,4);
plot(t6,bit);
grid on;
axis([ 0 bp*length(mdemo) -.5 1.5]);
ylabel('Amplitud(V)');
xlabel('Tiempo(s)');
title('Señal Digital NRZ Bipolar Recibida');



 %Se finaliza funcion para medir el tiemppo de ejecucion del codigo y se presenta resultado
 tiempo_ejec = toc;
 fprintf('El tiempo de ejecucion del script fue de %.1f segundos\n', tiempo_ejec)
