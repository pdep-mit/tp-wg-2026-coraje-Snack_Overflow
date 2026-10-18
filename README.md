# Wollok Game: Título de juego

**Grupo:** Snack_Overflow

**Integrantes:**
- Stefano Lucero
- Candela Fava
- Joaquin Silva
- Nicolas Bidone

## Consignas

Todo lo que necesitan saber está explicado en [este documento](https://docs.google.com/document/d/1KoB12RIZk_xPhmnOJ-EfLIPNwkETD_EaYMp2srDu9QY/edit?tab=t.0#heading=h.wnm2lu4cls8j). Para todo lo demás, aseguren prestar atención a los comunicados por Discord.

Revisen los archivos de base y cambien lo que quieran para ajustarlo a sus necesidades. Lo primero que deberían hacer es actualizar

Recuerden que para cada checkpoint hay [expectativas mínimas](https://docs.google.com/document/d/1KoB12RIZk_xPhmnOJ-EfLIPNwkETD_EaYMp2srDu9QY/edit?tab=t.0#heading=h.56t0qdv908v3) respecto a los conceptos aplicados. Procuren:
- Validar su idea con el equipo docente que corresponda por su canal de Discord
- Para cada checkpoint, asegurar que implementaron lo necesario para esa instancia, y crear un **tag** en el repositorio para facilitar la comparación entre versiones final e intermedias.
- Para la demo final, crear un nuevo tag **demo** y actualizar este README con todo lo necesario.

# Cómo jugar — Checkpoint 2

Elegí personaje y dificultad desde el menú principal. Esquivá distracciones y
recogé en orden las letras que responden la pregunta. Cada 30 segundos aparece
una zona segura con tres opciones de letra y sin obstáculos.

Completar la respuesta en los carriles resuelve la pregunta sin puntos. También
podés escribirla: acertar otorga **100 puntos por cada letra de la respuesta**.
Las letras y respuestas incorrectas no descuentan vidas ni puntos.

## Personajes

| Personaje | Daño por distracción | Velocidad base | Habilidad con F |
| --- | --- | --- | --- |
| Promedio | 1 corazón | 2.5 celdas/s | Sin habilidad |
| Violento | 2 corazones | 3.33 celdas/s | Suerte: la próxima letra recogida será correcta |
| Brillante | 1 corazón | 1.67 celdas/s | Enfoque: escudo durante 5 segundos |

Cada habilidad puede usarse **una sola vez por partida**, sin cooldown. El tiempo
del escudo se pausa al escribir. Todos comienzan con 5 corazones.

Fácil aplica un factor de 0.75 a la velocidad y frecuencia de distracciones;
Normal usa 1 y Difícil 1.25. La dificultad no cambia daño, puntaje ni habilidades.

## Controles

En el menú:

- Izquierda / Derecha: elegir personaje.
- Arriba / Abajo: elegir dificultad.
- Enter: comenzar una partida nueva.
- H: explicación y controles. Escape o Enter: volver al menú.

En la partida:

- Izquierda / Derecha: cambiar de carril.
- F: activar la habilidad elegida, una sola vez.
- Enter: abrir la escritura y confirmar la respuesta.
- A–Z: escribir (F también escribe dentro de este modo).
- Backspace: borrar. Escape: cancelar y retomar el recorrido.
- Enter: volver al menú desde Victoria o Game Over. M también permite volver al terminar.

Al comenzar otra partida se reinician vidas, puntos, pistas y habilidades.

## Ejecutar

```sh
wollok run juego.MinijuegoEstudiante -p . --port 4202
```

Abrir [el juego](http://localhost:4202/juego.html). La página `juego.html` permite
usar Escape con el cliente instalado de Wollok Game; conservar esa ruta si se
cambia de puerto.

```sh
wollok test -p .
```

## Explicaciones

Herencia, polimorfismo, responsabilidades y diagrama en [explicaciones.md](explicaciones.md).
