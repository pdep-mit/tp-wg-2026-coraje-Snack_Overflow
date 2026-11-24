import personajes.*
import menu.*
import letras.*
import carriles.*
import respuestas.*
import hud.*
import generadores.*
import wollok.game.*

object ajustesDelJuego {
  method titulo() = "Snack Overflow - Examen a la carrera"
  // Los carriles existentes (3, 5 y 7) quedan centrados en este tablero.
  method ancho() = 12
  method alto() = 16
  method tamanioCelda() = 40
  method intervaloDeActualizacion() = 200
  method duracionRecorrido() = 30000
  method duracionZonaSegura() = 5000
  // Premio escrito: este valor multiplicado por la longitud de la respuesta.
  method puntosPorLetra() = 100
  method abecedario() = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".split("")

}

object gameConfig {
  const sesion = new SesionDeJuego()
  var dificultad = normal

  method jugador() = sesion.jugador()
  method dificultad() = dificultad.nombre()
  method sesion() = sesion
  method velocidadObstaculos() = self.jugador().velocidadObstaculos() / dificultad.factor()
  method intervaloGeneracion() = dificultad.intervaloGeneracion()
  method intervaloGeneracionAyuda() = dificultad.intervaloGeneracionAyuda()
  method elegirPersonaje(personaje, unaDificultad) {
    self.quitarVisuales()
    io.removeCollitionHandler(self.jugador().identity())
    sesion.elegirPersonaje(personaje)
    dificultad = unaDificultad
    self.configurarColisiones()
  }

  method configurarTodo() {
    self.configurarTablero()
    respuestaActual.configurarPuntosPorLetra(ajustesDelJuego.puntosPorLetra())
    self.agregarVisuales()
    self.configurarTeclas()
    self.configurarColisiones()
    self.configurarEventosTemporales()
    musicaFondo.iniciarPartida()
  }

  method configurarTablero() {
    game.title(ajustesDelJuego.titulo())
    game.width(ajustesDelJuego.ancho())
    game.height(ajustesDelJuego.alto())
    game.cellSize(ajustesDelJuego.tamanioCelda())
    game.boardGround("fondo_mental.png")
  }

method agregarVisuales() {
  [
    self.jugador(),
    preguntaVisual,
    palabraArmadaVisual,
    vidasVisual,
    habilidadVisual,
    imagenPersonajeVisual,
    rolPersonajeVisual,
    nombrePersonajeVisual,
    panelDeRespuesta,
    resultadoVisual,
    puntajeVisual
  ].forEach({ visual => game.addVisual(visual) })
}

method configurarTeclas() {
  keyboard.left().onPressDo({ menuPrincipal.izquierda() })
  keyboard.right().onPressDo({ menuPrincipal.derecha() })
  keyboard.up().onPressDo({ menuPrincipal.arriba() })
  keyboard.down().onPressDo({ menuPrincipal.abajo() })
    keyboard.enter().onPressDo({ menuPrincipal.confirmar() })
    keyboard.backspace().onPressDo({ menuPrincipal.borrar() })
    // assets/juego.html transmite Escape también en Wollok Game 2.1.1,
    // cuyo cliente predeterminado descarta el código de esta tecla.
    new Key(keyCodes = ["Escape"]).onPressDo({ menuPrincipal.cancelar() })

    ajustesDelJuego.abecedario().forEach({ letra =>
      keyboard.letter(letra).onPressDo({ menuPrincipal.letra(letra) })
    })

    // Botón de reinicio para la partida / modo infinito
 //   keyboard.r().onPressDo({ menuPrincipal.reiniciarJuego() })
  }

  method configurarColisiones() {
    game.onCollideDo(self.jugador(), { elemento => menuPrincipal.colisionar(elemento) })
  }

  method configurarEventosTemporales() {
    // Un único reloj: escritura y fin no avanzan la pista.
    game.onTick(ajustesDelJuego.intervaloDeActualizacion(), "actualizarExamen", { menuPrincipal.avanzar() })
  }

method quitarVisuales() {
  [
    self.jugador(),
    preguntaVisual,
    palabraArmadaVisual,
    vidasVisual,
    habilidadVisual,
    imagenPersonajeVisual,
    rolPersonajeVisual,
    nombrePersonajeVisual,
    panelDeRespuesta,
    resultadoVisual,
    puntajeVisual,
    filtroOscuro,
    pantallaDesaprobado
  ]
  .filter({ visual => game.hasVisual(visual) })
  .forEach({ visual => game.removeVisual(visual) })
}

  method moverIzquierda() { sesion.moverIzquierda() }
  method moverDerecha() { sesion.moverDerecha() }
  method presionarEnter() { sesion.presionarEnter() }
  method cancelar() { sesion.cancelar() }
  method borrar() { sesion.borrar() }
  method escribir(letra) { sesion.escribir(letra) }
  method avanzar() { sesion.avanzar() }
  method colisionarCon(elemento) { sesion.colisionarCon(elemento) }
  method finalizarTanda() { sesion.finalizarTanda() }
  method conectarPista(unaPista) { sesion.conectarPista(unaPista) }
  method cargarPregunta(pregunta) { sesion.cargarPregunta(pregunta) }
  method preguntaActual() = sesion.preguntaActual()
  method recogerLetra(letra) { sesion.recogerLetra(letra) }
  method estado() = sesion.estado()
  method textoDelPanel() = sesion.textoDelPanel()
}

// Se puede probar sin gráficos inyectando respuesta, jugador, pista y ajustes.
class SesionDeJuego {
  const respuesta = respuestaActual
  var jugador = new Promedio()
  const ajustes = ajustesDelJuego
  var pista = pistaSinConectar
  var pistaConectada = false
  var modo = new ModoRecorrido()
  var modoSuspendido = modo
  var borrador = ""
  var preguntaActual = ""

  method jugador() = jugador
  method elegirPersonaje(personaje) { jugador = personaje }
  method modoActual() = modo

  method conectarPista(unaPista) {
    pista = unaPista
    pistaConectada = true
  }
  method cargarPregunta(pregunta) {
    pista.limpiarObstaculos()
    pista.retirarOpciones()
    preguntaActual = pregunta.enunciado()
    respuesta.setearRespuestaEsperada(pregunta.letras())
    respuesta.configurarPuntosPorLetra(ajustes.puntosPorLetra())
    borrador = ""
    modo = new ModoRecorrido()
    modoSuspendido = modo
  }

  method preguntaActual() = preguntaActual
  method estado() = modo.nombre()
  method borrador() = borrador
  method textoDelPanel() = modo.indicacion(self)
  method sinVidas() = jugador.concentracion() <= 0
  method resuelta() = respuesta.estaRespondida()
  method puedeOfrecerLetras() = pistaConectada && respuesta.hayPregunta() && !respuesta.estaRespondida()
  method pasoDeTiempo() = ajustes.intervaloDeActualizacion()
  method tiempoDeRecorrido() = ajustes.duracionRecorrido()
  method tiempoDeZona() = ajustes.duracionZonaSegura()
  method cambiarModo(unModo) { modo = unModo }

  method avanzar() { modo.avanzar(self) }
  method moverIzquierda() { modo.mover(self, { jugador.moverIzquierda() }) }
  method moverDerecha() { modo.mover(self, { jugador.moverDerecha() }) }
  method presionarEnter() { modo.confirmar(self) }
  method escribir(letra) { modo.escribir(self, letra) }
  method borrar() { modo.borrar(self) }
  method cancelar() { modo.cancelar(self) }
  method recogerLetra(letra) { modo.recogerLetra(self, letra) }
  method colisionarCon(elemento) { modo.colisionarCon(self, elemento, jugador) }
  method finalizarTanda() { modo.finalizarTanda(self) }
  method usarHabilidad() { jugador.usarHabilidad() }

  method avanzarPista() { pista.avanzar(self.pasoDeTiempo()) }
  method retirarOpciones() { pista.retirarOpciones() }

  method mostrarZonaSegura() {
    pista.limpiarObstaculos()
    const correcta = respuesta.letraEsperada()
    const primeraFalsa = ajustes.abecedario().filter({ letra => letra != correcta }).anyOne()
    const segundaFalsa = ajustes.abecedario().filter({ letra => letra != correcta && letra != primeraFalsa }).anyOne()
    // Las seis permutaciones dan la misma probabilidad a cada carril.
    pista.mostrarOpciones([
      [correcta, primeraFalsa, segundaFalsa], [correcta, segundaFalsa, primeraFalsa],
      [primeraFalsa, correcta, segundaFalsa], [segundaFalsa, correcta, primeraFalsa],
      [primeraFalsa, segundaFalsa, correcta], [segundaFalsa, primeraFalsa, correcta]
    ].anyOne())
  }

  method aceptarEleccion(letra) {
    respuesta.agregarLetra(letra)
    // Acierto y error consumen la tanda; una letra incorrecta no resta vida.
    new ModoRecorrido().iniciar(self)
    self.revisarFin()
  }

  method abrirRespuesta() {
    modoSuspendido = modo
    borrador = ""
    modo = new ModoEscritura()
  }

  method agregarAlBorrador(letra) { borrador += letra.toUpperCase() }
  method borrarDelBorrador() { borrador = borrador.take((borrador.size() - 1).max(0)) }
  method volverALaPista() {
    borrador = ""
    modo = modoSuspendido
  }
  method confirmarRespuesta() {
    respuesta.responder(borrador)
    self.volverALaPista()
    self.revisarFin()
  }

  method revisarFin() {
    [new ModoSinVidas(), new ModoResuelto(), continuarModo].find({ candidato => candidato.corresponde(self, 0) }).iniciar(self)
  }
}

// Los modos deciden qué mensajes atender: no se pregunta el tipo del objeto chocado.
class ModoDeJuego {
  method nombre() 
  method indicacion(sesion) = self.nombre()
  method avanzar(sesion) {}
  method mover(sesion, accion) {}
  method confirmar(sesion) {}
  method escribir(sesion, letra) {}
  method borrar(sesion) {}
  method cancelar(sesion) {}
  method recogerLetra(sesion, letra) {}
  method colisionarCon(sesion, elemento, jugador) {}
  method finalizarTanda(sesion) {}
  method textColor() = "FFFFFFFF"
}

class ModoCarriles inherits ModoDeJuego {
  override method escribir(sesion, letra) {
    [sesion].filter({ s => letra == "F" }).forEach({ s => s.usarHabilidad() })
  }
  override method mover(sesion, accion) { accion.apply() }
  override method confirmar(sesion) { sesion.abrirRespuesta() }
  override method colisionarCon(sesion, elemento, jugador) {
    elemento.serChocadoPor(jugador)
    sesion.revisarFin()
  }
}

class ModoRecorrido inherits ModoCarriles {
  var transcurrido = 0
  override method nombre() = "recorrido"
  override method indicacion(sesion) =
  "Teclas:Flechas=moverse | Enter=pausar | F=Habilidad"

  method iniciar(sesion) {
    sesion.retirarOpciones()
    sesion.cambiarModo(self)
  }
  override method avanzar(sesion) {
    sesion.avanzarPista()
    transcurrido += sesion.pasoDeTiempo()
    [new ModoSinVidas(), new ModoResuelto(), new ModoZonaSegura(), continuarModo].find({ candidato => candidato.corresponde(sesion, transcurrido) }).iniciar(sesion)
  }
}

class ModoZonaSegura inherits ModoCarriles {
  var transcurrido = 0
  override method nombre() = "zona segura"
  override method indicacion(sesion) =
  "Flechas: elegir letra | Enter: escribir"

  method corresponde(sesion, tiempo) = tiempo >= sesion.tiempoDeRecorrido() && sesion.puedeOfrecerLetras()
  method iniciar(sesion) {
    sesion.cambiarModo(self)
    sesion.mostrarZonaSegura()
  }
  override method recogerLetra(sesion, letra) { sesion.aceptarEleccion(letra) }
  override method finalizarTanda(sesion) { new ModoRecorrido().iniciar(sesion) }
  override method avanzar(sesion) {
    sesion.avanzarPista()
    transcurrido += sesion.pasoDeTiempo()
    [new ModoSinVidas(), new ModoResuelto(), new FinDeZona(), continuarModo].find({ candidato => candidato.corresponde(sesion, transcurrido) }).iniciar(sesion)
  }
}

class FinDeZona {
  method corresponde(sesion, tiempo) = tiempo >= sesion.tiempoDeZona()
   method iniciar(sesion) { new ModoRecorrido().iniciar(sesion) }
}

object continuarModo {
  method corresponde(sesion, tiempo) = true
  method iniciar(sesion) {}
}

class ModoEscritura inherits ModoDeJuego {
  override method nombre() = "respondiendo"
  override method textColor() = "00FF00FF"
  override method indicacion(sesion) = "Texto: " + sesion.borrador() + " | Enter: enviar | Esc: volver"

  override method escribir(sesion, letra) { sesion.agregarAlBorrador(letra) }
  override method borrar(sesion) { sesion.borrarDelBorrador() }
  override method cancelar(sesion) { sesion.volverALaPista() }
  override method confirmar(sesion) { sesion.confirmarRespuesta() }
}

class ModoResuelto inherits ModoDeJuego {
  override method nombre() = "pregunta resuelta"
  override method indicacion(sesion) = "Victoria | Enter: menu principal"
  override method confirmar(sesion) { menuPrincipal.mostrar() }
  override method escribir(sesion, letra) {
    [menuPrincipal].filter({ menu => letra == "M" }).forEach({ menu => menu.mostrar() })
  }
  method corresponde(sesion, tiempo) = sesion.resuelta()
  method iniciar(sesion) {
    sesion.retirarOpciones()
    sesion.cambiarModo(self)
  }
}

class ModoSinVidas inherits ModoResuelto {
  override method iniciar(sesion) {
    super(sesion)
    musicaFondo.detener()
    game.sound("you-died-dark-souls.mp3").play() 
    game.addVisual(filtroOscuro)
    game.addVisual(pantallaDesaprobado)
  }
  override method nombre() = "sin vidas"
  override method indicacion(sesion) = "Game Over | Enter: menu principal"
  override method corresponde(sesion, tiempo) = sesion.sinVidas()
}

object pistaDelJuego {
  const obstaculos = []
  const opciones = []
  var tiempoParaProximoObstaculo = 1000
  var tiempoParaProximaAyuda =5000
  var zonaSegura = false

  method agregarObstaculo(elemento) {
    obstaculos.add(elemento)
    game.addVisual(elemento)
  }
  method reiniciar() {
    self.limpiarObstaculos()
    self.retirarOpciones()
    tiempoParaProximoObstaculo = 1000
  }
  method avanzar(milisegundos) {
    gameConfig.jugador().avanzarTiempo(milisegundos)
    obstaculos.copy().filter({ e => !game.hasVisual(e) }).forEach({ e => obstaculos.remove(e) })
    obstaculos.forEach({ e => e.avanzar(milisegundos, gameConfig.velocidadObstaculos()) })
    opciones.filter({ e => game.hasVisual(e) }).forEach({ e => e.bajar() })
    [self].filter({ pista => !zonaSegura }).forEach({ pista => pista.generarDurante(milisegundos) })
  }
  method generarDurante(milisegundos) {
// 1. Reloj de Obstáculos
    tiempoParaProximoObstaculo -= milisegundos
    if (tiempoParaProximoObstaculo <= 0) {
        generadorDeObstaculos.generar()
        // Asumiendo que el estudiante conoce la dificultad actual:
        tiempoParaProximoObstaculo = gameConfig.intervaloGeneracion()
    }

    // 2. Reloj de Ayudas 
    tiempoParaProximaAyuda -= milisegundos
    if (tiempoParaProximaAyuda <= 0) {
        generadorDeAyudas.generarAyuda()
        // Calculamos un nuevo tiempo aleatorio basado en la dificultad
        tiempoParaProximaAyuda = gameConfig.intervaloGeneracionAyuda()
    }
  }
  method limpiarObstaculos() {
    obstaculos.filter({ e => game.hasVisual(e) }).forEach({ e => game.removeVisual(e) })
    obstaculos.clear()
  }
  method mostrarOpciones(letras) {
    self.retirarOpciones()
    zonaSegura = true
    const carriles = [carrilIzquierdo, carrilCentral, carrilDerecho]
    (0..2).forEach({ indice =>
      const letra = new LetraFisica(caracter = letras.get(indice), position = game.at(carriles.get(indice).posicionX(), 10))
      opciones.add(letra)
      game.addVisual(letra)
    })
  }
  method retirarOpciones() {
    opciones.filter({ e => game.hasVisual(e) }).forEach({ e => game.removeVisual(e) })
    opciones.clear()
    zonaSegura = false
  }
}

object musicaFondo {
  const archivoNormal = "TemaInicial.mp3"
  const archivoUltimaVida = "1ps!.mp3" 

  var sonidoActual = null
  var ultimaVidaActiva = false

  method iniciarPartida() {
    self.detener()
    ultimaVidaActiva = false
    sonidoActual = self.crearYReproducir(archivoNormal, 0.25)
  }

  method actualizarSegunVidas(cantidadVidas) {
    try {
      const debeSonarUltimaVida = cantidadVidas == 1
      if (debeSonarUltimaVida != ultimaVidaActiva || sonidoActual == null) {
        ultimaVidaActiva = debeSonarUltimaVida
        self.detener()
        if (ultimaVidaActiva) {
          sonidoActual = self.crearYReproducir(archivoUltimaVida, 0.3)
        } else {
          sonidoActual = self.crearYReproducir(archivoNormal, 0.25)
        }
      }
    } catch e : Exception {
    }
  }

  method crearYReproducir(nombreArchivo, vol) {
    try {
      const nuevoSonido = game.sound(nombreArchivo)
      nuevoSonido.shouldLoop(true)
      nuevoSonido.volume(vol)
      nuevoSonido.play()
      return nuevoSonido
    } catch e : Exception {
      return null
    }
  }

  method detener() {
    try {
      if (sonidoActual != null) {
        sonidoActual.pause()
        sonidoActual = null
      }
    } catch e : Exception {
    }
  }
}

// Adaptador vacío hasta que el equipo conecte generadores y movimiento.
object pistaSinConectar {
  method avanzar(milisegundos) {}
  method limpiarObstaculos() {}
  method mostrarOpciones(letras) {}
  method retirarOpciones() {}
}

object panelDeRespuesta {
  method position() = game.at(5, 13)
  method text() = gameConfig.textoDelPanel()
  method textColor() = gameConfig.sesion().modoActual().textColor()
}

object resultadoVisual {
  method position() = game.at(2, 14)
  method text() = respuestaActual.mensaje()
}

object puntajeVisual {
  method position() = game.at(11, 0)
  method text() = "Puntos: " + respuestaActual.puntos().toString()
}
