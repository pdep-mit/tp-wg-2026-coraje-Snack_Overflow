import respuestas.*
import wollok.game.*

class LetraFisica {
  var property position
  const property caracter
  
 // --- Visuales ---
  // Devuelve la imagen dinámica concatenando el caracter
  method image() = caracter + ".png"
  
  // --- Interacciones (Polimorfismo CP1) ---
  method serChocadoPor(unEstudiante) {
    // Le mandamos el mensaje a respuestaActual delegando la validación
    respuestaActual.agregarLetra(caracter)
    
    // Removemos esta letra del tablero
    game.removeVisual(self) 
  }
  
  // --- Movimiento (Temporal CP1) ---
  method bajar() {
    // Modificamos la position para que baje en el eje Y
    position = position.down(1)
    
    // Si salió de la pantalla (Y menor a 0), removemos el objeto
    if (position.y() < 0) {
      game.removeVisual(self)
    }
  }
}
