# TANT-R OVERRIDE
## Product Requirements Document v1.0  ·  Junio 2026  ·  Godot 4.x + iOS / Android

---

| Campo | Valor |
|-------|-------|
| **Proyecto** | Tant-R Override |
| **Tipo** | Arcade Mobile — Minijuegos |
| **Plataformas** | iOS 15+ · Android 10+ |
| **Motor** | Godot Engine 4.x (GDScript) |
| **Inspiración** | Puzzle & Action: Tant-R (Sega, 1993) |
| **Minijuegos** | 20 minijuegos únicos (5 categorías × 4 cada una) |
| **Modos de juego** | Historia (4 mundos), Contrarreloj, Multijugador local, Práctica |
| **Monetización** | Premium + cosméticos opcionales |
| **Estimación dev.** | 10–12 semanas (equipo pequeño) |
| **Autor PRD** | — / Junio 2026 |

---

# 1. Visión General

## 1.1 Concepto

Tant-R Override es una reimaginación contemporánea del clásico arcade de Sega de 1993. El jugador resuelve una cadena de minijuegos cronometrados de alta intensidad para atrapar a un criminal fugado. La propuesta central es tensión rítmica: cada minijuego dura entre 5 y 30 segundos, exigiendo reacciones rápidas, memoria y deducción visual.

> **🎯 Propuesta de valor única**
> Sesiones de juego ultra-cortas (2–5 min) ideales para móvil, con la adrenalina de un arcade de los 90 y una estética 3D estilizada moderna (estilo Fall Guys / Luigi's Mansion 3). La variedad de mecánicas elimina la repetitividad, el principal punto débil del original. El estilo visual Neo-Retro Pop combina lo mejor de la nostalgia arcade con gráficos 3D pulidos y accesibles.

## 1.2 Referencia: Tant-R Original (Sega, 1993)

El juego original fue desarrollado por Sega y lanzado en 1993 para arcade (Sega System C), con versiones posteriores para Mega Drive, Game Gear, Saturn y PS2. Sus características principales:

- **Original:** 20 minijuegos distribuidos en 4 fases
- Categorías: puzzle, conteo, concentración, barrage y búsqueda visual
- Sistema de vidas (3 vidas iniciales), tiempo límite por minijuego
- Selección de minijuego mediante ruleta (roulette wheel)
- Iconos "Lucky!" que otorgan pieza de corazón + juego aleatorio
- Rondas bonus: explotar globos mientras se esquivan misiles

Recibió críticas mixtas: se elogió la variedad y el multijugador, se criticó la repetitividad. Esta versión moderna aborda directamente esa debilidad.

## 1.3 Objetivos del Producto

| Objetivo | Métrica de éxito |
|----------|-----------------|
| Retención D1 > 45% | Partidas iniciadas vs completadas |
| Sesión media de 4–8 min | Analytics in-game |
| Rating ≥ 4.3 en stores | Reviews App Store / Google Play |
| 0 crashes en gameplay core | Crashlytics < 0.1% |
| Input lag < 50ms en mid-range | Tests en dispositivos objetivo |

---

# 2. Usuarios Objetivo

## 2.1 Perfiles de usuario

| Nostálgico (25–40) | Casual Móvil (18–35) | Gamer Competitivo (16–28) |
|--------------------|----------------------|--------------------------|
| Conoce el Tant-R original | Busca partidas rápidas | Quiere ranking y retos |
| Valora la estética retro-moderna | Juega en transporte público | Domina todos los minijuegos |
| Comparte con amigos/familia | Sesiones de 3–5 min | Multijugador y leaderboards |

---

# 3. Mecánicas de Juego

## 3.1 Estructura de una partida

> **Flujo de juego principal**
> Menú → Selección de modo → Ruleta de minijuego (1.5s) → Minijuego (5–30s) → Resultado → Siguiente minijuego → [Bonus tras fase] → Resultado final → Leaderboard

El jugador completa bloques de 5 minijuegos por fase. Al superar una fase, se accede a un minijuego bonus (persecución aérea en dirigible). El juego tiene 4 fases en modo Historia (una por mundo: Ciudad Euro-Mix, Desierto de Cactos, Casino del Caos, Obra Lunática) y es infinito (con dificultad creciente) en modo Contrarreloj.

## 3.2 Sistema de vidas y puntuación

- Vidas iniciales: 3 (iconos de corazón estilo arcade)
- Perder una vida: tiempo agotado O error en minijuego
- Ganar vida: completar bonus stage O recoger 3 fragmentos Lucky
- Puntuación: base por minijuego + bonus por velocidad (< 50% del tiempo = x2)
- Lucky!: aparece aleatoriamente en la ruleta; activa juego random + fragmento de corazón
- Combo: completar 3 minijuegos seguidos sin error = multiplicador x1.5

## 3.3 Selección mediante ruleta

La ruleta muestra 4 opciones que rotan rápidamente (estilo slot machine). El jugador pulsa para detenerla. En multijugador, el juego se selecciona aleatoriamente. La selección tiene 1.5 segundos de animación antes de comenzar el minijuego, sirviendo como micro-transición dramática.

## 3.4 Dificultad progresiva

| Fase 1 (Ciudad) | Fase 2 (Desierto) | Fase 3 (Casino) | Fase 4 (Obra) |
|--------|--------|--------|--------|
| Tiempo: 100% | Tiempo: -20% | Tiempo: -35% | Tiempo: -50% |
| Sin distractores | Distractores visuales leves | Distractores intensos | Distractores + fakes |
| Patrones simples | Patrones compuestos | Patrones complejos | Patrones + velocidad |

---

# 4. Catálogo de Minijuegos

Los 20 minijuegos están diseñados cubriendo las 5 categorías del original (DESIGN.MD §4.2): Puzzle, Conteo, Concentración, Ráfaga y Búsqueda Visual. Cada uno tiene una mecánica de control táctil específica, una identidad visual propia en 3D estilizado, y rejillas/entornos tridimensionales dinámicos.

| # | Nombre | Tipo | Mecánica core | Duración | Dificultad |
|---|--------|------|---------------|----------|------------|
| 01 | Labyrinth Rush | Puzzle | Deslizar dedo para navegar laberinto 3D antes de que suba el agua | 20s | ⭐⭐ |
| 02 | Freeze Timer | Concentración | Tap en el momento exacto para detener el cronómetro en 0 | 15s | ⭐⭐⭐ |
| 03 | Animal Echo | Concentración | Memorizar y reproducir secuencia de sonidos animales | 25s | ⭐⭐⭐ |
| 04 | Slot Hunter | Búsqueda visual | Localizar el patrón correcto de símbolos en una rejilla 3D dinámica | 20s | ⭐⭐⭐ |
| 05 | Robot Match | Puzzle | Rotar pieza 3D para que coincida con su robot exacta | 18s | ⭐⭐ |
| 06 | Odd One Out | Puzzle | Identificar el elemento que NO pertenece al grupo (objetos 3D) | 12s | ⭐⭐ |
| 07 | Tap Frenzy | Ráfaga | Tap rápido para alcanzar un número objetivo antes de tiempo | 10s | ⭐⭐⭐⭐ |
| 08 | Count Fast | Conteo | Contar objetos 3D que aparecen y desaparecen rápidamente | 15s | ⭐⭐⭐ |
| 09 | Wire Connect | Puzzle | Conectar cables del color correcto sin cruces (vista superior 3D) | 22s | ⭐⭐⭐ |
| 10 | Mirror Draw | Concentración | Completar el dibujo simétricamente con el dedo | 20s | ⭐⭐ |
| 11 | Safe Cracker | Concentración | Mantener el indicador en la zona verde con micro-ajustes | 18s | ⭐⭐⭐⭐ |
| 12 | Pixel Hunt | Búsqueda visual | Encontrar el objeto diferente en una escena 3D abarrotada | 15s | ⭐⭐⭐⭐ |
| 13 | Rush Dodge | Ráfaga | Evitar obstáculos deslizando horizontalmente (bonus/boss) | 30s | ⭐⭐⭐⭐⭐ |
| 14 | Cube Stack | Puzzle | Apilar cubos en orden correcto antes de que caigan | 18s | ⭐⭐⭐ |
| 15 | Light Sequence | Concentración | Repetir secuencia de luces de neón en orden (Simon Says 3D) | 20s | ⭐⭐⭐ |
| 16 | Crowd Counter | Conteo | Contar cubos específicos en una multitud en movimiento | 15s | ⭐⭐⭐⭐ |
| 17 | Button Basher | Ráfaga | Golpear topos 3D que emergen de agujeros (Whack-a-Mole) | 12s | ⭐⭐⭐ |
| 18 | Symbol Match | Búsqueda visual | Encontrar pares de símbolos idénticos en rejilla giratoria 3D | 20s | ⭐⭐⭐ |
| 19 | Balance Act | Ráfaga | Mantener equilibrio inclinando (gyro/swipe) una plataforma | 15s | ⭐⭐⭐⭐ |
| 20 | Path Finder | Conteo | Seguir mentalmente un camino que se oculta y seleccionar destino | 18s | ⭐⭐⭐⭐ |

> **📌 Nota de diseño (DESIGN.MD §4.2)**
> Los minijuegos se clasifican en 5 tipologías troncales: Rompecabezas (reorganizar piezas, emparejar patrones geométricos 3D), Conteo (calcular objetos en movimiento), Concentración (retener secuencias de luces/sonidos), Ráfaga (pulsar botones en momento exacto o button mashing), y Búsqueda de Imágenes (localizar combinaciones en rejillas 3D dinámicas). Cada minijuego tiene instrucciones de 2 segundos antes de comenzar.

---

# 5. Modos de Juego

## 5.1 Modo Historia (Principal)

- 4 fases × 5 minijuegos + 1 bonus stage por fase (excepto Fase 4 que tiene boss final)
- Narrativa (DESIGN.MD §2.2): dos detectives inspirados en Sherlock Holmes y Dr. Watson persiguen al "Boss" criminal por 4 mundos
- Mundos (DESIGN.MD §2.3):
  - Fase 1: La Ciudad Euro-Mix (Big Ben + Torre Eiffel, arquitectura de juguete)
  - Fase 2: El Desierto de Cactos (dunas gigantes, cactus caricaturescos, oasis neón)
  - Fase 3: El Casino del Caos (dados flotantes, ruletas interactivas, alfombras psicodélicas)
  - Fase 4: La Obra Lunática (grúas hiperbólicas, vigas, andamios dinámicos)
- Bonus Rounds (DESIGN.MD §5.1): Boss escapa en dirigible con forma de su cabeza, detectives en biplanos retro-futuristas, scroll lateral explotando globos esquivando misiles
- Final (DESIGN.MD §5.2): Persecución automovilística frenética donde esquivar vehículos y embestir al Boss
- Desbloqueos: skins, variantes de minijuego al completar en distintas dificultades

## 5.2 Modo Contrarreloj (Endless)

- Minijuegos en bucle infinito con dificultad creciente cada 5 rondas
- Una sola vida; el objetivo es la puntuación máxima
- Leaderboard global semanal y mensual
- Ideal para sesiones cortas y competición asíncrona

## 5.3 Modo Práctica (Free Play)

- Acceso a cualquier minijuego desbloqueado sin penalización
- Muestra estadísticas personales: mejor tiempo, intentos, tasa de éxito
- Tutorial interactivo integrado en el primer acceso a cada juego

## 5.4 Multijugador Local (Pass & Play)

- 2–4 jugadores en un solo dispositivo, por turnos
- Ambientación: La Autopista Loca (DESIGN.MD §2.3) — persecución a alta velocidad, culmina en el Palacio de Westminster
- Minijuego seleccionado aleatoriamente (sin ruleta visible)
- Contador de victorias por jugador al final de la sesión
- Modo ideal para eventos sociales; icono especial en menú principal

---

# 6. Diseño Visual y Técnico

## 6.1 Estética (DESIGN.MD §3 — Autoridad Absoluta)

> **Dirección artística (DESIGN.MD §3.1)**
> Estilo Visual: **3D Estilizado / Chibi-High-Poly** — Un lavado de cara tridimensional con colores neón desaturados, formas redondeadas y acabados pulidos (estilo Fall Guys / Luigi's Mansion 3). Iluminación con tilt-shift sutil para simular un mundo de maquetas o dioramas vivos.

Elementos visuales clave:

- Resolución nativa: 1080×1920px (portrait) — no upscaling, renderizado 3D directo
- Paleta: tonos alegres y veraniegos + acentos neón brillantes (HUD, coleccionables)
- Iluminación: tilt-shift para efecto diorama/maqueta
- UI: neón sobre fondos oscuros, iconografía clara y grande (mínimo 44pt touch target)
- HUD: contenedores de corazón de neón, timer countdown bar, tipografía arcade moderna
- Cada mundo tiene su paleta dominante (Ciudad=cyan/amarillo, Desierto=naranja/magenta, Casino=dorado/rojo, Obra=amarillo/blanco)
- Personajes: chibi-high-poly con expresiones exageradas y comedicas (DESIGN.MD §3.2A)
- Animaciones de feedback: screen shake en error, flash en éxito, partículas en Lucky!
- Transiciones: wipe/flash estilo arcade

## 6.2 Stack Tecnológico

| Capa | Tecnología | Justificación |
|------|-----------|---------------|
| Motor | Godot Engine 4.x (4.2+ LTS) | 3D completo, export nativo iOS/Android, GDScript |
| Lenguaje | GDScript (typed) + C# si perf. crítica | Desarrollo ágil, integrado en Godot |
| Renderer (dev) | Forward+ | Features completas durante desarrollo |
| Renderer (release) | Mobile | Optimizado para dispositivos target (Vulkan subset) |
| Gráficos 3D | Godot 3D + Shaders visuales/GLSL | Estética 3D estilizada per DESIGN.MD |
| Post-process | Tilt-shift, Bloom/Glow, Vignette | Look de diorama, neón, atmosfera |
| Modelado 3D | Blender 3.6+ → export glTF 2.0 (.glb) | Pipeline estándar, free, compatible |
| Texturas | PNG (alpha) + WebP (opacas) | Optimización mobile |
| Audio | Godot AudioServer (8-channel SFX pool) | Latencia mínima, buses de mezcla |
| Arte 2D (UI) | Aseprite/Figma + Google Stitch | HUD sprites, iconos, mockups |
| Backend | Firebase (Analytics + Crashlytics + RTDB) | Leaderboards, cloud saves, métricas |
| Local storage | Godot FileAccess (user://save.json) | Progreso, ajustes, puntuaciones |
| CI/CD | GitHub Actions + firebelley/godot-export | Builds automáticos iOS/Android |
| Testing | GUT (Godot Unit Testing) | Tests automatizados en GDScript |
| Diseño | Google Stitch (mockups) + Blender (3D) | Diseños UI en Stitch, producción 3D en Blender |

## 6.3 Requisitos de Rendimiento

- 60 FPS constantes en dispositivos mid-range (iPhone 12, Samsung A52)
- Input lag máximo: 50ms desde tap hasta respuesta visual
- Tamaño de build: < 250MB (con assets 3D comprimidos)
- Tiempo de carga de minijuego: < 300ms (escenas pre-cargadas en background)
- Batería: sin polling activo entre minijuegos (pausa real del game loop)
- Compatibilidad: iOS 15+, Android 10+ (API level 29+)
- Draw calls por escena: < 50 (usar batching, MultiMesh, atlas)
- Triángulos visibles: < 30,000 por escena
- Partículas simultáneas: < 100
- RAM máxima: < 200MB en gameplay activo

## 6.4 Arquitectura Godot

> **Estructura de escenas**
> `GameController` (autoload singleton) → gestiona state machine del juego completo.
> `MiniGameBase` (clase base GDScript + escena heredable) → cada minijuego hereda y emite señal `completed(score, time)` o `failed()`.
> El controller orquesta la ruleta, las vidas, la puntuación global y las transiciones entre escenas.

State Machine del GameController:

```gdscript
enum GameState {
  MENU, MODE_SELECT, PHASE_INTRO, ROULETTE,
  MINIGAME_INTRO, MINIGAME_ACTIVE, MINIGAME_RESULT,
  BONUS_STAGE, PHASE_RESULT, BOSS_ESCAPE,
  FINAL_CONFRONTATION, GAME_OVER, VICTORY
}
```

Señales clave del sistema:

```gdscript
signal minigame_completed(score: int, time_left: float)
signal life_lost()
signal life_gained()
signal lucky_triggered(minigame_id: String)
signal phase_completed(phase: int, total_score: int)
signal game_over(final_score: int)
```

Pipeline de Assets 3D:

```
Blender 3.6+ → Export glTF 2.0 (.glb) → Godot Import → 
  → StandardMaterial3D / ShaderMaterial (Godot-native)
  → LOD automático (import settings)
  → Compression: ETC2 para mobile
```

---

# 7. Roadmap de Desarrollo

| Sprint | Semanas | Objetivo | Entregables |
|--------|---------|----------|-------------|
| S0 | 1–2 | Setup y pipeline 3D | Godot configurado (3D), pipeline Blender→Godot funcional, export iOS/Android, primeros modelos importados |
| S1 | 3–4 | Core + 4 minijuegos | GameController, MiniGameBase, Ruleta, Sistema de vidas, MG01+02+03+07 jugables |
| S2 | 5–6 | 8 minijuegos más | MG04–06+08–11 implementados, feedback visual/audio, pantalla de resultado |
| S3 | 7–8 | 8 minijuegos + Modo Historia | MG12–20, narrativa, 4 fases completas, bonus stages, boss final |
| S4 | 9 | Modos secundarios | Modo Contrarreloj, Práctica, Multijugador local |
| S5 | 10 | Polish visual 3D | Shaders (tilt-shift, glow, toon), animaciones, partículas, SFX/música |
| S6 | 11 | Backend + QA | Firebase integrado, leaderboards, testing en dispositivos, crashlytics |
| S7 | 12 | Release | Store submission iOS + Android, ASO, trailer de 30s |

---

# 8. Monetización

## 8.1 Modelo principal: Premium

El juego se vende a precio único ($2.99–$4.99). No hay anuncios in-game ni pay-to-win. Esta decisión preserva la experiencia arcade auténtica y genera mejor rating en stores.

## 8.2 Cosméticos opcionales (IAP)

- Packs de skins para los detectives y escenarios ($0.99 c/u)
- Pack de efectos de pantalla retro (CRT, VHS, scanlines)
- Ningún contenido de gameplay detrás de paywall

## 8.3 Lo que NO habrá

- Sin anuncios (ni banner, ni interstitial, ni rewarded)
- Sin vidas limitadas por tiempo real
- Sin energía o cooldowns

---

# 9. Métricas y Analytics

| Métrica | Objetivo | Herramienta |
|---------|----------|-------------|
| Retención D1 | > 45% | Firebase Analytics |
| Retención D7 | > 20% | Firebase Analytics |
| Duración sesión media | 4–8 minutos | Firebase Analytics |
| Tasa de crash | < 0.1% | Firebase Crashlytics |
| Minijuego más abandonado | Identificar y rebalancear | Evento custom: `mg_abandoned` |
| Conversión IAP | > 3% de usuarios activos | RevenueCat + Firebase |
| Rating store | ≥ 4.3 estrellas | App Store Connect / Play Console |

---

# 10. Riesgos y Mitigaciones

| Riesgo | Impacto | Mitigación |
|--------|---------|------------|
| Input lag en dispositivos low-end | Alto | Tests tempranos en dispositivos S7/A32; optimización de draw calls |
| Minijuegos percibidos como repetitivos | Medio | Variantes de dificultad por minijuego + rotación por sesión |
| Rechazo de Apple/Google en store review | Bajo | Revisar guidelines antes de submission; TestFlight beta previa |
| Scope creep (más de 13 minijuegos en v1) | Medio | Hard-freeze de scope en S2; minijuegos extra van a v1.1 |

---

# 11. Próximos Pasos Inmediatos

**Esta semana (S0):**

1. Instalar Godot 4.x LTS (con Mono/C# support por si se necesita)
2. Instalar Blender 3.6+ y configurar export pipeline glTF → Godot
3. Crear repositorio GitHub con estructura de proyecto 3D
4. Conectar Stitch MCP y exportar mockups UI como referencia
5. Configurar renderer Mobile en project.godot (1080×1920, portrait)
6. Implementar GameController + MiniGameBase + primera escena de ruleta
7. Prototipo jugable de MG01 (Labyrinth Rush) con assets placeholder 3D

**Decisiones pendientes antes de Sprint 1:**

- Confirmar los 20 minijuegos exactos y su distribución por categoría
- Definir nivel de detalle 3D por personaje (polycount budgets)
- Definir si el primer release incluye multijugador local o va a v1.1
- Acordar política de precio en stores (premium vs. freemium)
- Configurar repositorio, branching strategy y CI/CD básico

---

# 12. Sistema Agéntico (IA para Desarrollo)

Este proyecto utiliza un sistema multi-agente de IA para desarrollo, con la siguiente estructura:

| Agente | Rol | Autoridad |
|--------|-----|-----------|
| **Orchestrator** | Coordinar sprints, delegar, validar | Máxima (gestión) |
| **Game_Design_Agent** | Validar diseño contra DESIGN.MD | DESIGN.MD = ley absoluta |
| **Lead_Developer_Agent** | Implementar GDScript, arquitectura Godot | Decisiones técnicas |
| **QA_Agent** | Testing, rendimiento, regresión | Puede bloquear release |
| **Audio_Agent** | SFX, música, AudioManager | Audio direction |
| **VFX_Shader_Agent** | Shaders, partículas, post-process | Visual effects |
| **Asset_Pipeline_Agent** | Pipeline Blender→Godot, optimización | Asset standards |
| **Narrative_Level_Agent** | Historia, niveles, progresión | Narrativa (bajo DESIGN.MD) |

**Regla clave**: Game_Design_Agent tiene directiva inquebrantable de basar TODAS sus decisiones exclusivamente en DESIGN.MD. Si hay conflicto entre PRD y DESIGN.MD, el DESIGN.MD prevalece.

---

*TANT-R OVERRIDE · PRD v1.1 · Documento confidencial · Junio 2026*
