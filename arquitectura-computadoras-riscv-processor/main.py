"""Archivo de ejemplo de uso del simulador creado

Este script hace uso de la clase creada para simular el comportamiento
de un procesador RISCV escalar

"""

from micro_architecture import RISCVPipeline as pp


def main():
    """Ejecución del simulador RISCV escalar

    Esta función es un ejemplo de uso de la clase RISCVpipeline donde se
    muestran las métricas obtenidas

    """

    file_path = "factorial.S"
    modo = "both"
    pipeline = pp(file_path, modo)
    pipeline.run()

    print("\n")
    print(pipeline.registers, "\n")
    print(pipeline.memories, "\n")
    print("-El modo utilizado es", modo)
    print("-Se ejecutaron: ", pipeline.inst_count-1, " instrucciones")
    print("-Ciclos de reloj ejecutados: ", pipeline.clock)
    print("-CPI = ", pipeline.clock/(pipeline.inst_count-1))


if __name__ == "__main__":
    main()
