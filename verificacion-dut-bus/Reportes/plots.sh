# Nombre del archivo de salida de la gráfica
set terminal pngcairo enhanced font "arial,14" size 800,600
set output 'retardo.png'

# Título de la gráfica
set title "Retardo promedio en función del número de transacciones"

# Etiquetas de los ejes
set xlabel "# Transacciones"
set ylabel "Latencia [s]"

#Habilitar el grid
set grid

#Posicion de la leyenda
set key bottom right

# Rango de los ejes si es necesario
# set xrange [xmin:xmax]
# set yrange [ymin:ymax]

# Establecer el formato de los datos CSV
set datafile separator ','

# Graficar las columnas 1-5
plot "report4.csv"  using 1:5 title "4 drvs" with linespoints, \
     "report8.csv"  using 1:5 title "8 drvs" with linespoints, \
     "report12.csv" using 1:5 title "12 drvs" with linespoints,\
     "report16.csv" using 1:5 title "16 drvs" with linespoints


####################################################################

# Cambiar el nombre del archivo de salida
set output 'bw.png'

# Título de la segunda gráfica
set title "Ancho de banda en funcion del número de transacciones"

# Etiquetas de los ejes para la segunda gráfica
set xlabel "# Transacciones"
set ylabel "Ancho de banda [Gbps]"

# Habilitar el grid para la segunda gráfica
set grid

# Posición de la leyenda abajo a la derecha para la segunda gráfica
set key top right

# Segunda gráfica
plot "report4.csv"  using 1:6 title "4 drvs" with linespoints, \
     "report8.csv"  using 1:6 title "8 drvs" with linespoints, \
     "report12.csv" using 1:6 title "12 drvs" with linespoints,\
     "report16.csv" using 1:6 title "16 drvs" with linespoints

# Mostrar ambas gráficas
replot


####################################################################

# Cambiar el nombre del archivo de salida
set output 'bwmax.png'

# Título de la tercera gráfica
set title "Ancho de banda máximo en funcion del número de dispositivos"

# Etiquetas de los ejes para la tercera gráfica
set xlabel "# Dispositivos"
set ylabel "Ancho de banda máximo [Gbps]"

# Se establece el rango del eje x
set xrange [0:32]
# Se establece el paso del eje x
set xtics 4
# Habilitar el grid para la tercera gráfica
set grid

# Posición de la leyenda abajo a la derecha para la tercera gráfica
set key top right

# Tercera gráfica
plot "bw_report.csv"  using 1:2 title "BW_{max}" with linespoints

# Mostrar gráfica
replot


####################################################################

# Cambiar el nombre del archivo de salida
set output 'bwmin.png'

# Título de la cuarta gráfica
set title "Ancho de banda mínima en funcion del número de dispositivos"

# Etiquetas de los ejes para la cuarta gráfica
set xlabel "# Dispositivos"
set ylabel "Ancho de banda mínimo [Gbps]"

# Se establece el rango del eje x
set xrange [0:32]
# Se establece el paso del eje x
set xtics 4
# Habilitar el grid para la cuarta gráfica
set grid

# Posición de la leyenda abajo a la derecha para la cuarta gráfica
set key top right

# Cuarta gráfica
plot "bw_report.csv"  using 1:3 title "BW_{min}" with linespoints

# Mostrar gráfica
replot

