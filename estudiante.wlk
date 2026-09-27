import carriles.*
import wollok.game.*

object estudiante {
  var carrilActual = carrilCentral
  var concentracion = 5
  //Funciona como si fuera la vida,en el juego tendra una imagen de foco de lux representando que se pierde una idea
  var palabra = ""
  
  // var tieneEscudo = false // (Descomentar en el CP2)
  // --- Visuales ---
  method image() = "estudiante.png"
  
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
  
  method agarrarLetra(letra) {
    
    // TODO: Avisarle al objeto 'respuestaActual' (que está en respuestas.wlk) que agregue esta letra.
  }
  
  // ---------------------------------------------------------
  // --- MÉTODOS PARA EL PRÓXIMO CHECKPOINT (CP2) O FUTURO ---
  // ---------------------------------------------------------
  //Para las ayudas que reciba el estudiante
  method recuperarConcentracion(cantidad) {
    
    // TODO: Sumarle la 'cantidad' recibida por parámetro a la variable 'concentracion'.
    // (Opcional si llegan: validar que no supere el máximo de 100).
  }
  
  method activarEscudo() {
    
    // TODO (CP2): Cambiar la variable booleana 'tieneEscudo' a true para que el próximo golpe no reste concentración.
  }
  
  // --- Consultas de Estado para asi mantener el encapsulamiento(Para el HUD y Fin del Juego) ---
  method concentracion() = concentracion
  
  method estaDesconcentrado() = false
  
  method gano() = false
}