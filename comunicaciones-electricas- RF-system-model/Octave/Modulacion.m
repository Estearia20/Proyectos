%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
% En este bloque se realiza la modulacion de una señal sinusoidal a partir    %
% de una señal de informacion binaria.                                        %
%                                                                             %
% Se genera y grafica una señal de informacion NRZ Unipolar y una señal       %
% portadora modulada por la primera.                                          %
%                                                                             %
%                                                                             %
%     Integrantes:                                                            %
%                                                                             %
% -Esteban Arias                                                              %
% -David Herrera                                                              %
% -David Monge                                                                %
% -Federico Rivera                                                            %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
subplot(3,1,1)
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
 t1=bp/100:bp/100:100*length(x)*(bp/100);
 subplot(3,1,2);
 plot(t1,bit,'linewidth',2.5);grid on;
 ylabel('Amplitud (V)');
 xlabel('Tiempo (s)');
 title('Señal digital');

 %Vector de tiempo para la señal generada
 t1=bp/100:bp/100:100*length(x)*(bp/100);

 %Se grafica la señal NRZ obtenida
 subplot(3,1,2);
 plot(t1,bit,'linewidth',2.5);grid on;
 ylabel('Amplitud(V)');
 xlabel('Tiempo(s)');
 title('Señal NRZ Unipolar');

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

 m=[];
 for i=1:100:length(bit)
   if bit(i) > 0
     if bit_act == bit_ant && bit_act == 1
        y=A .* cos(2 .* pi .* f1c .* t2);
        bit_act = 1;
     else
        y=A .* cos(2 .* pi .* f1 .* t2);
        bit_act = 1;
     end
   elseif bit(i) < 0
     if bit_act == bit_ant && bit_act == 0
        y=A .* cos(2 .* pi .* f2c .* t2);
        bit_act = 0;
     else
        y=A .* cos(2 .* pi .* f2 .* t2);
        bit_act = 0;
     end
   end
   m=[m y];
   bit_ant = bit_act;
 end

%vector de tiempo para la señal generada
 t4=bp/100:bp/100:bp*length(bit)/100;

 %Se grafica la señal GFSK modulada
 subplot(3,1,3);
 plot(t4,m);grid on;
 ylabel('Amplitud(V)');
 xlabel('Tiempo(s)');
 title('Señal Digital Modulada');

 %Se finaliza funcion para medir el tiemppo de ejecucion del codigo y se presenta resultado
 tiempo_ejec = toc;
 fprintf('El tiempo de ejecucion del script fue de %.1f segundos\n', tiempo_ejec)
