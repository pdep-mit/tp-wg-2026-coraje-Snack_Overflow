//la diferencia de 2 entre posiciones es para que no parezcan
//muy pegados entre si, pero todo dependera de los assets que tengamos del estudiante y obstaculos
object carrilIzquierdo {
  method posicionX() = 3
  
  method izquierda() = self
  
  method derecha() = carrilCentral
}

object carrilCentral {
  method posicionX() = 5
  
  method izquierda() = carrilIzquierdo
  
  method derecha() = carrilDerecho
}

object carrilDerecho {
  method posicionX() = 7
  
  method izquierda() = carrilCentral
  
  method derecha() = self
}