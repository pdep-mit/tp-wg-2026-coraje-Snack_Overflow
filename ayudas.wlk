//Aca se pondran todos los object que le den una ayuda al estudiante al interactuar con ella
import wollok.game.*
import respuestas.*
import ObjetoJuego.*
class Ayuda inherits ObjetoJuego {
  override method serChocadoPor(unEstudiante) {
    self.aplicarEfecto(unEstudiante)
    game.removeVisual(self)
  }

  method aplicarEfecto(unEstudiante)
}

class Cafe inherits Ayuda(image = "cafe.png") {
  override method aplicarEfecto(unEstudiante) {
    unEstudiante.recuperarConcentracion()
  }
}

class Apuntes inherits Ayuda(image = "apuntes.png") {
  override method aplicarEfecto(unEstudiante) {
    unEstudiante.activarEscudo()
  }
}

class AyudaClaude inherits Ayuda(image = "claude.png") {
  override method aplicarEfecto(unEstudiante) {
    respuestaActual.completarLetraComodin()
  }
}