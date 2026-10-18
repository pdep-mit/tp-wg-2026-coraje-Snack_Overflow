import estudiante.*
import wollok.game.*

class Obstaculo {
    var progresoCaida = 0
    method avanzar(ms, velocidad) {
      progresoCaida += ms * velocidad / 1000
      [self].filter({ e => progresoCaida >= 1 }).forEach({ e =>
        progresoCaida -= 1
        e.bajar()
      })
    }
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
        [self].filter({ e => e.position().y() < 0 }).forEach({ e => game.removeVisual(e) })
    }
}
