# Portafolio de Proyectos - Instituto Tecnológico de Costa Rica

¡Bienvenido a mi portafolio de proyectos! En este repositorio, encontrarás una recopilación de los proyectos en los que he trabajado durante mi tiempo en el Instituto Tecnológico de Costa Rica.

## Proyectos Destacados

### Aprendizaje Automático - Red Neuronal

En este proyecto se implementó una red neuronal, para comprender los principios de funcionamiento detrás de los métodos dominates del aprendizaje automático. Para ello se utilizará primero un problema de "juguete" en dos dimensiones, que facilita la visualización de resultados y el proceso de desarrollo y depuración. Si los métodos son realizados correctamente, la red es aplicable a cualquier tipo de problema, y se probará con el conjunto de datos de pinguinos.

Se ha llevado a cabo la implementación del cálculo de la función de error o pérdida mediante grafos computacionales Este grafo facilita el cálculo del gradiente mediante retropropagación, fundamental para los métodos de optimización que buscan encontrar los parámetros óptimos de la red neuronal utilizando un conjunto de entrenamiento. Este proceso es central en marcos de trabajo como **TensorFlow** o **PyTorch**.

El proyecto ha sido programado en **GNU/Octave**, partiendo de una base de código que establece las interfaces de las funciones y clases a utilizar, junto con un modelo secuencial configurable. Se ha llevado a cabo la evaluación del rendimiento de la red, variando diversos hiperparámetros disponibles.

### Arquitectura de Computadoras - Simulador de Procesador RISC V

En este proyecto, se implementó un simulador para un procesador RISC-V escalar, en orden, y con 5 etapas de pipeline. El simulador es capaz de recibir un programa en lenguaje ensamblador, ejecutarlo y producir el resultado correcto. Durante la ejecución, proporciona información detallada sobre la instrucción en proceso en cada etapa del pipeline, además de ofrecer métricas de evaluación.

Adicionalmente, en el marco de este proyecto, se integró un predictor de saltos dinámico para el simulador del procesador RISC-V. Este predictor se implementó utilizando un Branch Target Buffer (BTB) para almacenar direcciones de salto calculadas y determinar, a partir del Program Counter (PC), si se trata de una instrucción de salto. Asimismo, se incorporó un predictor de dirección basado en un contador de 2 bits. Este enfoque mejoró la capacidad del simulador para anticipar y gestionar instrucciones de salto de manera más eficiente.

EL proyecto ha sido programado en **Assambler** y **Python**.

## Taller de Comunicaciones Electricas - Modelado de un Sistema de Radiofrecuencia para una Aplicación Médica


En este proyecto, se ha llevado a cabo un exhaustivo estudio de algoritmos de detección/corrección de errores, preprocesamiento de señales y esquemas de modulación. Estas temáticas son fundamentales en el ámbito de las comunicaciones eléctricas y se han aplicado de manera específica a un caso de estudio en el área médica, particularmente en las pruebas de esfuerzo realizadas por profesionales en cardiología, también conocidas como pruebas de ecostress.

Esta convergencia de hardware y software ha sido diseñada para cumplir con condiciones de tiempo real, así como para satisfacer requisitos exigentes en procesamiento, almacenamiento y ejecución que demanda la industria. En este contexto, se han utilizado técnicas de codificación y decodificación Hamming, incluyendo las configuraciones Hamming 15-11 y 7-4, para mejorar la integridad y confiabilidad de los datos.

En este proyecto, el enfoque se ha centrado en la aplicación práctica de habilidades desarrolladas en arquitectura de computadoras, programación, análisis de antenas, modulaciones digitales y teoría electromagnética. El estudiante ha utilizado estas habilidades, incluyendo la implementación de técnicas de codificación y decodificación Hamming, para abordar la problemática planteada en el contexto de las comunicaciones eléctricas. Se han empleado prácticas de desarrollo comúnmente utilizadas en la industria, proporcionando una perspectiva aplicada y relevante en este campo específico.

La antena fue diseñada utilizando el software **Eagle** , la modulacion fue realizada mediante GFSK y demodulacion mediante discriminador FM, utilizando el **GNU/Octave**, y todo el sistema de transmisión y recepción fue diseñado en **Python** apoyado de la herramienta **Jupyter Notebook**.

## Laboratorio de Control Automático - Diseño de Controles para Diferentes Plantas

Este proyecta muestra , el diseño e implementación de sistemas de control automático SISO, SIMO y MIMO para la resolución de problemas complejos de ingeniería de final abierto. Durante el proceso, se consideraron requisitos técnicos, normas de seguridad y estándares de la industria.


En este repositorio se muestra como modelar plantas analíticas y empíricamente; diseñar reguladores electrónicos IMC, PID y REI mediante la ubicación de polos para plantas SISO, así como diseñar reguladores REI mediante ubicación de polos y LQR para plantas SIMO y MIMO, asegurando su cumplimiento de exigencias estáticas y dinámicas ante variaciones en la consigna o perturbaciones; simular el funcionamiento integral de la planta, el regulador e implementar de manera electrónica reguladores IMC, PID y REI para plantas SISO, así como implementar reguladores REI para plantas SIMO y MIMO. Todo esto se realizó utilizando el software **Matlab** con ayuda de otras herramientas como **Excel**.

## Taller de Diseño Digital - Diseño de Procesador RISC V 


El siguiente proyecto muestra el diseño de un procesador RISC V, el cual demandó trabajo en equipo para diseñar e implementar un sistema digital complejo. La parte central de este proyecto consistió en el diseño de un microcontrolador, cuya implementación siguió la arquitectura de computadora existente, RV32i, utilizando **System Verilog**. El programa ejecutado en este microcontrolador coordinó un módulo encargado de controlar las lecturas del sensor de luminosidad (a través de comunicación SPI), un temporizador interno (Timer), las entradas de un teclado USB y switches, así como las salidas hacia LEDs, display de 7 segmentos y puerto serie (RS-232). La complejidad del sistema implementado se manejó mediante una disciplina rigurosa de implementación: cada módulo contó con las pruebas (testbenches) necesarias para garantizar su correcto funcionamiento a nivel de pre- y post-síntesis, así como de implementación. Esto resultó especialmente crucial para el microcontrolador implementado, asegurando que el programa implementado se ejecutara de manera correcta en la FPGA.

## Verificiación Funcional de Circuitos Integrados - DUT - Bus de Datos

Este proyecto muestra el diseño de un modelo de verificación para un bus de datos, especificamente el **Modelo de Aleatorización Controlado en Capas**. Este modelo se diseñó utilizando **System Verilog** donde cada uno de los módulos funcionan por en un proceso aparte. El ambiente de verificación permite crear lo que son reportes en formato **csv** para poder graficar parámetros como lo son la latencia y  ancho de banda al variar valores como el tamaño del paquete de datos a enviar, la profundidad de las FIFO's, esto utilizando **gnuplot**. 

## Verificiación Funcional de Circuitos Integrados - DUT - Mesh 

Este proyecto muestra el diseño de un modelo de verificación para un Mesh para transmitir datos entre terminales, especificamente el **Modelo de Aleatorización Controlado en Capas**. Este modelo se diseñó utilizando **System Verilog** donde cada uno de los módulos funcionan por en un proceso aparte. El ambiente de verificación permite crear lo que son reportes en formato **csv** para poder graficar parámetros como lo son la latencia y  ancho de banda al variar valores como el tamaño del paquete de datos a enviar, la profundidad de las FIFO's, esto utilizando **gnuplot**. 

## Verificiación Funcional de Circuitos Integrados - DUT - Mesh - UVM

Este proyecto muestra el diseño de un modelo de verificación para un Mesh para transmitir datos entre terminales, especificamente utilizando el modelo de verificación **UVM**. Este modelo se diseñó utilizando **System Verilog** donde cada uno de los módulos funcionan por en un proceso aparte. El ambiente de verificación permite crear lo que son reportes en formato **csv** para poder graficar parámetros como lo son la latencia y  ancho de banda al variar valores como el tamaño del paquete de datos a enviar, la profundidad de las FIFO's, esto utilizando **gnuplot**. 


## Contacto

Si tienes alguna pregunta o te gustaría discutir alguno de estos proyectos, ¡no dudes en contactarme!

- [Correo Electrónico](estearia20@gmail.com)
- [LinkedIn](www.linkedin.com/in/e-ariasr)
- [Sitio Web/Portafolio Personal](https://estearia20.wixsite.com/cv-earias)
