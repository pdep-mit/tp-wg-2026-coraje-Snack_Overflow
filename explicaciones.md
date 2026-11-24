# Diseño orientado a objetos — Checkpoint 2

El diagrama de clases está en diagrama.png.

## Un personaje, una instancia

`Personajes` es la superclase abstracta de `Promedio`, `Violento` y `Brillante`.
Contiene lo que comparten los tres: carril, vidas, velocidad y protección. Cada subclase debe definir
`nombre()`, `danioPorDistraccion()` `velocidadObstaculos()` , `usarHabilidad()` y `estadoHabilidad()`.

El antiguo objeto `estudiante` fue eliminado: duplicaba la interfaz del personaje
mediante delegaciones. `SesionDeJuego` conserva directamente la instancia elegida.
`gameConfig.jugador()` permite consultarla desde los visuales y la pista.
El jugador dibujado, el receptor de colisiones y el dueño de las vidas son el
mismo objeto. Al elegir otro personaje se retira el visual anterior y se elimina
su manejador de colisiones antes de registrar el nuevo.

## Habilidades en las subclases

- `Promedio` implementa `usarHabilidad()` sin efecto y su estado es "Ninguna". 
- `Violento` administra su uso único y la letra asegurada. Solo esta clase entiende
  `tieneSuerte()`, `consumirSuerte()` y `letraElegida(...)`.
- `Brillante` administra el uso único de Enfoque y activa la protección común.

Todas las letras envían `recogerLetra(letra, respuesta)` al personaje. La base
entrega la letra a la respuesta; Violento redefine ese mensaje para aplicar
Suerte antes de entregarla. No se consulta el tipo del personaje.
La Suerte es el rol Eleccion: eleccionNormal devuelve la letra recogida y eleccionConSuerte devuelve la correcta. El texto del estado lo decide el primer objeto estadoEscudo, estadoSuerte, estadoUsada o estadoDisponible que corresponda al personaje.

## Por qué el escudo sí es común

Apuntes puede dar un escudo a cualquiera de los tres personajes. Por eso
`activarEscudo()`, `tieneEscudo()` y `avanzarTiempo(ms)` permanecen en la
superclase. El escudo recibido como ayuda no consume la habilidad propia.
La protección es el rol Proteccion, que implementa
`vulnerable` que descuenta vida y `Escudo` que absorbe el golpe. `avanzar(ms)` devuelve la protección siguiente: `Escudo` se devuelve a sí mismo hasta que se agotan sus  segundos y después devuelve `vulnerable`. El personaje solo reasigna el resultado.

## Objetos que caen en la pista

Todo lo que el personaje puede chocar entiende `serChocadoPor(personaje)` (rol `Colisionable`). `ModoCarriles` lo envía sin preguntar de qué tipo es el objeto.
`ObjetoJuego` es abstracta. Guarda imagen, posición y avance de la caída, y deja `serChocadoPor(personaje)` sin cuerpo porque un objeto genérico no tiene qué hacer al chocarlo.
`Obstaculo` hace perder concentración.
`Ayuda` es abstracta y fija el esquema común (aplicar el efecto y retirarse del tablero); cada subclase solo define `aplicarEfecto(personaje)`: `Cafe` recupera concentración, `Apuntes` activa el escudo y `AyudaClaude` completa una letra comodín.
`LetraFisica` entrega la letra al personaje y cierra la tanda.

## Modos de Juego

`SesionDeJuego` delega cada evento (movimiento, Enter, letras, colisiones, paso del tiempo) en el modo actual, que decide qué hacer con él:
`ModoDeJuego` es la base abstracta (`nombre()` queda sin cuerpo).
`ModoCarriles` agrupa lo común a `ModoRecorrido` y `ModoZonaSegura`.
`ModoEscritura` atiende el borrador de la respuesta; `ModoResuelto` y `ModoSinVidas` son los finales.

Las transiciones entienden solo `corresponde(sesion, tiempo)` e `iniciar(sesion)`. Las cumplen `ModoZonaSegura`, `ModoResuelto`, `ModoSinVidas`, `FinDeZona` y el object `continuarModo`. `FinDeZona` y `continuarModo` no heredan de `ModoDeJuego` porque no son modos y así no arrastran mensajes que no usan. Para decidir qué sigue, el modo busca la primera transición que corresponde.

## Pantallas y controles

`menuPrincipal` conserva la pantalla activa y le envía los eventos de teclado. `Pantalla` es la base abstracta y las tres pantallas heredan directamente de ella:

La base no declara los mensajes de las flechas. Solo declara `flechas()`, que por defecto devuelve `sinFlechas`, un object que ignora las cuatro direcciones.
`PantallaMenu` y `PantallaPartida` redefinen `flechas()` y se devuelven a sí mismas. En el menú las flechas cambian personaje y dificultad; en partida cambian de carril (arriba y abajo no hacen nada).
`PantallaAyuda` no redefine `flechas()`, así que las flechas no producen efectos.
En partida, el cambio de carril pasa por la sesión, que lo ignora al escribir una respuesta o cuando termina la partida.

Los manejadores de teclado se registran una vez y envían todo a `menuPrincipal`.

## Dificultad y respuestas

La dificultad pertenece a la configuración de la partida `gameConfig`. `facil`, `normal` y `dificil` son objetos de la clase `Dificultad` con un factor (1.5, 1 y 0.75). La velocidad de caída se divide por el factor y el tiempo entre apariciones de distracciones y ayudas se multiplica por él. Fácil es más lento y espaciado, Difícil más rápido y frecuente. La presentación de Game Over pertenece al modo sin vidas, no al personaje.

`Respuesta` valida letras e intentos sin condicionales anidados: cada caso es un object (`letraAceptada`, `letraIgnorada`, `intentoCorrecto`, `intentoIncorrecto`, etc.) y se elige el primero que corresponde.

## Verificación

Los tests comprueban escudo para todos los personajes, uso único, letras, la dificultad, reinicio, teclado con el motor iniciado y colisiones sobre la instancia elegida.
