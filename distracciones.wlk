import estudiante.*
import wollok.game.*

class ObjetoJuego {
  var property position
  const property image 

  method serChocadoPor(unEstudiante) {}

  method bajar() {
    position = position.down(1)
        if (position.y() < 0) {
      game.removeVisual(self)
    }
  }
  }

class Obstaculo inherits ObjetoJuego {
    var progresoCaida = 0

    method avanzar(ms, velocidad) {
    progresoCaida += ms * velocidad / 1000
    if (progresoCaida >= 1) {
      progresoCaida -= 1
      self.bajar()
    }
    }

override method serChocadoPor(unEstudiante) {
    unEstudiante.perderConcentracion()
    game.removeVisual(self)
  }
}