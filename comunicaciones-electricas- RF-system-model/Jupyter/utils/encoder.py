"""

En este módulo se incluyen las funciones necesarias para la codificación
de datos usando las variantes de Hamming (7, 4) y (15, 11). Incluye
además funcionalidades de pre-procesamiento como la conversión de punto
flotante o entero a binario.

"""

from typing import List, Union
from enum import Enum

import numpy as np


class HammingCodec(Enum):
    """

    Clase Enum que representa los esquemas de codificación 7,4 y 15,11
    de Hamming

    Attributes:
        VARIANTE_74 (int)
        VARIANTE_1511 (int)

    """

    VARIANTE_74 = 74
    VARIANTE_1511 = 1511

    @staticmethod
    def from_string(value: str) -> Enum:
        """
        
        Converts a string value to the corresponding HammingCodec enum

        Args:
            value (str): The string value representing the codification
                scheme

        Returns:
            Enum: The corresponding Hamming codec enum

        Raises:
            ValueError: If the provided value is not a valid
                HammingCodec

        """

        for item in HammingCodec:
            if item.value == value:
                return item
        raise ValueError(f"Invalid Codec: {value}")


def hamming_encode(data: List[int], G: np.ndarray) -> List[int]:
    """ Codifica vector de entrada utilizando código de Hamming

    Args:
        data (:obj:'List' of :obj:'int'): Vector de entrada que se va a
            codificar
        G (np.ndarray): Matriz generadora del código de Hamming

    Returns:
        encoded_data (:obj:'List' of :obj:'int'): Vector de salida del
            mensaje codificado

    Raises:
        ValueError: Si la cantidad de bits de 'data' no es igual a la
            cantidad de filas que la matriz generadora 'G'

    """

    # Asegurarse de que los datos de entrada son 4 bits
    if len(data) != G.shape[0]:
        raise ValueError("Se esperan 'filas de G' bits de datos",
                         "como entrada")

    # Convertir los datos de entrada en un arreglo numpy
    data_array = np.array(data)

    # Codificar los datos usando la matriz generadora G
    encoded_data = np.dot(data_array, G) % 2
    encoded_data = list(encoded_data)

    return encoded_data


def float2bin(numero: Union[int, float]) -> str:
    """ Conversión de entero o punto flotante a binario en 8 bits

    Args:
        numero (Union[int, float]): Número entero a convertir

    Returns:
        resultado (str): Cadena binaria del número entero

    Raises:
        ValueError: Si "numero" es más grande que 255, no se puede
            representar en 8 bits
        ValueError: Si "numero" es negativo
        ValueError: Si "numero" no es una variable de tipo entero o
            en punto flotante

    """

    if not isinstance(numero, float) and not isinstance(numero, int):
        raise ValueError(f'{numero} debe ser un número entero o en punto flotante')
    if numero > 255:
        raise ValueError(f'{numero} no es representable en 8 bits')
    if numero < 0:
        raise ValueError(f'{numero} es no puede ser menor que cero')

    int_value = int(round(numero))

    resultado = f'{int_value:08b}'

    return resultado


def bin2int(numero: str) -> int:
    """ Conversión de binario a entero

    Args:
        numero (str): Número binario representado en string

    Returns:
        resultado (int): Número en formato integer del valor binario

    Raises:
        ValueError: Si "numero" no es un valor en base 2

    """

    try:
        resultado = int(numero, 2)

    except ValueError as exc:
        raise ValueError(f'{numero} no es presenta el formato binario correcto') from exc

    return resultado


def hamming_encode_block(bloque: List[int],
                         sistema_codec: HammingCodec,
                         G: np.ndarray) -> List[int]:
    """ Aplica codificación de Hamming a una lista de bits

    Args:
        bloque (:obj: 'List' of :obj: 'int'): Lista de bits a los que se
            desea aplicar la codificación
        sistema_codec (HammingCodec): Variante de codificación de
            Hamming usada, puede ser 74 ó 1511
        G (np.ndarray): Matriz generadora usada para codificar la lista
            de bits

    Returns:
        bloque_codificado (:obj: 'List' of :obj: 'int'): Lista de bits
            con los datos originales codificados según la matriz
            generadora

    """

    codec = HammingCodec.from_string(sistema_codec)

    if codec == HammingCodec.VARIANTE_74:
        longitud_segmento = 4
    else:
        longitud_segmento = 11

    longitud_bloque = len(bloque)
    bloque_codificado = []

    for i in range(0, longitud_bloque, longitud_segmento):
        segmento = bloque[i:i + longitud_segmento]

        if len(segmento) < longitud_segmento:
            # Agregar ceros a la izquierda para completar 11 bits
            segmento = [0] * (longitud_segmento - len(segmento)) + segmento

        segmento_codificado = hamming_encode(segmento, G)
        bloque_codificado += segmento_codificado

    return bloque_codificado
