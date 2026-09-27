//Para poner cuando aparece un objeto arriba de la pantalla
//Para poner cuando aparece un objeto arriba de la pantalla
import letras.*
import carriles.*
import respuestas.*
import wollok.game.*

object generadorDeLetras {
  //Puedes hacer estos primero de forma simple para solo probar que un personaje puede colisionar con una letra
  method generarOlaDeLetras() {
    
    // TODO (CP2): Obtener la letra correcta que toca ahora (preguntándole a respuestaActual).
    // TODO (CP2): Conseguir dos letras aleatorias incorrectas (pueden delegarlo en un objeto 'azar').
    // TODO (CP2): Instanciar tres objetos 'LetraFisica' (usando 'new LetraFisica(...)').
    // TODO (CP2): Asignarle a cada instancia un carril distinto (carrilIzquierdo, carrilCentral, carrilDerecho) pero la misma coordenada Y inicial (ej: y = 10, que sería la parte superior de la zona segura).
    // TODO (CP2): Agregar las tres letras al tablero usando 'game.addVisual()'.
  }
}

object generadorDeObstaculos {
  // ---------------------------------------------------------
  // --- MÉTODOS PARA EL PRÓXIMO CHECKPOINT (CP2) O FUTURO ---
  // ---------------------------------------------------------
  method generar() {
    
    // TODO (CP2): Elegir un carril al azar (ej: de una lista [carrilIzquierdo, carrilCentral, carrilDerecho]).
    // TODO (CP2): Elegir un nombre de imagen al azar (ej: "celular.png" o "nube_pensamiento.png").
    // TODO (CP2): Crear la instancia usando 'new Obstaculo(image = imagenElegida, position = game.at(carril.posicionX(), 10))'.
    // TODO (CP2): Agregar el obstáculo al tablero con 'game.addVisual()'.
  }
}

object generadorDeAyudas {
  // ---------------------------------------------------------
  // --- MÉTODOS PARA EL PRÓXIMO CHECKPOINT (CP2) O FUTURO ---
  // ---------------------------------------------------------
  method generarCafe() {
    
    // TODO (CP2): Elegir un carril al azar.
    // TODO (CP2): Cambiarle la 'position' al objeto 'cafe' para que aparezca arriba de todo en ese carril.
    // TODO (CP2): Preguntar si ya está en pantalla con 'game.hasVisual(cafe)'. Si no está, agregarlo con 'game.addVisual(cafe)'.
  }
  
  method generarApuntes() {
    
    // TODO (CP2): Hacer exactamente la misma lógica que con el café, pero para el objeto 'apuntes'.
  }
}