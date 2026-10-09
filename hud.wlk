import estudiante.*
import respuestas.*
import gameConfiguration.*
import wollok.game.*

object preguntaVisual {
  method position() = game.at(5, 15)

  // Texto provisional para CP1.
  method text() = gameConfig.preguntaActual()
}

object palabraArmadaVisual {
  method position() = game.at(5, 13)//hay 2 de distancia respecto a la pregunta por si es muy larga
  method text() = respuestaActual.textoConGuiones()
  //method text() = respuestaActual.palabraArmada()
}

object vidasVisual {
  method position() = game.at(6, 11)

  method image() =
    "vidas_" + estudiante.concentracion().toString() + ".png"
}

object pantallaDesaprobado {
  method position() = game.at(-3, 4)
    
    // Acá ponés el nombre exacto de la imagen PNG semitransparente que armaste
    method image() = "desaprobaste.png" 
}

object filtroOscuro {
    // Lo anclamos abajo a la izquierda
    method position() = game.origin() 
    
    // Tu imagen gigante semitransparente
    method image() = "filtro_oscuro.png" 
}