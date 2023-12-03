# Proyecto Final: Modelado de un sistema de radiofrecuencia con corrección y detección de errores para una aplicación médica mediante un SoC nRF52832 Nordic Semiconductor
## EL-5522 - Taller de Comunicaciones Eléctricas
## Escuela de Ingeniería Electrónica
## Tecnológico de Costa Rica
## Estudiantes:
- Esteban Arias Rojas
- David Monge Naranjo
- David Herrera Castro
- Federico Rivera Moya
***
### Instalaciones necesarias para ejecutar los códigos

#### Paquetes básicos

Es recomendable en el ambiente de Anaconda instalar los paquetes básicos,para ello utilice la pestaña llamada Environments y encontrará un menú de consulta de instalación de paquetes, es por ello que para manejo básico de datos se recomienda instalar los siguientes paquetes:
- ``numpy`` 1.20.1 o superior.
- ``pandas`` 1.2.2 o superior.
- ``matplotlib`` 3.3.4 o superior.

Para instalar estos paquetes en el ambiente de conda, puede hacer eso de los siguientes comandos:

``` bash
    conda install numpy
    conda install pandas
    conda install matplotlib
```

#### Paquetes extras en el ambiente

Para ejecutar los archivos que se encuentran en la carpeta **Jupyter** es necesario tener instalados los paquetes básicos mencionados en la sección [Paquetes básicos](#basicos) y tener instalados los siguientes paquetes extras para poder ejecutar los códigos implementados:

- ``scipy``
- ``openpyxl``
- ``outliers``
- ``tabulate``
- ``spotpy``

Algunos paquetes se pueden instalar tanto con **conda** como con **pip**, sin embargo, como se está trabajando en un ambiente de **Anaconda**, la mayoria de instalaciones se realizaran por este medio. Los comandos necesarios para instalar los paquetes necesarios en el ambiente son los siguientes:

``` bash
    conda install scipy
    conda install openpyxl
    conda install tabulate
    conda install scikit-learn
    pip install outlier_utils
    pip install spotpy
```

#### Ambiente de conda utilizado
A continuación se presenta como puede utilizar el ambiente de conda utilizado para este proyecto, este ya contiene todos los paquetes necesarios para ejecutar los archivos, por lo que no le será necesario instalar cada uno de los comandos mencionados en [Paquetes básicos](#basicos) y en [Paquetes extras en el ambiente](#extras). El ambiente utilizado se encuentra en el el archivo `enviroment.yml`, este lo puede acceder mediante el siguiente enlace : [Enlace ambiente utilizado](enviroment.yml).

Para instalarlo, proceda a descargarlo y posteriormente ejecute en siguiente comando en la terminal, ubicado en el mismo directorio donde descargó el archivo `enviroment.yml`:

``` bash
    conda env create -f enviroment.yml
``` 
Esto creará un nuevo ambiente con el mismo nombre y las mismas dependencias que estaban en el ambiente original. Una vez creado el ambiente, active el ambiente utilizando el siguiente comando:

``` bash
    conda activate TC
``` 
Al activar el ambiente, ya podrá ejecutar los archivos realizados para el proyecto, sin necesidad de instalar nuevos paquetes para el adecuado funcionamiento.