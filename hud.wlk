//Se pondra la pantalla con la pregunta y si hay un sistema de vidas o algo asi
//Se pondra la pantalla con la pregunta y si hay un sistema de vidas o algo asi
import estudiante.*
import respuestas.*
import wollok.game.*

object preguntaVisual {
  // Posición estática arriba a la izquierda (ajustar la coordenada Y según el tamaño de su fondo)
  method position() = game.at(1, 11)
  
  // ---------------------------------------------------------
  // --- MÉTODOS PARA EL PRÓXIMO CHECKPOINT (CP2) O FUTURO ---
  // ---------------------------------------------------------
  // TODO (CP2): Devolver el texto de la pregunta actual que el jugador debe responder.
  // Pista: Probablemente necesiten preguntarle a un nuevo objeto (ej: 'profesor') cuál es la pregunta en curso.
  method text() = "QUE ES LA CAPACIDAD QUE TIENEN..."
}

object palabraArmadaVisual {
  // Un poco más abajo que la pregunta
  method position() = game.at(2, 10)
  
  method text() = ""
}

object vidasVisual {
  // Posición estática arriba a la derecha
  method position() = game.at(6, 11)
  
  // TODO: Devolver un nombre de imagen dinámico basado en la vida actual del estudiante.
  // Pista: Pueden concatenar strings usando toString(). 
  // Ejemplo: return "vidas_" + estudiante.concentracion().toString() + ".png"
  // De esta forma buscará automáticamente archivos como "vidas_3.png", "vidas_2.png", etc. en la carpeta assets.
  method image() = "vidas_n.png"
}