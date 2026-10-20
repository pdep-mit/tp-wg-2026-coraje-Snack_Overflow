import carriles.*
import wollok.game.*

// Estado compartido; cada instancia representa una partida nueva.
class Personajes {
  var carrilActual = carrilCentral
  var concentracion = 5
  const velocidadObstaculos = 2.5 // celdas por segundo, antes de la dificultad
  var habilidadUsada = false
  var proteccion = vulnerable
  var eleccion = eleccionNormal

  method nombre() = "Promedio"
  method nombreHabilidad() = "Sin habilidad"
  method image() = "estudiante.png"
  method position() = game.at(carrilActual.posicionX(), 1)
  method moverIzquierda() { carrilActual = carrilActual.izquierda() }
  method moverDerecha() { carrilActual = carrilActual.derecha() }
  method concentracion() = concentracion
  method velocidadObstaculos() = velocidadObstaculos
  method danioPorDistraccion() = 1
  method perderConcentracion() { proteccion.recibirGolpe(self) }
  method recibirDanio() { concentracion = (concentracion - self.danioPorDistraccion()).max(0) }
  method recuperarConcentracion() { self.recuperarConcentracion(1) }
  method recuperarConcentracion(cantidad) { concentracion += cantidad }
  method estaDesconcentrado() = concentracion <= 0
  method gano() = false
  method habilidadUsada() = habilidadUsada
  method activarHabilidad() {
    [self].filter({ personaje => !personaje.habilidadUsada() }).forEach({ personaje =>
      habilidadUsada = true
      personaje.aplicarHabilidad()
    })
  }
  method aplicarHabilidad() {}
  method activarEscudo() { proteccion = new Escudo() }
  method desactivarEscudo() { proteccion = vulnerable }
  method tieneEscudo() = proteccion.activa()
  method avanzarTiempo(milisegundos) { proteccion.avanzar(milisegundos, self) }
  method activarSuerte() { eleccion = eleccionConSuerte }
  method consumirSuerte() { eleccion = eleccionNormal }
  method tieneSuerte() = eleccion.activa()
  method letraElegida(letra, respuesta) = eleccion.elegir(letra, respuesta, self)
  method estadoHabilidad() = self.nombreHabilidad() + " | " +
    [estadoEscudo, estadoSuerte, estadoUsada, estadoDisponible].find({ estado => estado.corresponde(self) }).texto()
}

class Promedio inherits Personajes {
  override method activarHabilidad() {}
  override method estadoHabilidad() = "Promedio | Sin habilidad"
}

class Violento inherits Personajes(velocidadObstaculos = 3.33) {
  override method nombre() = "Violento"
  override method nombreHabilidad() = "Suerte"
  override method danioPorDistraccion() = 2
  override method aplicarHabilidad() { self.activarSuerte() }
}

class Brillante inherits Personajes(velocidadObstaculos = 1.67) {
  override method nombre() = "Brillante"
  override method nombreHabilidad() = "Enfoque"
  override method aplicarHabilidad() { self.activarEscudo() }
}

object vulnerable {
  method activa() = false
  method recibirGolpe(personaje) { personaje.recibirDanio() }
  method avanzar(milisegundos, personaje) {}
}

class Escudo {
  var restante = 5000
  method activa() = true
  method recibirGolpe(personaje) {}
  method avanzar(milisegundos, personaje) {
    restante -= milisegundos
    [personaje].filter({ p => restante <= 0 }).forEach({ p => p.desactivarEscudo() })
  }
}

object eleccionNormal {
  method activa() = false
  method elegir(letra, respuesta, personaje) = letra
}

object eleccionConSuerte {
  method activa() = true
  method elegir(letra, respuesta, personaje) {
    personaje.consumirSuerte()
    return respuesta.letraEsperada()
  }
}

object estadoEscudo {
  method corresponde(p) = p.tieneEscudo()
  method texto() = "Escudo activo"
}
object estadoSuerte {
  method corresponde(p) = p.tieneSuerte()
  method texto() = "Proxima letra asegurada"
}
object estadoUsada {
  method corresponde(p) = p.habilidadUsada()
  method texto() = "Ya utilizada"
}
object estadoDisponible {
  method corresponde(p) = true
  method texto() = "F: usar (una vez)"
}

class Dificultad {
  const nombre
  const factor
  method nombre() = nombre
  method factor() = factor
  method intervaloGeneracion() = (8..15).anyOne()* 100 * factor
  method intervaloGeneracionAyuda() = (10..15).anyOne() * 1000 * factor 
  //Necesaria la multiplicacion *100/1000 debido a que relentiza debido al uso de RAM en caso contrario
}
object facil inherits Dificultad(nombre = "Facil", factor = 1.5) {}
object normal inherits Dificultad(nombre = "Normal", factor = 1) {}
object dificil inherits Dificultad(nombre = "Dificil", factor = 0.75) {}
