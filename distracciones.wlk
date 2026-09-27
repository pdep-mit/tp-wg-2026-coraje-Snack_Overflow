//Todos los object que matan al estudiante en su camino de recordar una palabra,
//deben usar misma logica pero con distintas imagenes,tambien algunas seran mas largas que otras


/*
const carriles = [carrilIzquierdo, carrilCentral, carrilDerecho]

method spawnearDistraccion() {
    // 1. Elige un carril al azar
    const carrilElegido = carriles.anyOne()
    
    // 2. Crea la distracción pasándole el carril
    const nuevaDistraccion = new Celular(carril = carrilElegido, y = 10)
    
    // 3. Lo agrega al juego
    game.addVisual(nuevaDistraccion)
}
*/
import estudiante.*
import wollok.game.*

class Obstaculo {
    var property position
    const property image // Se configura al crear el objeto: new Obstaculo(image = "celular.png", position = ...)
   
    // --- Interacciones (Polimorfismo CP1) ---
    method serChocadoPor(unEstudiante) {
        // TODO: Mandarle el mensaje 'perderConcentracion()' al estudiante.
        // TODO: Remover este obstáculo del tablero usando 'game.remove(self)'.
    }
// --- Movimiento (Temporal CP1) ---
    method bajar() {
        // TODO: Modificar la 'position' para que baje en el eje Y. 
    }
}