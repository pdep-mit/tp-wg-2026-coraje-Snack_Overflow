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
  method iniciar(letrasDisponibles) {
    game.onTick(
      20000,
      "generarLetrasSimultaneas",
      { 
        // 1. Obtenemos los carriles disponibles
        const carriles = [carrilIzquierdo, carrilCentral, carrilDerecho]
        
        
        // 2. Elegimos un carril al azar exclusivamente para la letra correcta
        const carrilParaCorrecta = carriles.anyOne()
        
        
        
        // 3. Le pedimos a la respuesta actual cuál es la letra que corresponde ahora
        // (Asegurate de que el método en respuestas.wlk se llame acorde, ej: letraEsperada() o similar)
        const caracterCorrecto = respuestaActual.letraEsperada()
        
        
        // Creamos y agregamos la letra correcta
        const letraCorrectaFisica = new LetraFisica(
          caracter = caracterCorrecto,
          position = game.at(carrilParaCorrecta.posicionX(), 10)
        )
        game.addVisual(letraCorrectaFisica)
        
        
        // 4. Filtramos los carriles que sobraron (los otros dos)
        const carrilesRestantes = carriles.filter(
          { carril => carril != carrilParaCorrecta }
        )
        return // 5. En los carriles restantes tiramos letras totalmente al azar de la lista
        carrilesRestantes.forEach(
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
    // Tiempo de espera dinámico al azar (ej: entre 1 y 4 segundos)
    const esperaAleatoria = [1000, 1500, 2000, 2500, 3000, 3500, 4000].anyOne()
    
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
  
  method iniciar() {
    //Tiempo de 45 segundos,puede que despues se cambie a game.schedule para evitar el mismo tiempo y poner un rango
    game.onTick(
      45000,
      "generarAyudaEsporadica",
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