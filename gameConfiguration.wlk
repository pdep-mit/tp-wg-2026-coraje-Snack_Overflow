import estudiante.*
import respuestas.*
import hud.*
import wollok.game.*

object ajustesDelJuego {
  method titulo() = "Snack Overflow - Examen a la carrera"
  // Los carriles existentes (3, 5 y 7) quedan centrados en este tablero.
  method ancho() = 11
  method alto() = 15
  method tamanioCelda() = 40
  method intervaloDeActualizacion() = 100
  method duracionRecorrido() = 30000
  method duracionZonaSegura() = 5000
  // Premio escrito: este valor multiplicado por la longitud de la respuesta.
  method puntosPorLetra() = 100
  method abecedario() = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".split("")
}

/* Integración pendiente en los archivos del equipo:
 * - juego.wpgm: cargar la pregunta con gameConfig.cargarPregunta(pregunta).
 *   Reemplazar los tres iniciar() independientes por conectarPista(unaPista).
 * - La pista entiende avanzar(ms), limpiarObstaculos(), mostrarOpciones(letras)
 *   y retirarOpciones(). Debe mover/generar únicamente desde avanzar(ms).
 *   mostrarOpciones recibe tres letras distintas, en orden izquierda/centro/derecha;
 *   durante esa tanda avanzar(ms) mueve letras, sin generar distracciones.
 * - letras.wlk: delegar a gameConfig.recogerLetra(caracter), para que solo se
 *   acepte una elección por tanda. Las colisiones siguen siendo polimórficas.
 * - hud.wlk: preguntaVisual.text() = gameConfig.preguntaActual();
 *   palabraArmadaVisual.text() = respuestaActual.textoConGuiones().
 * - estudiante.wlk: implementar movimiento y perderConcentracion().
 * - Assets faltantes: estudiante.png y las imágenes del HUD/elementos.
 *   El fondo predeterminado se conserva hasta que exista el fondo del equipo.
 * No iniciar generadores autónomos: sus schedules no se pausan con esta sesión.
 */
object gameConfig {
  const sesion = new SesionDeJuego()

  method configurarTodo() {
    self.configurarTablero()
    respuestaActual.configurarPuntosPorLetra(ajustesDelJuego.puntosPorLetra())
    self.agregarVisuales()
    self.configurarTeclas()
    self.configurarColisiones()
    self.configurarEventosTemporales()
  }

  method configurarTablero() {
    game.title(ajustesDelJuego.titulo())
    game.width(ajustesDelJuego.ancho())
    game.height(ajustesDelJuego.alto())
    game.cellSize(ajustesDelJuego.tamanioCelda())
  }

  method agregarVisuales() {
    [estudiante, preguntaVisual, palabraArmadaVisual, vidasVisual, panelDeRespuesta, resultadoVisual, puntajeVisual].forEach({ visual => game.addVisual(visual) })
  }

  method configurarTeclas() {
    keyboard.left().onPressDo({ sesion.moverIzquierda() })
    keyboard.right().onPressDo({ sesion.moverDerecha() })
    keyboard.enter().onPressDo({ sesion.presionarEnter() })
    keyboard.backspace().onPressDo({ sesion.borrar() })
    // assets/juego.html transmite Escape también en Wollok Game 2.1.1,
    // cuyo cliente predeterminado descarta el código de esta tecla.
    new Key(keyCodes = ["Escape"]).onPressDo({ sesion.cancelar() })
    ajustesDelJuego.abecedario().forEach({ letra =>
      keyboard.letter(letra).onPressDo({ sesion.escribir(letra) })
    })
  }

  method configurarColisiones() {
    game.onCollideDo(estudiante, { elemento => sesion.colisionarCon(elemento) })
  }

  method configurarEventosTemporales() {
    // Un único reloj: escritura y fin no avanzan la pista.
    game.onTick(ajustesDelJuego.intervaloDeActualizacion(), "actualizarExamen", { sesion.avanzar() })
  }

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
  const jugador = estudiante
  const ajustes = ajustesDelJuego
  var pista = pistaSinConectar
  var pistaConectada = false
  var modo = new ModoRecorrido()
  var modoSuspendido = modo
  var borrador = ""
  var preguntaActual = ""

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
  method nombre() = "detenido"
  method indicacion(sesion) = self.nombre()
  method corresponde(sesion, tiempo) = true
  method iniciar(sesion) {}
  method avanzar(sesion) {}
  method mover(sesion, accion) {}
  method confirmar(sesion) {}
  method escribir(sesion, letra) {}
  method borrar(sesion) {}
  method cancelar(sesion) {}
  method recogerLetra(sesion, letra) {}
  method colisionarCon(sesion, elemento, jugador) {}
}

class ModoCarriles inherits ModoDeJuego {
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
  override method indicacion(sesion) = "Flechas: carriles | Enter: responder"
  override method iniciar(sesion) {
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
  override method indicacion(sesion) = "Elegi una letra | Enter: responder"
  override method corresponde(sesion, tiempo) = tiempo >= sesion.tiempoDeRecorrido() && sesion.puedeOfrecerLetras()
  override method iniciar(sesion) {
    sesion.cambiarModo(self)
    sesion.mostrarZonaSegura()
  }
  override method recogerLetra(sesion, letra) { sesion.aceptarEleccion(letra) }
  override method avanzar(sesion) {
    sesion.avanzarPista()
    transcurrido += sesion.pasoDeTiempo()
    [new ModoSinVidas(), new ModoResuelto(), new FinDeZona(), continuarModo].find({ candidato => candidato.corresponde(sesion, transcurrido) }).iniciar(sesion)
  }
}

class FinDeZona inherits ModoDeJuego {
  override method corresponde(sesion, tiempo) = tiempo >= sesion.tiempoDeZona()
  override method iniciar(sesion) { new ModoRecorrido().iniciar(sesion) }
}

object continuarModo inherits ModoDeJuego {}

class ModoEscritura inherits ModoDeJuego {
  override method nombre() = "respondiendo"
  override method indicacion(sesion) = "Escribi: " + sesion.borrador() + " | Enter: confirmar | Esc: volver"
  override method escribir(sesion, letra) { sesion.agregarAlBorrador(letra) }
  override method borrar(sesion) { sesion.borrarDelBorrador() }
  override method cancelar(sesion) { sesion.volverALaPista() }
  override method confirmar(sesion) { sesion.confirmarRespuesta() }
}

class ModoResuelto inherits ModoDeJuego {
  override method nombre() = "pregunta resuelta"
  override method corresponde(sesion, tiempo) = sesion.resuelta()
  override method iniciar(sesion) {
    sesion.retirarOpciones()
    sesion.cambiarModo(self)
  }
}

class ModoSinVidas inherits ModoResuelto {
  override method nombre() = "sin vidas"
  override method corresponde(sesion, tiempo) = sesion.sinVidas()
}

// Adaptador vacío hasta que el equipo conecte generadores y movimiento.
object pistaSinConectar {
  method avanzar(milisegundos) {}
  method limpiarObstaculos() {}
  method mostrarOpciones(letras) {}
  method retirarOpciones() {}
}

object panelDeRespuesta {
  method position() = game.at(ajustesDelJuego.ancho().div(2), 13)
  method text() = gameConfig.textoDelPanel()
}

object resultadoVisual {
  method position() = game.at(ajustesDelJuego.ancho().div(2), 12)
  method text() = respuestaActual.mensaje()
}

object puntajeVisual {
  method position() = game.at(1, 0)
  method text() = "Puntos: " + respuestaActual.puntos().toString()
}
