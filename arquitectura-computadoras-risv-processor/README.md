# Proyecto 2: Predictor de saltos en simulador de procesador RISC-V
### EL4314 - Arquitectura de Computadoras I
### Escuela de Ingeniería Electrónica
### Tecnológico de Costa Rica

<br/><br/>

### Preámbulo
En este proyecto, usted implementará un predictor de saltos dinámico para su simulador de un procesador RISC-V, escalar y de ejecución en orden, desarrollado en el proyecto 1. Su modelo de predictor de saltos deberá implementarse empleando un _Branch Target Buffer_ (BTB) para almacenar direcciones de salto calculadas así como determinar si se trata, a partir del _Program Counter_ (PC), de una instrucción de salto, y un predictor de dirección basado en un contador de 2 bits; todo esto tal y como se explicó en clase.

simulador, simple, para un procesasor RISC-V escalar, en orden, y con 5 etapas de _pipeline_. Para ello considere el diseño que se propone y describe en el capítulo 4 del Patterson y Hennessy. Dicho simulador deberá ser capaz de recibir un programa en lenguaje ensamblador y ejecutarlo, produciendo el resultado correcto. Deberá indicar en cada momento de la ejecución qué instrucción se está ejecutando en cuál etapa del _pipeline_ y proveer métricas de evaluación.


### Requisitos
Considere las siguientes características para el modelado e incorporación del predictor de saltos dinámico en su simulador:

- Deberá realizar la implementación del predictor de saltos dinámico empleado Python como lenguaje de programación.
- El simulador debera contar con la posibilidad de activar o desactivar la predicción de saltos antes de la ejecución de un programa. De igual manera, el simulador deberá permitir activar o desactivar la detección de riesgos de datos y su corrección mediante _forwarding_. En caso de que ninguna técnica de mitigación de riesgos de datos y/o control se active, el simulador deberá introducir _stalls_ o realizar _flush_ de manera apropiada para permitir la correcta ejecución.
- Considere que el cálculo de la direccion de salto se realiza en la etapa de _Execute_ del procesador. 
- En la etapa de _Instruction Fetch_, al mismo tiempo que se toma el valor del PC para acceder a la memoria de programa y extraer la instrucción, el valor del PC se emplea para acceder la BTB y extraer la dirección de salto (_target address_) en caso de que ya dicha dirección se haya calculado y almacenado en la BTB. Si el acceso a la BTB resulta en un _miss_ y se trata de una instrucción de salto, lo cual se conoce hasta la etapa de _Instruction Decode_, la dirección de salto que se calcula en la etapa de _Execute_ se almacena de forma correspondiente en la BTB.
- En la etapa de _Execute_, además de calcular la dirección de salto, se confirma si el salto se toma o no. Esta información es importante para actualizar el contador de 2 bits de acuerdo con la máquina de estados vista en clase. Si, por ejemplo, la predicción estableció que el salto se tomaba pero en la etapa de _Execute_ se determinó que el salto no debía tomarse, el simulador deberá realizar un _flush_ del _pipeline_ para las instrucciones anteriores al salto y deberá cargar en PC el valor correcto de la dirección d ela instrucción que se deberá ejecutar.
- Desarrolle 1 programa de prueba, suficientemente complejo, y con sentido algorítmico (no solamente un poco de instrucciones juntas) con el que pueda evaluar los siguientes 4 casos: a) ejecución sin _forwarding_ ni predicción de saltos, b) ejecución con _forwarding_ pero sin predicción de saltos, c) ejecución con predicción de saltos pero sin _forwarding_, y d) ejecución con _forwarding_ y predicción de saltos activos. Reporte los resultados de instrucciones ejecutadas, ciclos de reloj y CPI para cada uno de estos escenarios de ejecución.

### Advertencia
Aún cuando existen implementaciones disponibles que realizan, en una u otra medida, lo que aquí se les solicita, está prohibido utilizar código existente de algún repositorio (aún cuando este se encuentre abierto y el licenciamiento de que posea permita su utilización).


## Evaluación
Este proyecto se evaluará con la siguiente rúbrica:


| Rubro | % | C | EP | D | NP |
|-------|---|---|----|---|----|
|Implementación del predictor de saltos | 40|   |  X  |   |    |
|Integración en simulador | 30| X  |    |   |    |
|Evaluación con benchmark propuesto | 20| X  |    |   |    |
|Uso de repositorio|10| X  |    |   |    |

C: Completo,
EP: En progreso ($\times 0,8$),
D: Deficiente ($\times 0,5$),
NP: No presenta ($\times 0$)

## Importante
- El uso del repositorio implica que existan contribuciones de todos los miembros del equipo. 
- La revisión del simulador con el predictor de saltos se deberá realizar antes de las 17:00 del jueves 15 de junio. Para dicha revisión, deberá agendar una cita con antelación.
