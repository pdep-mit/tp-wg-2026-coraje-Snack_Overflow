import carriles.*
import hud.*
import wollok.game.*


object estudiante {
  var carrilActual = carrilCentral
  var concentracion = 5
// 1. Agregamos un "seguro" para que el sonido no se repita 80 veces 
    // si chocás dos obstáculos al mismo tiempo.
    var yaDesaprobo = false
  method image() = "estudiante.png"

  method position() = game.at(carrilActual.posicionX(), 1)

  method moverIzquierda() {
    carrilActual = carrilActual.izquierda()
  }

  method moverDerecha() {
    carrilActual = carrilActual.derecha()
  }

  method perderConcentracion() {
    concentracion = concentracion - 1
    // 2. ¡EL MOMENTO DEL GAME OVER!
        if (concentracion == 0 and !yaDesaprobo) {
            yaDesaprobo = true // Activamos el seguro
            
            // Reproducimos el efecto de sonido
            game.sound("you-died-dark-souls.mp3").play()
 // 1. Agregamos el fondo oscuro primero (Capa inferior)
    game.addVisual(filtroOscuro)
    
    // 2. Agregamos el texto de DESAPROBASTE (Capa superior)
    game.addVisual(pantallaDesaprobado)
        }
  }

  method recuperarConcentracion(cantidad) {
    concentracion = concentracion + cantidad
  }

  method concentracion() = concentracion

  method estaDesconcentrado() = concentracion <= 0

  // Provisional hasta implementar la victoria en CP2.
  method gano() = false
}