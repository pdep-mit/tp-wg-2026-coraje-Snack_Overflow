
import respuestas.*
import gameConfiguration.*
import wollok.game.*

object preguntaVisual {
  method position() = game.at(5, 15)

  // Texto provisional para CP1.
  method text() = gameConfig.preguntaActual()
}

object palabraArmadaVisual {
  method position() = game.at(5, 14)//hay 2 de distancia respecto a la pregunta por si es muy larga
  method text() = respuestaActual.textoConGuiones()
  //method text() = respuestaActual.palabraArmada()
}

object vidasVisual {
  method position() = game.at(10, 4)

  method image() =
    "vidas_" + gameConfig.jugador().concentracion().min(5).toString() + ".png"
}

object pantallaDesaprobado {
  method position() = game.at(-3, 4)
    method image() = "desaprobaste.png"
}

object filtroOscuro {
    // Lo anclamos abajo a la izquierda
    method position() = game.origin()
    method image() = "filtro_oscuro.png"
    method text() = ""
}
object habilidadVisual {
  method position() = game.at(2, 0)
  method text() = "Habilidad:"+gameConfig.jugador().estadoHabilidad()
  method textColor() = "FFFFFFFF"
}
object imagenPersonajeVisual {
  method position() = game.at(10, 11)
  method image() = gameConfig.jugador().image()
}

object rolPersonajeVisual {//Linea para que sea claro que es promedio
  method position() = game.at(9, 10)
  method text() = "           Estudiante"
  method textColor() = "FFFFFFFF"
}
object nombrePersonajeVisual {
  method position() = game.at(9, 9)
  method text() = "           " + gameConfig.jugador().nombre()
  method textColor() = "00FFFFFF"
}
