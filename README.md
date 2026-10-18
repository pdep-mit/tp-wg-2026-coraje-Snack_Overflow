# Wollok Game: Título de juego

**Grupo:** Snack_Overflow

**Integrantes:**
- Stefano Lucero
- Candela Fava
- Joaquin Silva 
- Nicolás Bidone

## Consignas

Todo lo que necesitan saber está explicado en [este documento](https://docs.google.com/document/d/1KoB12RIZk_xPhmnOJ-EfLIPNwkETD_EaYMp2srDu9QY/edit?tab=t.0#heading=h.wnm2lu4cls8j). Para todo lo demás, aseguren prestar atención a los comunicados por Discord.

Revisen los archivos de base y cambien lo que quieran para ajustarlo a sus necesidades. Lo primero que deberían hacer es actualizar 

Recuerden que para cada checkpoint hay [expectativas mínimas](https://docs.google.com/document/d/1KoB12RIZk_xPhmnOJ-EfLIPNwkETD_EaYMp2srDu9QY/edit?tab=t.0#heading=h.56t0qdv908v3) respecto a los conceptos aplicados. Procuren:
- Validar su idea con el equipo docente que corresponda por su canal de Discord
- Para cada checkpoint, asegurar que implementaron lo necesario para esa instancia, y crear un **tag** en el repositorio para facilitar la comparación entre versiones final e intermedias.
- Para la demo final, crear un nuevo tag **demo** y actualizar este README con todo lo necesario.

# Cómo jugar
El jugador debe esquivar usando las flechas izquierda/derecha para moverse entre carriles. Cuando aparezcan las letras, debe recoger la siguiente letra correcta hasta completar la respuesta.

## Objetivo

El jugador debe esquivar las distracciones que tiene su personaje mientras intenta recordar la respuesta a la pregunta que esta en el examen recordando la respuesta letra por letra

## Controles

- Flechas izquierda/derecha: cambiar de carril.
- Enter: abrir el modo de respuesta; volver a pulsarlo para confirmar.
- Letras A–Z: escribir la respuesta. Backspace: borrar.
- Escape: cancelar la escritura y regresar al modo anterior conservando las pistas.
- Las respuestas incorrectas no descuentan vidas ni puntos.

## Ejecutar con Escape habilitado

Desde la carpeta del proyecto:

```sh
wollok run juego.MinijuegoEstudiante -p . --port 4202
```

Abrir [el juego](http://localhost:4202/juego.html). Si se usa otro puerto,
agregar `/juego.html` a la dirección que muestra Wollok.

Esta página usa el motor de Wollok Game instalado y transmite la tecla Escape
correctamente. El cliente predeterminado de Wollok Game 2.1.1 (la página `/`)
no reconoce esa tecla; por eso se incluye `assets/juego.html` en el proyecto.
No hace falta modificar ni reinstalar el CLI.

# Explicaciones

Las explicaciones teóricas y diagramas van a encontrarse en [explicaciones.md](explicaciones.md) a partir del Checkpoint #2.
