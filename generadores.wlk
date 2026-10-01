//Para poner cuando aparece un objeto arriba de la pantalla
//Para poner cuando aparece un objeto arriba de la pantalla
import letras.*
import carriles.*
import respuestas.*
import azar.*
import distracciones.*
import ayudas.*
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
  
  method iniciar() {
    game.onTick(
      20000,
      "generarLetrasSimultaneas",
      { 
        const carriles = [carrilIzquierdo, carrilCentral, carrilDerecho]
        const carrilParaCorrecta = carriles.anyOne()
        const caracterCorrecto = respuestaActual.letraEsperada()

        // Colocamos la letra correcta
        const letraCorrectaFisica = new LetraFisica(
          caracter = caracterCorrecto,
          position = game.at(carrilParaCorrecta.posicionX(), 10)
        )
        game.addVisual(letraCorrectaFisica)

        // Colocamos las letras señuelos al azar en los carriles restantes
        const carrilesRestantes = carriles.filter(
          { carril => carril != carrilParaCorrecta }
        )
        return carrilesRestantes.forEach(
          { carril =>
            const letraAleatoria = azar.elementoDe(letrasDisponibles)
            const letraAleatoriaFisica = new LetraFisica(
              caracter = letraAleatoria,
              position = game.at(carril.posicionX(), 10)
            )
            return game.addVisual(letraAleatoriaFisica)
          }
        )
      }
    )
  }
}

object generadorDeObstaculos {
  method iniciar() {
    self.programarSiguiente()
  }
  
  method programarSiguiente() {
    // Tiempo de espera dinámico al azar (ej: entre 0.5 y 1.5 segundo)
    const esperaAleatoria = [500, 750, 1000, 1500].anyOne()
    
    game.schedule(
      esperaAleatoria,
      { 
        const carrilElegido = azar.carrilAleatorio()

        // Elegimos una imagen aleatoria de la lista de distracciones disponibles,hay que agregar a los .png
        const imagenAleatoria = azar.elementoDe(
          ["celular.png", "videojuego.png", "redesSociales.png"]
        )
        
        const obstaculo = new Obstaculo(
          image = imagenAleatoria,
          position = game.at(carrilElegido.posicionX(), 10)
        )
        
        game.addVisual(obstaculo)
        return // Se vuelve a programar a sí mismo para mantener el flujo constante y seguido
        self.programarSiguiente()
      }
    )
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
          game.addVisual(ayudaElegida)
        }
      }
    )
  }
}