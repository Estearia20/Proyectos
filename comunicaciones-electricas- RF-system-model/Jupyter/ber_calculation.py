from typing import List
import random

import numpy as np
import pandas as pd

from utils.awgn_channel import apply_awgn_channel
from utils.awgn_channel import dar_datos
from utils.awgn_channel import pasar_enteros
from utils.encoder import HammingCodec
from utils.decoder import hamming_decode_block


# Semilla para generar secuencia pseudo aleatoria
SEED = 3

# Datos provenientes de la codificacion con Hamming 1511
FILE_1511 = "datos_codificados_1511.xlsx"

# Datos provenientes de la codificacion con Hamming 74
FILE_74 = "datos_codificados_74.xlsx"

# Rango de snr a usar
VALORES_SNR = range(-10, 31, 1)


def procesar_datos(datos: List[int], variante: HammingCodec,
                   matriz_revision: np.ndarray, snr: int):
    """

    Agrega ruido a los datos codificados, los decodifica y calcula el
v    BER a partir de esto

    Args:
        datos (List[int]): Lista con los datos codificados
        variante (HammingCodec): Es la variante de código de Hamming
            usada
        matriz_revision (np.ndarray): La matriz de revision de paridad
            para decodificar

    """

    numeros_decimales = dar_datos(datos, variante)

    # Se llama la funcion que modela el canal
    canal, _ = apply_awgn_channel(signal=numeros_decimales,
                                  snr_db=snr, signal_power=5,
                                  semilla=SEED)

    binarios = pasar_enteros(canal, variante)

    _, ber = hamming_decode_block(binarios, variante.value,
                                  matriz_revision)

    return ber


def main():

    # Leer el archivo Excel
    codificacion_1511 = pd.read_excel(FILE_1511)
    codificacion_74 = pd.read_excel(FILE_74)

    datos_1511 = np.array(codificacion_1511)
    datos_74 = np.array(codificacion_74)

    # Convierte los datos a una lista
    datos_list_1511 = []
    for bit in datos_1511:
        datos_list_1511.append(datos_1511[bit][0][0])

    # Convierte los datos a una lista
    datos_list_74 = []
    for bit in datos_74:
        datos_list_74.append(datos_74[bit][0][0])

    # Calculo de matriz de revision de paridad para variante 74
    # Longitud del bloque
    n1 = 7

    # Número de bits de mensaje
    k1 = 4

    # Matriz de paridad para variante (7, 4)
    P1 = np.array([
        [1, 1, 0],
        [0, 1, 1],
        [1, 1, 1],
        [1, 0, 1]
    ])

    I_nk1 = np.eye(n1 - k1)

    # Matriz de revisión de paridad H
    H1 = np.concatenate((np.transpose(P1), I_nk1), axis=1).astype(int)

    # Calculo de matriz de revision de paridad para variante 74
    # Longitud del bloque
    n2 = 15

    # Número de bits de mensaje
    k2 = 11

    # Matriz de paridad para variante (7, 4)
    P2 = np.array([
        [1, 1, 1, 1],
        [1, 1, 1, 0],
        [1, 1, 0, 1],
        [1, 1, 0, 0],
        [1, 0, 1, 1],
        [1, 0, 1, 0],
        [1, 0, 0, 1],
        [0, 1, 1, 1],
        [0, 1, 1, 0],
        [0, 1, 0, 1],
        [0, 0, 1, 1],
    ])

    I_nk2 = np.eye(n2 - k2)

    # Matriz de revisión de paridad H
    H2 = np.concatenate((np.transpose(P2), I_nk2), axis=1).astype(int)

    bers_74 = []
    bers_1511 = []

    for snr in VALORES_SNR:
        ber_74 = procesar_datos(datos_list_74,
                                HammingCodec.VARIANTE_74, H1, snr)
        ber_1511 = procesar_datos(datos_list_1511,
                                  HammingCodec.VARIANTE_1511, H2, snr)

        bers_74.append(ber_74)
        bers_1511.append(ber_1511)

    pandas_frame = pd.DataFrame({'SNR': VALORES_SNR,
                                 'BER_74': bers_74,
                                 'BER_1511': bers_1511})
    pandas_frame.to_excel('snr_ambas_variantes.xlsx', index=False)


if __name__ == '__main__':
    main()
