import wollok.game.*
import ObjetoJuego.*

class Obstaculo inherits ObjetoJuego {
override method serChocadoPor(unEstudiante) {
  game.sound("ObstaculoChocado.mp3").play()
    unEstudiante.perderConcentracion()
    game.removeVisual(self)
  }
}
