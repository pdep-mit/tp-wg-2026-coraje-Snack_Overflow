import personajes.*
import hud.*
import wollok.game.*

// Conserva la identidad visual y las colisiones al cambiar de personaje.
object estudiante {
  var personaje = new Promedio()
  var dificultad = normal
  var yaDesaprobo = false

  method elegir(unPersonaje, unaDificultad) {
    personaje = unPersonaje
    dificultad = unaDificultad
    yaDesaprobo = false
  }
  method nombre() = personaje.nombre()
  method image() = personaje.image()
  method position() = personaje.position()
  method moverIzquierda() { personaje.moverIzquierda() }
  method moverDerecha() { personaje.moverDerecha() }
  method concentracion() = personaje.concentracion()
  method estaDesconcentrado() = personaje.estaDesconcentrado()
  method gano() = personaje.gano()
  method perderConcentracion() {
    personaje.perderConcentracion()
    [self].filter({ p => p.estaDesconcentrado() && !yaDesaprobo }).forEach({ p => p.perdiste() })
  }
  method recuperarConcentracion() { personaje.recuperarConcentracion() }
  method recuperarConcentracion(cantidad) { personaje.recuperarConcentracion(cantidad) }
  method activarEscudo() { personaje.activarEscudo() }
  method activarHabilidad() { personaje.activarHabilidad() }
  method avanzarTiempo(ms) { personaje.avanzarTiempo(ms) }
  method estadoHabilidad() = personaje.estadoHabilidad()
  method habilidadUsada() = personaje.habilidadUsada()
  method tieneEscudo() = personaje.tieneEscudo()
  method tieneSuerte() = personaje.tieneSuerte()
  method letraElegida(letra, respuesta) = personaje.letraElegida(letra, respuesta)
  method velocidadObstaculos() = personaje.velocidadObstaculos() * dificultad.factor()
  method intervaloGeneracion() = dificultad.intervaloGeneracion()
  method dificultad() = dificultad.nombre()

  method perdiste() {
    yaDesaprobo = true
    game.sound("you-died-dark-souls.mp3").play()
    game.addVisual(filtroOscuro)
    game.addVisual(pantallaDesaprobado)
  }
}
