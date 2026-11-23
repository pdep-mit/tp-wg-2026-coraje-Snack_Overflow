import wollok.game.*
import azar.*

class ObjetoJuego {
  const property image
  var property position = game.at(azar.carrilAleatorio().posicionX(), 10)
  var progresoCaida = 0

  method avanzar(ms, velocidad) {
    progresoCaida += ms * velocidad / 1000

    if (progresoCaida >= 1) {
      progresoCaida -= 1
      self.bajar()
    }
  }

  method serChocadoPor(unEstudiante)

  method bajar() {
    position = position.down(1)

    if (position.y() < 0) {
      game.removeVisual(self)
    }
  }
}