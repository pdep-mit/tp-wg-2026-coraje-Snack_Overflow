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