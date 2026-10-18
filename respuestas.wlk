// Valida respuestas y registra puntos; no administra las vidas del estudiante.
class Respuesta {
  var letrasEsperadas = []
  var letrasAcertadas = []
  var puntos = 0
  var puntosPorLetra = 100
  var respondida = false
  var premiada = false
  var mensaje = ""

  method configurarPuntosPorLetra(cantidad) { puntosPorLetra = cantidad.max(0) }
  method puntos() = puntos
  method mensaje() = mensaje
  method hayPregunta() = !letrasEsperadas.isEmpty()
  method estaCompleta() = self.hayPregunta() && letrasAcertadas.size() == letrasEsperadas.size()
  method estaRespondida() = respondida
  method fuePremiada() = premiada
  method palabraArmada() = letrasAcertadas.join("")
  method letrasFaltantes() = letrasEsperadas.drop(letrasAcertadas.size())

  // "" indica que no hay otra letra: nunca se consulta first() sobre [].
  method letraEsperada() = (self.letrasFaltantes() + [""]).first()
  method textoConGuiones() = (letrasAcertadas + self.letrasFaltantes().map({ letra => "_" })).join(" ")

  method setearRespuestaEsperada(listaDeLetras) {
    // map crea una copia: recoger letras no modifica el banco de preguntas.
    letrasEsperadas = listaDeLetras.map({ letra => letra.toUpperCase() })
    respondida = false
    premiada = false
    self.reiniciar()
  }

  // Reinicia las pistas conservando los puntos y sin reabrir una pregunta respondida.
  // Para una pregunta nueva se usa setearRespuestaEsperada(...).
  method reiniciar() {
    letrasAcertadas = []
    mensaje = ""
  }

  method aceptaLetra(letra) = self.hayPregunta() && !respondida && letra == self.letraEsperada()

  method agregarLetra(unaLetra) {
    const letra = unaLetra.toUpperCase()
    return [letraAceptada, letraIgnorada].find({ opcion => opcion.corresponde(self, letra) }).aplicar(self, letra)
  }

  // Mensaje interno de letraAceptada; la validación vive en agregarLetra.
  method registrarLetra(letra) {
    letrasAcertadas.add(letra)
    mensaje = "Letra correcta"
    [respuestaCompletadaPorLetras, respuestaEnProgreso].find({ resultado => resultado.corresponde(self) }).aplicar(self)
  }

  method esRespuestaCorrecta(texto) = self.hayPregunta() && texto.trim().toUpperCase() == letrasEsperadas.join("")

  method responder(texto) {
    return [intentoNoDisponible, intentoCorrecto, intentoIncorrecto].find({ opcion => opcion.corresponde(self, texto) }).aplicar(self)
  }

  method marcarRespondida() {
    letrasAcertadas = letrasEsperadas.copy()
    respondida = true
  }

  // Completar las pistas resuelve la pregunta, pero no otorga puntos.
  method registrarRespuestaPorLetras() {
    self.marcarRespondida()
    mensaje = "Respuesta correcta! Completada en carriles, sin puntos"
  }

  // Solo el acierto escrito premia; cuenta todas las letras, incluso las repetidas.
  method registrarRespuestaCorrecta() {
    const premio = puntosPorLetra * letrasEsperadas.size()
    self.marcarRespondida()
    puntos += premio
    premiada = true
    mensaje = "Respuesta correcta! +" + premio.toString() + " puntos"
  }

  method registrarRespuestaIncorrecta() {
    mensaje = "Respuesta incorrecta. Podes volver a intentar."
  }
}

object respuestaActual inherits Respuesta {}

// Cada resultado aplica su efecto; descartar una letra no toca progreso ni vidas.
object letraAceptada {
  method corresponde(respuesta, letra) = respuesta.aceptaLetra(letra)
  method aplicar(respuesta, letra) {
    respuesta.registrarLetra(letra)
    return true
  }
}

object letraIgnorada {
  method corresponde(respuesta, letra) = true
  method aplicar(respuesta, letra) = false
}

object respuestaCompletadaPorLetras {
  method corresponde(respuesta) = respuesta.estaCompleta() && !respuesta.estaRespondida()
  method aplicar(respuesta) { respuesta.registrarRespuestaPorLetras() }
}

object respuestaEnProgreso {
  method corresponde(respuesta) = true
  method aplicar(respuesta) {}
}

object intentoNoDisponible {
  method corresponde(respuesta, texto) = !respuesta.hayPregunta() || respuesta.estaRespondida()
  method aplicar(respuesta) = false
}

object intentoCorrecto {
  method corresponde(respuesta, texto) = respuesta.esRespuestaCorrecta(texto)
  method aplicar(respuesta) {
    respuesta.registrarRespuestaCorrecta()
    return true
  }
}

object intentoIncorrecto {
  method corresponde(respuesta, texto) = true
  method aplicar(respuesta) {
    respuesta.registrarRespuestaIncorrecta()
    return false
  }
}
