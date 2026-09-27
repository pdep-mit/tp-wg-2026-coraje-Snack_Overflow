//Aca se pondran todos los object que le den una ayuda al estudiante al interactuar con ella
import estudiante.*
import wollok.game.*

//A futuro puede que haya que crear mas ayudas pero estas estan bien por ahora
object cafe {
  var property position
  //hay que poner desde donde salgta cuando definamos el limite del mapa
  
  method image() = "cafe.png"
  
  // --- Interacciones (Polimorfismo CP1) ---
  method serChocadoPor(unEstudiante) {
    
    // TODO: Mandarle el mensaje 'recuperarConcentracion1)' al estudiante.
    // TODO: Remover esta ayuda del tablero usando 'game.remove(self)'.
  }
  
  // --- Movimiento (Temporal CP1) ---
  method bajar() {
    
    // TODO: Modificar la 'position' para que baje en el eje Y.
  }
}

object apuntes {
  var property position
  
  method image() = "apuntes.png"
  
  method serChocadoPor(unEstudiante) {
    
    // TODO: Mandarle un mensaje al estudiante para activar su escudo (ej: activarEscudo()).
    // TODO: Remover esta ayuda del tablero usando 'game.remove(self)'.
  }
  
  method bajar() {
    
    // TODO: Modificar la 'position' para que baje en el eje Y.
  }
}