import estudiante.*
import wollok.game.*

class Obstaculo {
    var property position
    const property image // Se configura al crear el objeto: new Obstaculo(image = "celular.png", position = ...)
   
// --- Interacciones (Polimorfismo CP1) ---
    method serChocadoPor(unEstudiante) {
        unEstudiante.perderConcentracion()
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