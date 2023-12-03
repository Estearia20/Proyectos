class Estado:
    def __init__(self, nombre):
        self.nombre = nombre
        self.transiciones = {}

    def agregar_transicion(self, evento, proximo_estado):
        self.transiciones[evento] = proximo_estado

    def obtener_proximo_estado(self, evento):
        return self.transiciones.get(evento)


class MaquinaEstados:
    def __init__(self):

        # Crear los estados
        estado_inicial = Estado("strongly !taken")
        estado_intermedio1 = Estado("weakly !taken")
        estado_intermedio2 = Estado("weakly taken")
        estado_final = Estado("strongly taken")

        self.estado_actual = estado_inicial

        # Definir las transiciones entre estados
        estado_inicial.agregar_transicion("!taken", estado_inicial)
        estado_inicial.agregar_transicion("taken", estado_intermedio1)

        estado_intermedio1.agregar_transicion("!taken", estado_inicial)
        estado_intermedio1.agregar_transicion("taken", estado_intermedio2)

        estado_intermedio2.agregar_transicion("!taken", estado_intermedio1)
        estado_intermedio2.agregar_transicion("taken", estado_final)

        estado_final.agregar_transicion("!taken", estado_intermedio2)
        estado_final.agregar_transicion("taken", estado_final)

    def procesar_evento(self, evento):
        proximo_estado = self.estado_actual.obtener_proximo_estado(evento)
        if proximo_estado:
            self.estado_actual = proximo_estado

    def obtener_estado_actual(self):
        if self.estado_actual.nombre in ["wakly taken", "strongly taken"]:
            return "taken"

        return "!taken"
