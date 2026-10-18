import carriles.*
import wollok.game.*

object estudiante {
  var carrilActual = carrilCentral
  var concentracion = 5

  method image() = "player.png"

  method position() = game.at(carrilActual.posicionX(), 1)

  method moverIzquierda() {
    carrilActual = carrilActual.izquierda()
  }

  method moverDerecha() {
    carrilActual = carrilActual.derecha()
  }

  method perderConcentracion() {
    concentracion = concentracion - 1
  }

  method recuperarConcentracion(cantidad) {
    concentracion = concentracion + cantidad
  }

  method concentracion() = concentracion

  method estaDesconcentrado() = concentracion <= 0

  // Provisional hasta implementar la victoria en CP2.
  method gano() = false
}
