//Aca se pondran todos los object que le den una ayuda al estudiante al interactuar con ella
import estudiante.*
import wollok.game.*


object cafe {
  var property position = game.at(0, 0) 
  
  method image() = "cafe.png"
  
  // --- Interacciones (Polimorfismo CP1) ---
  method serChocadoPor(unEstudiante) {
    unEstudiante.recuperarConcentracion()
    game.removeVisual(self)
  }
  
  // --- Movimiento (Temporal CP1) ---
  method bajar() {
    position = position.down(1)
    
    if (position.y() < 0) {
      game.removeVisual(self)
    }
  }
}

object apuntes {
  var property position = game.at(0, 0) // 
  
  method image() = "apuntes.png"
  
  method serChocadoPor(unEstudiante) {
    unEstudiante.activarEscudo()
    game.removeVisual(self)
  }
  
  method bajar() {
    position = position.down(1)
    
    if (position.y() < 0) {
      game.removeVisual(self)
    }
  }
}