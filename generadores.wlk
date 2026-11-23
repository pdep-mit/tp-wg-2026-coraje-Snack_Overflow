import azar.*
import distracciones.*
import ayudas.*
import gameConfiguration.*

object generadorDeObstaculos {
  method crear() {
    const imagen = azar.elementoDe(["celular.png", "videojuego.png", "redesSociales.png"])
    return new Obstaculo(image = imagen)
  }

  method generar() {
    pistaDelJuego.agregarObstaculo(self.crear())
  }
}

object generadorDeAyudas {
  method crear() = azar.elementoDe([new AyudaClaude(), new Cafe(), new Apuntes()])

  method generarAyuda() {
    pistaDelJuego.agregarObstaculo(self.crear())
  }
}
