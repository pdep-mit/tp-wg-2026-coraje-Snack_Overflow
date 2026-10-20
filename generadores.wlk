import azar.*
import distracciones.*
import ayudas.*
import gameConfiguration.*
import wollok.game.*

object generadorDeObstaculos {
    method generar() {
        const carrilElegido = azar.carrilAleatorio()
 
       const imagenAleatoria = azar.elementoDe(["celular.png", "videojuego.png", "redesSociales.png"])
            const obstaculo = new Obstaculo(
                image = imagenAleatoria,
                position = game.at(carrilElegido.posicionX(), 10)
            )
            pistaDelJuego.agregarObstaculo(obstaculo)
        }
}

object generadorDeAyudas {
    method generarAyuda() {
        const carrilElegido = azar.carrilAleatorio()
        const pos = game.at(carrilElegido.posicionX(), 10)
        const tipoAyuda = azar.elementoDe([
            new AyudaClaude(position = pos),
            new Cafe(position = pos),
            new Apuntes(position = pos)       
             ])
        pistaDelJuego.agregarObstaculo(tipoAyuda) 
    }
}