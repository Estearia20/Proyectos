import random
from typing import List

import komm
import numpy as np

from utils.encoder import HammingCodec


def apply_awgn_channel(signal, snr_db, signal_power, semilla):
    """

    Aplica un canal de ruido gaussiano blanco aditivo (AWGN) a una señal
    de entrada.

    Args:
        signal (:obj:'list' of :obj:'int'): La señal de entrada como
            arreglo de números codificador por Hamming.
        snr_db (float): La relación señal a ruido (SNR) deseada en
            escala decibeles.
        signal_power (float): La potencia de la señal de entrada.
        semilla (int): Semilla para generar aleatorización.

    Returns:
        output_signal (:obj:'list' of :obj:'float'): La señal de entrada
            codificada por Hamming con ruido AWGN aplicado.
        C (float): Capacidad del canal en bits por dimensión.

    """

    snr_lineal = 10**(snr_db/10)
    np.random.seed(semilla)
    awgn_channel = komm.AWGNChannel(snr=snr_lineal,
                                    signal_power=signal_power)
    output_signal = awgn_channel(signal)
    c = awgn_channel.capacity()

    return output_signal, c


def dar_datos(datos_bin: List[int], group: HammingCodec) -> List[int]:
    """

    Args:
        datos_bin (List[int]): Estos son los datos en binario,
            se presentan como enteros, pero son los bits individuales
        group (HammingCodec): Es la variante que se desea usar para
            agrupar los bits

    Returns:
        List[int]: Es la lista de los mismos datos, pero ordenados en el
            valor entero que corresponda la agrupación de bits indicada,
            ya sea en grupos de 7 o 15 bits

    """

    if group == HammingCodec.VARIANTE_74:
        longitud_datos = 7
    elif group == HammingCodec.VARIANTE_1511:
        longitud_datos = 15
    else:
        raise ValueError(f'{group} no es una agrupación válida')

    # Para la codificación Hamming
    # Separa los datos en grupos de bits
    grupos_bits = []
    for i in range(0, len(datos_bin), longitud_datos):
        grupo = datos_bin[i:i+longitud_datos]
        grupos_bits.append(grupo)

    # Convierte cada grupo de bits en una cadena de caracteres
    cadenas_bits = []
    for grupo in grupos_bits:
        # Convertir a cadena
        cadena = ''.join(map(str, grupo))
        cadenas_bits.append(cadena)

    # Convierte cada cadena binaria en decimal
    numeros_decimales = []
    for cadena in cadenas_bits:
        # Convertir a decimal
        decimal = int(cadena, 2)
        numeros_decimales.append(decimal)

    return numeros_decimales


def pasar_enteros(datos_ruidosos: List[float],
                  group: HammingCodec) -> List[int]:
    """

    Args:
        datos_ruidosos (List[float]): Son los datos luego de haber
            pasado por el canal
        group (HammingCodec): Es la agrupación usada para desagrupar los
            datos y volverlos a pasar a binario

    Returns:
        List[int]: Es la lista con los datos ruidosos en binario, donde
            cada elemento de la lista es un bity

    """

    if group == HammingCodec.VARIANTE_1511:
        clip = 32768
        longitud_datos = 15
    elif group == HammingCodec.VARIANTE_74:
        clip = 127
        longitud_datos = 7

    # Limita los valores que pueden ser representandos por n bits desde 0
    # hasta clip
    canal = np.clip(datos_ruidosos, 0, clip)

    # Redondear los datos para el canal
    binary_digits = []
    for number in canal:
        rounded_number = round(number)

        # Convertir los números redondeados de 1511 a binario y rellenar con
        # ceros hasta tener n dígitos

        # Convertir a binario
        binary_string = bin(rounded_number)[2:]
        # Rellenar con ceros
        binary_string = binary_string.zfill(longitud_datos)

        # Convertir los dígitos binarios en enteros
        for bit in binary_string:
            binary_digits.append(int(bit))

    return binary_digits
