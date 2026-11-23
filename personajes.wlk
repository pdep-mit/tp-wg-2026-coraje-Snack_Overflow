import carriles.*
import wollok.game.*
import gameConfiguration.*

class Personajes {
  var carrilActual = carrilCentral
  var concentracion = 5
  var proteccion = vulnerable
  const velocidadObstaculos

  method nombre()
  method danioPorDistraccion()
  method usarHabilidad()

  method image() = "estudiante.png"
  method position() = game.at(carrilActual.posicionX(), 1)
  method moverIzquierda() { carrilActual = carrilActual.izquierda() }
  method moverDerecha() { carrilActual = carrilActual.derecha() }
  method concentracion() = concentracion
  method velocidadObstaculos() = velocidadObstaculos
  method estaDesconcentrado() = concentracion <= 0
  method perderConcentracion() { proteccion.recibirGolpe(self) }
  method recibirDanio() { concentracion = (concentracion - self.danioPorDistraccion()).max(0) musicaFondo.actualizarSegunVidas(concentracion)}
  method recuperarConcentracion() { self.recuperarConcentracion(1) }
  method recuperarConcentracion(cantidad) { concentracion += cantidad musicaFondo.actualizarSegunVidas(concentracion)}
  method recogerLetra(letra, respuesta) { respuesta.agregarLetra(letra) }

  // Apuntes puede proteger a cualquier personaje, independientemente de su habilidad.
  method activarEscudo() { proteccion = new Escudo() }
  method desactivarEscudo() { proteccion = vulnerable }
  method tieneEscudo() = proteccion.activa()
  method avanzarTiempo(ms) { proteccion.avanzar(ms, self) }
}

class Promedio inherits Personajes(velocidadObstaculos = 2.5) {
  override method nombre() = "Promedio"
  override method danioPorDistraccion() = 1
  override method usarHabilidad() {}
  method estadoHabilidad() = "Ninguna"
}

class Violento inherits Personajes(velocidadObstaculos = 3.33) {
  var habilidadUsada = false
  var eleccion = eleccionNormal

  override method nombre() = "Violento"
  override method danioPorDistraccion() = 2
  override method usarHabilidad() {
    [self].filter({ p => !p.habilidadUsada() }).forEach({ p =>
      habilidadUsada = true
      eleccion = eleccionConSuerte
    })
  }
  override method recogerLetra(letra, respuesta) {
    respuesta.agregarLetra(self.letraElegida(letra, respuesta))
  }
  method habilidadUsada() = habilidadUsada
  method tieneSuerte() = eleccion.activa()
  method consumirSuerte() { eleccion = eleccionNormal }
  method letraElegida(letra, respuesta) = eleccion.elegir(letra, respuesta, self)
  method estadoHabilidad() = "Suerte | " +
    [estadoEscudo, estadoSuerte, estadoUsada, estadoDisponible].find({ e => e.corresponde(self) }).texto()
}

class Brillante inherits Personajes(velocidadObstaculos = 1.67) {
  var habilidadUsada = false

  override method nombre() = "Brillante"
  override method danioPorDistraccion() = 1
  override method usarHabilidad() {
    [self].filter({ p => !p.habilidadUsada() }).forEach({ p =>
      habilidadUsada = true
      p.activarEscudo()
    })
  }
  method habilidadUsada() = habilidadUsada
  method estadoHabilidad() = "Enfoque | " +
    [estadoEscudo, estadoUsada, estadoDisponible].find({ e => e.corresponde(self) }).texto()
}

object vulnerable {
  method activa() = false
  method recibirGolpe(personaje) { personaje.recibirDanio() }
  method avanzar(ms, personaje) {}
}
class Escudo {
  var restante = 5000
  method activa() = true
  method recibirGolpe(personaje) {}
  method avanzar(ms, personaje) {
    restante -= ms
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
