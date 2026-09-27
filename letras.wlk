import respuestas.*
import wollok.game.*

class LetraFisica {
  var property position
  const property caracter
  // Cuando la generen, le pasarán la letra. Ej: new LetraFisica(caracter = "A", position = ...)
  
  // --- Visuales ---
  method image() = "letra_placeholder.png"
  
  // --- Interacciones (Polimorfismo CP1) ---
  method serChocadoPor(unEstudiante) {
    
    // TODO: Mandarle el mensaje 'agregarLetra(caracter)' al objeto 'respuestaActual'.
    // TODO: Remover esta letra del tablero usando 'game.remove(self)'.
  }
  
  // --- Movimiento (Temporal CP1) ---
  method bajar() {
    
    // TODO: Modificar la 'position' para que baje en el eje Y.
  }
}