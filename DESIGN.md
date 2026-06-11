# Documento de Diseño de Videojuego (GDD) - Proyecto "Tant-R: Override"

Este documento establece las especificaciones conceptuales, artísticas y de diseño técnico para la reimaginación moderna del clásico juego de arcade de los 90, **Tant-R**. El objetivo es mantener intacta la estructura y el ritmo frenético del juego original, elevando su apartado visual a los estándares de la actual generación mediante un estilo 3D estilizado y dinámico.

---

## 1. Visión General del Proyecto

### 1.1. Logline
Dos detectives torpes pero decididos persiguen a un carismático y escurridizo criminal a través de una serie de mundos caóticos, superando minijuegos contrarreloj en un formato de ruleta vertiginosa.

### 1.2. Pilares de Diseño
* **Frenetismo Arcade:** Partidas rápidas, toma de decisiones en fracciones de segundo y penalizaciones estrictas de tiempo.
* **Estética Neo-Retro Pop:** Un lavado de cara tridimensional con colores neón desaturados, formas redondeadas y acabados pulidos (estilo *Fall Guys* / *Luigi's Mansion 3*).
* **Humor Absurdo y Cultura Pop:** Mantener los juegos de palabras (*puns*) y los guiños visuales a iconos culturales de la música y el cine.
* **Accesibilidad Multijugador:** Controles ultrasencillos e intuitivos ideales para el juego cooperativo y competitivo local o en línea.

---

## 2. Trama y Ambientación

### 2.2. Argumento
El peligroso y extravagante criminal conocido como **"The Boss"** se ha fugado de la prisión de máxima seguridad, reclutando a su paso a una banda de secuaces torpes. Los célebres detectives inspirados en Sherlock Holmes y el Dr. Watson inician una persecución internacional para capturarlos a todos. Tras cada arresto exitoso, los detectives son aclamados en un escenario teatral por su público.

### 2.3. Mundos y Localizaciones (Stages)
El juego se divide en cuatro mundos principales en el Modo Arcade y una ruta alternativa en Multijugador:

| Etapa / Modo | Localización | Elementos Visuales Clave |
| :--- | :--- | :--- |
| **Stage 1 (Arcade)** | La Ciudad Euro-Mix | Fusión de monumentos (el Big Ben junto a la Torre Eiffel). Arquitectura de juguete, luces diurnas brillantes. |
| **Stage 2 (Arcade)** | El Desierto de Cactos | Dunas gigantes, cactus caricaturescos, ruinas antiguas y oasis con luces de neón. |
| **Stage 3 (Arcade)** | El Casino del Caos | Dados gigantes flotantes, ruletas interactivas de fondo, alfombras psicodélicas. |
| **Stage 4 (Arcade)** | La Obra Lunática | Grúas amarillas hiperbólicas, vigas que rebotan, cemento fresco y andamios dinámicos. |
| **Modo Multijugador** | La Autopista Loca | Persecución a alta velocidad con fondo de carretera infinita, culminando en el Palacio de Westminster. |

---

## 3. Estilo Visual y Dirección de Arte

### 3.1. Estética General
* **Estilo Visual:** 3D Estilizado / *Chibi-High-Poly*.
* **Paleta de Colores:** Tonos alegres y veraniegos con acentos neón brillantes para los elementos de la interfaz (HUD) y los coleccionables.
* **Iluminación:** Uso sutil de *tilt-shift* para simular un mundo de maquetas o dioramas vivos.

### 3.2. Guía de Prompts de IA para Arte Conceptuall

#### A. Personajes Principales (Detectives)
> `Character design sheet for two goofy detective partners inspired by Sherlock Holmes and Dr. Watson. Modern stylized 3D animation style. One detective is tall and thin in a sleek, updated tweed trench coat and a tech-deerstalker hat. The second detective is shorter, rounder, wearing a modern utility vest over a smart suit. Expressive, comedic faces, posing heroically. Colorful, bright, crisp details, white background.`

#### B. El Villano (The Boss)
> `Character concept of 'The Boss', a comical, over-the-top cartoon criminal mastermind who just escaped prison. He is wearing a stylized, vibrant black-and-yellow striped modern tracksuit, holding a canvas bag with a neon '$' sign. Next to him are two goofy, clumsy henchmen. Cartoonish, expressive villainy, vibrant colors, 3D render style.`

#### C. Pantalla de Selección (UI Roulette)
> `Game UI/UX design screen for a modern arcade puzzle game. In the center, a high-tech, glowing holographic roulette wheel spinning rapidly, displaying four distinct colorful mini-game icons (puzzles, counting, memory, fast-paced action). Modern neon typography, sharp HUD elements, a timer countdown bar at the top, and a "3 Hearts" life counter in the corner. Sleek, clean, and futuristic arcade aesthetic.`

---

## 4. Mecánicas de Juego y Estructura

### 4.1. El Núcleo de la Partida (Loop Principal)
1. **La Ruleta:** El jugador visualiza cuatro minijuegos que rotan a gran velocidad. Al pulsar el botón, se selecciona el juego actual (en Multijugador, la selección es automática y aleatoria).
2. **El Minijuego:** Superar el desafío antes de que el temporizador llegue a cero.
3. **Condición de Victoria:** Completar el cupo requerido de minijuegos por etapa para avanzar.
4. **Condición de Derrota:** Perder las 3 vidas iniciales. Fallar un juego o quedarse sin tiempo resta 1 vida.

### 4.2. Categorías de Minijuegos
Los 20 minijuegos integrados se clasifican en 5 tipologías troncales:
1. **Rompecabezas (Puzzle):** Reorganizar piezas, emparejar patrones geométricos en 3D.
2. **Conteo (Counting):** Calcular rápidamente el número de objetos en movimiento en pantalla.
3. **Concentración (Memory):** Retener secuencias de luces o sonidos e imitarlas a la perfección.
4. **Ráfaga (Barrage / Reflejos):** Pulsar botones en el momento exacto o machacar botones (*button mashing*).
5. **Búsqueda de Imágenes (Picture Search):** Localizar combinaciones específicas de símbolos (ej. iconos de tragaperras) en rejillas tridimensionales dinámicas.

### 4.3. El Sistema de Vidas y el Icono "Lucky!"
* Los jugadores comienzan con **3 vidas** representadas por contenedores de corazón de neón.
* Ocasionalmente, una de las opciones de la ruleta se transforma en el icono **"Lucky!"**.
* Al seleccionarlo, el jugador recibe una **pieza de corazón** y accede a un minijuego aleatorio. Al reunir 3 piezas, se otorga una vida extra.

---

## 5. Rondas Especiales y Desafío Final

### 5.1. Bonus Round (Etapas 1, 2 y 3)
* **Cinemática:** El Boss escapa flotando en un dirigible/globo aerostático con forma de su cabeza. Los detectives se montan en aviones retro-futuristas para darle caza.
* **Jugabilidad:** Una pantalla de scroll lateral continuo donde el objetivo es explotar todos los globos rojos flotantes mientras se esquivan misiles teledirigidos. 
* **Penalización:** El impacto de un misil paraliza temporalmente la aeronave del jugador.
* **Recompensa:** Explotar el 100% de los globos otorga una vida extra.

### 5.2. El Enfrentamiento Final (Stage 4)
Al completar los minijuegos del cuarto mundo, se activa la detención del Boss a través de una mecánica exclusiva según la plataforma:
* **Mecánica Táctica (Estilo Consola):** Un mapa interactivo modernizado en 3D donde se debe triangular la ubicación exacta de la guarida del criminal mediante pistas dinámicas.
* **Mecánica de Acción (Estilo Portátil/Móvil):** Una persecución automovilística de ritmo frenético donde se deben esquivar vehículos civiles mediante giros cerrados para embestir al Boss.

---

## 6. Referencias Visuales y Easter Eggs Pop

Para conservar el alma de los 90, los minijuegos y escenarios incluirán referencias sutiles a la cultura pop rediseñadas con el nuevo motor gráfico:
* **"Magical Sound Shower":** La mítica pista musical se remezcla con sintetizadores modernos durante las fases de persecución.
* **Guiño a Stanley Kubrick:** El minijuego de memoria incorporará un laberinto congelado o texturas de alfombra idénticas a las del Hotel Overlook en formato estilizado.
* **Homenajes Musicales:** Carteles de neón de fondo con tipografías inspiradas en *Billy Joel* y conciertos de *Rock 'n' Roll* clásicos.
