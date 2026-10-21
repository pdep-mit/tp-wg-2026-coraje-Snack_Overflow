import azar.*
import distracciones.*
import ayudas.*
import gameConfiguration.*
import wollok.game.*

object generadorDeObstaculos {
    method generar() {
       const imagenAleatoria = azar.elementoDe(["celular.png", "videojuego.png", "redesSociales.png"])
            const obstaculo = new Obstaculo( image = imagenAleatoria)
            pistaDelJuego.agregarObstaculo(obstaculo)
        }
}

object generadorDeAyudas {
    method generarAyuda() {
        const tipoAyuda = azar.elementoDe([
            new AyudaClaude(),
            new Cafe(),
            new Apuntes()       
             ])
        pistaDelJuego.agregarObstaculo(tipoAyuda) 
    }
}