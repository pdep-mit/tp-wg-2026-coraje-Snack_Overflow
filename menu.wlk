import gameConfiguration.*
import personajes.*
import respuestas.*
import todasLasPreguntas.*
import wollok.game.*
import hud.*

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
  method confirmar() { pantalla.confirmar() }
  method cancelar() { pantalla.cancelar() }
  method izquierda() { pantalla.flechas().izquierda() }
  method derecha() { pantalla.flechas().derecha() }
  method arriba() { pantalla.flechas().arriba() }
  method abajo() { pantalla.flechas().abajo() }
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
          const visual = new TextoMenu(
              contenido = linea.texto(),
              altura = altura,
              color = linea.color()
          )
          visuales.add(visual)
          game.addVisual(visual)
          altura -= 1
      })
  }
  method mostrar() {
    gameConfig.quitarVisuales()
    pistaDelJuego.reiniciar()
    pantalla = new PantallaMenu()
    game.addVisual(filtroOscuro)
self.dibujar([
          // Usamos la nueva clase. Al título le damos un color, al resto nada (queda blanco).
          new LineaMenu(texto = "SNACK OVERFLOW", color = "FF00A6FF"), // Rosa Danganronpa
          new LineaMenu(texto = "Examen a la carrera"),
          new LineaMenu(texto = ""),
          new LineaMenu(texto = "Personaje: < " + self.personajeElegido() + " >", color = "00FFFFFF"),
          new LineaMenu(texto = personajes.get(indicePersonaje).descripcion()),
          new LineaMenu(texto = personajes.get(indicePersonaje).habilidad()),
          new LineaMenu(texto = "Habilidades: un uso por partida", color = "FFFF00FF"), // Amarillo
          new LineaMenu(texto = "Dificultad: < " + self.dificultadElegida() + " >", color = "00FFFFFF"),
          new LineaMenu(texto = ""),
          new LineaMenu(texto = "Izquierda / Derecha: elegir personaje"),
          new LineaMenu(texto = "Arriba / Abajo: elegir dificultad"),
          new LineaMenu(texto = "Enter: jugar | H: instrucciones", color = "00FF00FF")
      ])
  }
method mostrarAyuda() {
    pantalla = new PantallaAyuda()
    self.dibujar([
          new LineaMenu(texto = "COMO JUGAR", color = "FF00A6FF"), // Rosa Danganronpa para el título
          new LineaMenu(texto = "Esquiva distracciones y responde la pregunta.", color = "00FFFFFF"),
          new LineaMenu(texto = "Cada 30 s hay una zona sin obstaculos.", color = "00FFFFFF"),
          new LineaMenu(texto = "Recoge en orden las letras de la respuesta.", color = "FFFF00FF"), // Amarillo (regla importante)
        //  new LineaMenu(texto = "Completarla en carriles no da puntos.", color = "00FFFFFF"),
       //   new LineaMenu(texto = "Escribirla bien da 100 puntos por letra.", color = "00FFFFFF"),
      //    new LineaMenu(texto = "Equivocarte al responder no quita vidas.", color = "FFFF00FF"), // Amarillo (aclaración clave)
          new LineaMenu(texto = ""),
          new LineaMenu(texto = "Flechas: moverse | Enter: escribir / enviar", color = "00FF00FF"), // Verde para los controles principales
          new LineaMenu(texto = "A-Z: escribir | Backspace: borrar | Esc: volver", color = "00FF00FF"), // Verde
          new LineaMenu(texto = ""),
          new LineaMenu(texto = "Violento: Suerte asegura la proxima letra.", color = "00FFFFFF"),
          new LineaMenu(texto = "Brillante: Enfoque protege durante 5 s.", color = "00FFFFFF"),
          new LineaMenu(texto = "Promedio: sin habilidad. M: menu al terminar.", color = "00FFFFFF"),
          new LineaMenu(texto = ""),
          new LineaMenu(texto = "Esc o Enter: volver al menu", color = "00FF00FF") // Verde
      ])
  }
  method iniciarPartida() {
    self.limpiar()
    gameConfig.elegirPersonaje(personajes.get(indicePersonaje).crear(), dificultades.get(indiceDificultad))
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
  const color = "FFFFFFFF"
  method position() = game.at(5, altura)
  method text() = contenido
  method textColor() = color
}

class LineaMenu {
    const property texto
    const property color = "FFFFFFFF" // Si no le pasás color, es blanco
}

class Pantalla {
  method nombre()
  method flechas() = sinFlechas
  method confirmar() {}
  method cancelar() {}
  method borrar() {}
  method letra(letra) {}
  method avanzar() {}
  method colisionar(elemento) {}
}

object sinFlechas {
  method izquierda() {}
  method derecha() {}
  method arriba() {}
  method abajo() {}
}

class PantallaMenu inherits Pantalla {
  override method nombre() = "menu"
  override method flechas() = self
  method izquierda() { menuPrincipal.cambiarPersonaje(-1) }
  method derecha() { menuPrincipal.cambiarPersonaje(1) }
  method arriba() { menuPrincipal.cambiarDificultad(-1) }
  method abajo() { menuPrincipal.cambiarDificultad(1) }
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
  override method flechas() = self
  method izquierda() { gameConfig.moverIzquierda() }
  method derecha() { gameConfig.moverDerecha() }
  method arriba() {}
  method abajo() {}
  override method confirmar() { gameConfig.presionarEnter() }
  override method cancelar() { gameConfig.cancelar() }
  override method borrar() { gameConfig.borrar() }
  override method letra(letra) { gameConfig.escribir(letra) }
  override method avanzar() { gameConfig.avanzar() }
  override method colisionar(elemento) { gameConfig.colisionarCon(elemento) }
}
