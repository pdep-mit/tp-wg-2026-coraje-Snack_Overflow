import azar.*

// Definimos una clase para modelar cada pregunta de forma estructurada
class Pregunta {
  var property enunciado
  var property letras
} //Despues se deben agregar mas preguntas

object bancoDePreguntas {
  const preguntasDisponibles = [
    new Pregunta(
      enunciado = "Paradigma basado en moldes, clases e instancias",
      letras = ["O", "B", "J", "E", "T", "O"]
    ),
    new Pregunta(
      enunciado = "Nuestra facultad regional en Buenos Aires",
      letras = ["U", "T", "N"]
    ),
    new Pregunta(
      enunciado = "Lenguaje funcional puro que estudiamos en PDEP",
      letras = ["H", "A", "S", "K", "E", "L", "L"]
    ),
    new Pregunta(
      enunciado = "Lenguaje lógico basado en hechos y reglas",
      letras = ["P", "R", "O", "L", "O", "G"]
    ),
    new Pregunta(
      enunciado = "Lenguaje de objetos con soporte para videojuegos",
      letras = ["W", "O", "L", "L", "O", "K"]
    )
    
  ]
  
  method preguntaAleatoria() = azar.elementoDe(preguntasDisponibles)
}