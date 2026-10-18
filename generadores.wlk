import azar.*
import distracciones.*
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
