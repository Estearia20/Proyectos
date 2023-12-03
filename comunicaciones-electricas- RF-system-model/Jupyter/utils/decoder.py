"""

En este módulo se incluyen las funciones necesarias para la
decodificación de datos usando las variantes de Hamming (7, 4) y
(15, 11).

"""

from typing import List, Union
from enum import Enum

import numpy as np

from utils.encoder import HammingCodec, float2bin, bin2int


def hamming_decode(encoded_data: List[int], H: np.ndarray) -> List[int]:
    """ Decodifica un vector codificado utilizando código de Hamming

    Args:
        encoded_data (:obj:'List' of :obj:'int'): Vector codificado que se va a
            decodificar
        H (np.ndarray): Matriz de comprobación de paridad del código de Hamming

    Returns:
        decoded_data (:obj:'List' of :obj:'int'): Vector de datos decodificados

    Raises:
        ValueError: Si la cantidad de bits de 'encoded_data' no es igual a la
            cantidad de filas que la matriz de comprobación de paridad 'H'

    """
    # Asegurarse de que los datos de entrada tienen la longitud correcta
    if len(encoded_data) != H.shape[1]:
        raise ValueError("La longitud de 'encoded_data' no coincide con la cantidad de columnas de H")

    # Convertir los datos de entrada en un arreglo numpy
    encoded_array = np.array(encoded_data)

    # Calcular el síndrome (producto de la matriz de comprobación de paridad y los datos codificados)
    syndrome = np.dot(encoded_array, H.T) % 2

    error_bits = 0

    # Determinar el índice del bit erróneo (si hay un error)
    if any(syndrome != np.zeros(H.shape[0])):
        error_bits += 1
        error_index = np.where((syndrome == H.T).all(axis=1))[0][0]
        encoded_array[error_index] = (encoded_array[error_index] + 1) % 2

    # Decodificar los datos
    decoded_data = list(encoded_array[:H.shape[1] - H.shape[0]])

    return decoded_data, error_bits


def hamming_decode_block(bloque_codificado: List[int],
                         sistema_codec: HammingCodec,
                         H: np.ndarray) -> List[int]:
    """ Decodifica un bloque de bits codificado utilizando código de Hamming

    Args:
        bloque_codificado (:obj: 'List' of :obj: 'int'): Bloque de bits codificado
            que se desea decodificar
        sistema_codec (HammingCodec): Variante de codificación de
            Hamming usada, puede ser 74 ó 1511
        H (np.ndarray): Matriz de comprobación de paridad usada para decodificar
            el bloque de bits

    Returns:
        bloque_decodificado (:obj: 'List' of :obj: 'int'): Bloque de bits decodificado

    Raises:
        ValueError: Si la longitud del bloque_codificado no es un múltiplo de la longitud del segmento

    """
    codec = HammingCodec.from_string(sistema_codec)

    if codec == HammingCodec.VARIANTE_74:
        longitud_segmento = 7
    else:
        longitud_segmento = 15

    # Asegurarse de que la longitud del bloque_codificado sea un múltiplo de la longitud del segmento
    if len(bloque_codificado) % longitud_segmento != 0:
        raise ValueError("La longitud del bloque_codificado no es un múltiplo de la longitud del segmento")

    bloque_decodificado = []
    errores_totales = 0
    ber = 0

    for i in range(0, len(bloque_codificado), longitud_segmento):
        segmento_codificado = bloque_codificado[i:i + longitud_segmento]

        # Decodificar el segmento utilizando la función hamming_decode
        segmento_decodificado, error_bits = hamming_decode(segmento_codificado, H)

        errores_totales += error_bits

        # Agregar los datos decodificados al bloque decodificado
        bloque_decodificado += segmento_decodificado

    ber = errores_totales / len(bloque_decodificado)

    return bloque_decodificado, ber
