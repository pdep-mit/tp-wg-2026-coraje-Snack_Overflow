//Para poner cuando aparece un objeto arriba de la pantalla
//Para poner cuando aparece un objeto arriba de la pantalla
import letras.*
import carriles.*
import respuestas.*
import azar.*
import distracciones.*
import ayudas.*
import gameConfiguration.*
import wollok.game.*


object generadorDeLetras {
  // El abecedario vive acá adentro y no molesta en el programa principal
  const letrasDisponibles = [
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "L",
    "M",
    "N",
    "O",
    "P",
    "Q",
    "R",
    "S",
    "T",
    "U",
    "V",
    "W",
    "X",
    "Y",
    "Z"
  ]
    method generar() {
        const carriles = [carrilIzquierdo, carrilCentral, carrilDerecho]
        const carrilParaCorrecta = carriles.anyOne()
        const caracterCorrecto = respuestaActual.letraEsperada() 
        
        const letraCorrectaFisica = new LetraFisica(
            caracter = caracterCorrecto,
            position = game.at(carrilParaCorrecta.posicionX(), 10)
        )
        pistaDelJuego.agregar(letraCorrectaFisica)
        
        const carrilesRestantes = carriles.filter({ carril => carril != carrilParaCorrecta })
        carrilesRestantes.forEach({ carril =>
            const letraAleatoria = azar.elementoDe(letrasDisponibles)
            const letraAleatoriaFisica = new LetraFisica(
                caracter = letraAleatoria,
                position = game.at(carril.posicionX(), 10)
            )
            pistaDelJuego.agregar(letraAleatoriaFisica)
        })
    }

}

object generadorDeObstaculos {
    method generar() {
        const carrilElegido = azar.carrilAleatorio()
        const imagenAleatoria = azar.elementoDe(["celular.png", "videojuego.png", "redesSociales.png"])
        
        const obstaculo = new Obstaculo(
            image = imagenAleatoria,
            position = game.at(carrilElegido.posicionX(), 10)
        )
        pistaDelJuego.agregar(obstaculo)
    }
}

object generadorDeAyudas {
  // Lista con los objetos de ayuda existentes,puede que se agreguen mas
  const ayudasDisponibles = [cafe, apuntes]
  //esperaAleatoria entre 11s y 46
  const esperaAleatoria = [11700, 22400, 33300, 46000].anyOne()

  method iniciar() {
      game.schedule(
      esperaAleatoria,
      { 
        const carrilElegido = azar.carrilAleatorio()

        // Elegimos un objeto de ayuda al azar de la lista
        const ayudaElegida = azar.elementoDe(ayudasDisponibles)
         
        // Si el objeto elegido no está actualmente en pantalla, lo posicionamos y lo agregamos
        if (!game.hasVisual(ayudaElegida)) {
          ayudaElegida.position(game.at(carrilElegido.posicionX(), 10))
          pistaDelJuego.agregar(ayudaElegida)
        }
      }
    )
  }
}