import gameConfiguration.*
import estudiante.*
import personajes.*
import respuestas.*
import todasLasPreguntas.*
import wollok.game.*

class OpcionPersonaje {
  const nombre
  const descripcion
  const habilidad
  const constructor
  method nombre() = nombre
  method descripcion() = descripcion
  method habilidad() = habilidad
  method crear() = constructor.apply()
}

object menuPrincipal {
  const personajes = [
    new OpcionPersonaje(nombre = "Promedio", descripcion = "1 corazon por golpe.", habilidad = "Sin habilidad especial", constructor = { new Promedio() }),
    new OpcionPersonaje(nombre = "Violento", descripcion = "2 corazones por golpe. Caida rapida.", habilidad = "F: Suerte - proxima letra correcta", constructor = { new Violento() }),
    new OpcionPersonaje(nombre = "Brillante", descripcion = "1 corazon por golpe. Caida lenta.", habilidad = "F: Enfoque - escudo de 5 segundos", constructor = { new Brillante() })
  ]
  const dificultades = [facil, normal, dificil]
  var indicePersonaje = 0
  var indiceDificultad = 1
  var pantalla = new PantallaPartida()
  const visuales = []

  method nombrePantalla() = pantalla.nombre()
  method personajeElegido() = personajes.get(indicePersonaje).nombre()
  method dificultadElegida() = dificultades.get(indiceDificultad).nombre()
  method izquierda() { pantalla.izquierda() }
  method derecha() { pantalla.derecha() }
  method arriba() { pantalla.arriba() }
  method abajo() { pantalla.abajo() }
  method confirmar() { pantalla.confirmar() }
  method cancelar() { pantalla.cancelar() }
  method borrar() { pantalla.borrar() }
  method letra(letra) { pantalla.letra(letra) }
  method avanzar() { pantalla.avanzar() }
  method colisionar(elemento) { pantalla.colisionar(elemento) }

  method cambiarPersonaje(delta) {
    indicePersonaje = (indicePersonaje + delta + personajes.size()) % personajes.size()
    self.mostrar()
  }
  method cambiarDificultad(delta) {
    indiceDificultad = (indiceDificultad + delta + dificultades.size()) % dificultades.size()
    self.mostrar()
  }
  method limpiar() {
    visuales.forEach({ visual => game.removeVisual(visual) })
    visuales.clear()
  }
  method dibujar(lineas) {
    self.limpiar()
    var altura = 14
    lineas.forEach({ linea =>
      const visual = new TextoMenu(contenido = linea, altura = altura)
      visuales.add(visual)
      game.addVisual(visual)
      altura -= 1
    })
  }
  method mostrar() {
    gameConfig.quitarVisuales()
    pistaDelJuego.reiniciar()
    pantalla = new PantallaMenu()
    self.dibujar([
      "SNACK OVERFLOW", "Examen a la carrera", "",
      "Personaje: < " + self.personajeElegido() + " >",
      personajes.get(indicePersonaje).descripcion(),
      personajes.get(indicePersonaje).habilidad(),
      "Habilidades: un uso por partida",
      "Dificultad: < " + self.dificultadElegida() + " >",
      "",
      "Izquierda / Derecha: elegir personaje",
      "Arriba / Abajo: elegir dificultad",
      "Enter: jugar | H: instrucciones"
    ])
  }
  method mostrarAyuda() {
    pantalla = new PantallaAyuda()
    self.dibujar([
      "COMO JUGAR", "Esquiva distracciones y responde la pregunta.",
      "Cada 30 s hay una zona sin obstaculos.",
      "Recoge en orden las letras de la respuesta.",
      "Completarla en carriles no da puntos.",
      "Escribirla bien da 100 puntos por letra.",
      "Equivocarte al responder no quita vidas.",
      "Flechas: moverse | Enter: escribir / enviar",
      "A-Z: escribir | Backspace: borrar | Esc: volver",
      "F: habilidad, UNA vez por partida",
      "Violento: Suerte asegura la proxima letra.",
      "Brillante: Enfoque protege durante 5 s.",
      "Promedio: sin habilidad. M: menu al terminar.",
      "Esc o Enter: volver al menu"
    ])
  }
  method iniciarPartida() {
    self.limpiar()
    estudiante.elegir(personajes.get(indicePersonaje).crear(), dificultades.get(indiceDificultad))
    respuestaActual.reiniciarPartida()
    pistaDelJuego.reiniciar()
    gameConfig.agregarVisuales()
    gameConfig.conectarPista(pistaDelJuego)
    gameConfig.cargarPregunta(bancoDePreguntas.preguntaAleatoria())
    pantalla = new PantallaPartida()
  }
}

class TextoMenu {
  const contenido
  const altura
  method position() = game.at(ajustesDelJuego.ancho().div(2), altura)
  method text() = contenido
  method textColor() = "FFFFFF"
}
class Pantalla {
  method nombre() = "pantalla"
  method izquierda() {}
  method derecha() {}
  method arriba() {}
  method abajo() {}
  method confirmar() {}
  method cancelar() {}
  method borrar() {}
  method letra(letra) {}
  method avanzar() {}
  method colisionar(elemento) {}
}
class PantallaMenu inherits Pantalla {
  override method nombre() = "menu"
  override method izquierda() { menuPrincipal.cambiarPersonaje(-1) }
  override method derecha() { menuPrincipal.cambiarPersonaje(1) }
  override method arriba() { menuPrincipal.cambiarDificultad(-1) }
  override method abajo() { menuPrincipal.cambiarDificultad(1) }
  override method confirmar() { menuPrincipal.iniciarPartida() }
  override method letra(letra) {
    [menuPrincipal].filter({ menu => letra == "H" }).forEach({ menu => menu.mostrarAyuda() })
  }
}
class PantallaAyuda inherits Pantalla {
  override method nombre() = "ayuda"
  override method confirmar() { menuPrincipal.mostrar() }
  override method cancelar() { menuPrincipal.mostrar() }
}
class PantallaPartida inherits Pantalla {
  override method nombre() = "partida"
  override method izquierda() { gameConfig.moverIzquierda() }
  override method derecha() { gameConfig.moverDerecha() }
  override method confirmar() { gameConfig.presionarEnter() }
  override method cancelar() { gameConfig.cancelar() }
  override method borrar() { gameConfig.borrar() }
  override method letra(letra) { gameConfig.escribir(letra) }
  override method avanzar() { gameConfig.avanzar() }
  override method colisionar(elemento) { gameConfig.colisionarCon(elemento) }
}
