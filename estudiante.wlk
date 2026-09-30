import carriles.*
import wollok.game.*

object estudiante {
  var carrilActual = carrilCentral
  var concentracion = 5
  
  //Funciona como si fuera la vida,en el juego tendra una imagen de foco de luz representando que se pierde una idea
  // --- Visuales ---,hay que buscar alguo despues
  method image() = "estudiante.png"
  
  //Hay que definir en grupo el largo del juego para asignar una pos inicial
  method position() = game.at(carrilActual.posicionX(), 1)
  
  // --- Movimiento ---
  method moverIzquierda() {
    
    // TODO: Actualizar la variable 'carrilActual' pidiéndole al carril actual que devuelva el carril de su izquierda.
  }
  
  method moverDerecha() {
    
    // TODO: Actualizar la variable 'carrilActual' pidiéndole al carril actual que devuelva el carril de su derecha.
  }
  
  //Es util que esten identificados por si en el futuro hacemos una interaccion que funcione en un carril especifico
  // --- Interacciones (Polimorfismo CP1) ---
  method perderConcentracion() {
    
    // TODO: Restarle 1 a la variable 'concentracion'.
    // (Opcional si llegan: validar que la concentración no baje de 0).
  }
  
  // ---------------------------------------------------------
  // --- MÉTODOS PARA EL PRÓXIMO CHECKPOINT (CP2) O FUTURO ---
  // ---------------------------------------------------------
  //Para las ayudas que reciba el estudiante
  method recuperarConcentracion() {
    
    // TODO: Sumarle la 'cantidad' recibida por parámetro a la variable 'concentracion'.
    // (Opcional si llegan: validar que no supere el máximo de 100).
  }
  
  // --- Consultas de Estado para asi mantener el encapsulamiento(Para el HUD y Fin del Juego) ---
  //Es mas limpio hacer esto y no hacer el property para no modificarlo por error
  method concentracion() = concentracion
  
  method estaDesconcentrado() {
    
    //     // TODO (CP2): return concentracion <= 0
    //     return false
  }
  
  method gano() {
    
    //     // TODO (CP2): lógica de victoria
    //     return false
  }
}