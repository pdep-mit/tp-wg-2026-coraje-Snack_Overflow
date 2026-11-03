import respuestas.*
import gameConfiguration.*
import wollok.game.*

class LetraFisica {
  var property position
  const property caracter

 // --- Visuales ---
  // Devuelve la imagen dinámica concatenando el caracter
  method image() = "letras/" + caracter + ".png"

  // --- Interacciones (Polimorfismo CP1) ---
  method serChocadoPor(unEstudiante) {
    // Le mandamos el mensaje a respuestaActual delegando la validación
    unEstudiante.recogerLetra(caracter, respuestaActual)
    gameConfig.finalizarTanda()

    // Removemos esta letra del tablero
    game.removeVisual(self)
  }

  // --- Movimiento (Temporal CP1) ---
  method bajar() {
    // Modificamos la position para que baje en el eje Y
    position = position.down(1)
    [self].filter({ e => e.position().y() < 0 }).forEach({ e => game.removeVisual(e) })
  }
}
