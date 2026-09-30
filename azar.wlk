//Codigo para todos los objetos que necesiten el azar en algun lugar
import carriles.*

object azar {
  // Elige un carril al azar entre los tres disponibles
  method carrilAleatorio() = [
    carrilIzquierdo,
    carrilCentral,
    carrilDerecho
  ].anyOne()
  
  // Retorna un elemento aleatorio de cualquier lista que le pases
  method elementoDe(unaLista) = unaLista.anyOne()
}