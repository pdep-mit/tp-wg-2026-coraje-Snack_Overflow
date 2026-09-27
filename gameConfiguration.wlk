import estudiante.*
// import hud.* // (Asegurate de importar los archivos donde estén tus visuales y generadores)
import wollok.game.*

object gameConfig {
  method configurarTodo() {
    self.configurarTablero()
    self.agregarVisuales()
    self.configurarTeclas()
    self.configurarColisiones()
    // self.configurarEventosTemporales() // (Descomentar en el CP2)
  }
  
  method configurarTablero() {
    
    // TODO: Configurar el título del juego con game.title("...").
    // TODO: Configurar el alto y ancho del tablero usando game.height(...) y game.width(...).
    // TODO: Configurar la imagen de fondo con game.boardGround("fondo.png").
  }
  
  method agregarVisuales() {
    
    // TODO: Agregar al estudiante al tablero usando game.addVisual(estudiante).
    // TODO: Agregar los objetos fijos del HUD (preguntaVisual, palabraArmadaVisual, vidasVisual).
  }
  
  method configurarTeclas() {
    
    // TODO: Usar keyboard.left().onPressDo({ ... }) para mandarle moverIzquierda() al estudiante.
    // TODO: Usar keyboard.right().onPressDo({ ... }) para mandarle moverDerecha() al estudiante.
  }
  
  method configurarColisiones() {
    
    // TODO: Usar game.onCollideDo(estudiante, { elemento => ... }) 
    // Dentro del bloque, hacer que el 'elemento' reciba el mensaje serChocadoPor(estudiante).
    // ¡Esta línea es la que hace brillar a todo el polimorfismo del Checkpoint 1!
  }
  
  // ---------------------------------------------------------
  // --- MÉTODOS PARA EL PRÓXIMO CHECKPOINT (CP2) O FUTURO ---
  // ---------------------------------------------------------
  method configurarEventosTemporales() {
    
    // TODO (CP2): Crear un game.onTick(...) para que el generadorDeObstaculos cree nuevos obstáculos cada X milisegundos.
    // TODO (CP2): Crear un game.onTick(...) para que el generadorDeLetras genere las olas de opciones.
    // TODO (CP2): Si deciden manejar la caída globalmente, crear un game.onTick(...) que le diga bajar() a todos los objetos móviles.
  }
}