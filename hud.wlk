import estudiante.*
import respuestas.*
import gameConfiguration.*
import wollok.game.*

object preguntaVisual {
  method position() = game.at(1, 11)

  // Texto provisional para CP1.
  method text() = gameConfig.preguntaActual()
}

object palabraArmadaVisual {
  method position() = game.at(2, 10)

  method text() = respuestaActual.palabraArmada()
}

object vidasVisual {
  method position() = game.at(6, 11)

  method image() =
    "vidas_" + estudiante.concentracion().toString() + ".png"
}