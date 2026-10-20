//Aca se pondran todos los object que le den una ayuda al estudiante al interactuar con ella
import estudiante.*
import wollok.game.*
import respuestas.*
import distracciones.*
class Cafe inherits ObjetoJuego(image = "cafe.png") {
  
  override method serChocadoPor(unEstudiante) {
    unEstudiante.recuperarConcentracion()
    game.removeVisual(self)
  }

}

class Apuntes inherits ObjetoJuego(image = "apuntes.png") {
  override  method serChocadoPor(unEstudiante) {
    unEstudiante.activarEscudo()
    game.removeVisual(self)
  }
}

class AyudaClaude inherits ObjetoJuego(image = "claude.png") {
  override method serChocadoPor(unEstudiante) {
    respuestaActual.completarLetraComodin() 
    game.removeVisual(self)
  }

}