import wollok.game.*
import ObjetoJuego.*

class Obstaculo inherits ObjetoJuego {
override method serChocadoPor(unEstudiante) {
    unEstudiante.perderConcentracion()
    game.removeVisual(self)
  }
}
