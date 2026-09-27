//Aca va todo el codigo de las letras,y a futuro (CP2) que compare si es correcta la respuesta
//Aca va todo el codigo de las letras,y a futuro (CP2) que compare si es correcta la respuesta
object respuestaActual {
  var palabraArmada = ""
  var letrasFaltantes = []
  // Se espera una lista de strings, ej: ["O", "B", "J", "E", "T", "O"]
  
  method setearRespuestaEsperada(listaDeLetras) {
    
    // TODO: Asignar el parámetro 'listaDeLetras' a la variable 'letrasFaltantes'.
    // TODO: Vaciar la variable 'palabraArmada' asignándole un string vacío "".
    // Nota: Este método lo va a llamar la pregunta cuando arranque el minijuego.
  }
  
  method agregarLetra(unaLetra) {
    
    // TODO: Verificar si 'unaLetra' es igual al primer elemento de la lista 'letrasFaltantes' (usando letrasFaltantes.first()).
    // Si ES IGUAL:
    // 1. Concatenar 'unaLetra' al final de la variable 'palabraArmada'.
    // 2. Remover esa letra de la lista 'letrasFaltantes' (pueden usar letrasFaltantes.remove(unaLetra) o un método similar).
    // Si NO ES IGUAL (se equivocó de letra):
    // 1. Enviar el mensaje 'estudiante.perderConcentracion(10)'.
  }
  
  // ---------------------------------------------------------
  // --- MÉTODOS PARA EL PRÓXIMO CHECKPOINT (CP2) O FUTURO ---
  // ---------------------------------------------------------
  method estaCompleta() = false
  
  method reiniciar() {
    
    // TODO (CP2): Vaciar la variable 'palabra' (asignarle "") para prepararse para la siguiente pregunta.
  }
}