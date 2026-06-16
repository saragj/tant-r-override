# tant-r OVERRIDE — Plan de Tareas Detallado
> Basado en PRD v1.1 · Motor: Godot 4.x · GDScript · 3D Estilizado · iOS + Android
> Estilo Visual: DESIGN.MD (3D Chibi-High-Poly, Neo-Retro Pop)
> Pipeline: Blender 3.6+ → glTF 2.0 → Godot 4.x (Mobile Renderer)

---

## CÓMO USAR ESTE DOCUMENTO CON CLAUDE CODE
- Cada tarea tiene un ID único (ej. `S0-T01`)
- Las dependencias se indican con `→ depende de`
- Los bloques de código muestran la firma exacta esperada
- Marca cada tarea con `[x]` al completarla
- Al iniciar una sesión de Claude Code: pega el ID de la tarea y el contexto del bloque

---

## SPRINT 0 — Setup y Pipeline (Semanas 1–2)

### S0-SETUP · Entorno de desarrollo

- [x] **S0-T01** · Instalar Godot Engine 4.2 LTS
  - Descargar desde https://godotengine.org/download versión `4.2.x stable`
  - Elegir build: `Godot_v4.2-stable_mono` (con C# support, por si se necesita más adelante)
  - Instalar también `Godot Export Templates` desde Editor → Export → Download Templates
  - Verificar que lanza sin errores en macOS/Windows/Linux

- [x] **S0-T02** · Instalar herramientas auxiliares
  - Instalar `Blender 3.6+` (modelado 3D, export glTF) — herramienta principal de arte
  - Instalar `Aseprite` o `Figma` (UI sprites, texturas 2D opcionales)
  - Instalar `Android Studio` y configurar Android SDK (API level 29+)
  - Instalar `Xcode 15+` (solo macOS) para export iOS
  - Instalar `Git` y cliente gráfico (GitKraken o SourceTree)
  - Verificar pipeline: Blender export .glb → Godot importa correctamente

- [x] **S0-T03** · Actualizar repositorio GitHub
  - Nombre: `tant-r-override`
  - Visibilidad: privado
  - Añadir `.gitignore` para Godot (template oficial de GitHub)
  - Crear ramas: `main` (producción - ya está creada), `develop` (integración), `feature/*` (trabajo)
  - Configurar protección de rama `main`: require PR

- [x] **S0-T04** · Configurar CI/CD básico con GitHub Actions
  - Crear `.github/workflows/export.yml`
  - Job 1: export Android APK en cada push a `develop`
  - Job 2: run Godot unit tests (GUT framework)
  - Usar action: `firebelley/godot-export@v3`
  - Almacenar APK como artifact del workflow

---

### S0-STRUCT · Estructura del proyecto Godot

- [x] **S0-T05** · Actualizar proyecto Godot con estructura de carpetas
  ```
  res://
  ├── autoloads/
  │   ├── GameController.gd
  │   ├── ScoreManager.gd
  │   ├── AudioManager.gd
  │   ├── SaveManager.gd
  │   └── TransitionManager.gd
  ├── scenes/
  │   ├── ui/
  │   │   ├── MainMenu.tscn
  │   │   ├── ModeSelect.tscn
  │   │   ├── Roulette.tscn
  │   │   ├── MiniGameResult.tscn
  │   │   ├── PhaseResult.tscn
  │   │   ├── GameOver.tscn
  │   │   └── Leaderboard.tscn
  │   ├── minigames/
  │   │   ├── base/
  │   │   │   └── MiniGameBase.tscn
  │   │   ├── mg01_labyrinth/
  │   │   ├── mg02_freeze_timer/
  │   │   ├── mg03_animal_echo/
  │   │   ├── mg04_slot_hunter/
  │   │   ├── mg05_shadow_match/
  │   │   ├── mg06_odd_one_out/
  │   │   ├── mg07_tap_frenzy/
  │   │   ├── mg08_count_fast/
  │   │   ├── mg09_wire_connect/
  │   │   ├── mg10_mirror_draw/
  │   │   ├── mg11_safe_cracker/
  │   │   ├── mg12_pixel_hunt/
  │   │   ├── mg13_rush_dodge/
  │   │   ├── mg14_cube_stack/
  │   │   ├── mg15_light_sequence/
  │   │   ├── mg16_crowd_counter/
  │   │   ├── mg17_button_basher/
  │   │   ├── mg18_symbol_match/
  │   │   ├── mg19_balance_act/
  │   │   └── mg20_path_finder/
  │   ├── story/
  │   │   ├── PhaseIntro.tscn
  │   │   ├── BossEscape.tscn
  │   │   └── FinalCapture.tscn
  │   └── bonus/
  │       └── BalloonBurst.tscn
  ├── assets/
  │   ├── models/
  │   │   ├── characters/
  │   │   ├── props/
  │   │   ├── environments/
  │   │   └── minigames/
  │   ├── textures/
  │   │   ├── characters/
  │   │   ├── environments/
  │   │   └── ui/
  │   ├── materials/
  │   ├── animations/
  │   ├── audio/
  │   │   ├── sfx/
  │   │   └── music/
  │   ├── fonts/
  │   ├── shaders/
  │   └── ui_sprites/
  ├── scripts/
  │   ├── utils/
  │   └── resources/
  └── tests/
      ├── unit/
      ├── integration/
      ├── minigames/
      └── performance/
  ```

- [x] **S0-T06** · Configurar `project.godot`
  - `display/window/size/viewport_width = 1080`
  - `display/window/size/viewport_height = 1920`
  - `display/window/stretch/mode = "canvas_items"`
  - `display/window/stretch/aspect = "keep"`
  - `display/window/handheld/orientation = "portrait"`
  - Renderer: Forward+ (desarrollo), Mobile (release export)
  - Registrar todos los autoloads: `GameController`, `ScoreManager`, `AudioManager`, `SaveManager`, `TransitionManager`
  - Configurar environment: WorldEnvironment con tilt-shift DoF sutil
  - Configurar default import: meshes/generate_lods=true, textures compress ETC2

- [x] **S0-T07** · Configurar export presets
  - **Android**: package `com.tantrmodern.game`, min SDK 29, target SDK 34, firmar con keystore de debug
  - **iOS**: bundle ID `com.tantrmodern.game`, deployment target iOS 15.0
  - Verificar que ambos exports generan build sin errores (aunque esté vacío)

---

### S0-ASSETS · Pipeline de assets desde Blender + Stitch

- [x] **S0-T08** · Configurar pipeline Blender → Godot
  - Crear archivo de Blender template con settings de export correctos
  - Export settings: glTF 2.0 (.glb), +Y Up, Apply Modifiers, Include Animations
  - Verificar que un modelo test (.glb) importa correctamente en Godot
  - Configurar import defaults en Godot: generate_lods=true, compress ETC2
  - Documentar naming convention: {categoria}_{nombre}_{variante}.glb
  - Crear modelos placeholder para personajes (cubos con proporciones chibi)

- [ ] **S0-T09** · Exportar mockups UI desde Stitch
  - Conectar Stitch MCP en visual studio code
  - Exportar pantallas de UI como PNG referencia a `assets/ui_sprites/`
  - Estos sirven como REFERENCIA visual, no como assets finales
  - Los assets 3D finales se crean en Blender siguiendo DESIGN.MD
  - Naming convention para UI: `hud_{nombre}_{estado}.png` (ej. `hud_heart_full.png`)

- [ ] **S0-T10** · Instalar fuentes
  - Descargar de Google Fonts: `PressStart2P-Regular.ttf` (arcade, HUD)
  - Descargar: `Montserrat-Bold.ttf` (UI moderna, menus)
  - Colocar en `assets/fonts/`
  - Crear FontVariation resources en Godot con sizes base

- [ ] **S0-T11** · Crear materiales base de Godot (pipeline 3D)
  - `mat_toon_base.tres`: StandardMaterial3D con shading toon (o ShaderMaterial)
  - `mat_neon_emissive.tres`: material emisivo para elementos de neon/glow
  - `mat_holographic.tres`: material para la ruleta holografica (DESIGN.MD S3.2C)
  - `mat_transparent.tres`: material transparente para efectos
  - Verificar que todos renderizan correctamente en Mobile renderer

---

## SPRINT 1 — Core Engine + 3 Minijuegos (Semanas 3–4)

### S1-CORE · Sistema central

- [x] **S1-T01** · Implementar `GameController.gd` (autoload singleton)
  ```gdscript
  # Señales que debe emitir:
  signal minigame_completed(score: int, time_left: float)
  signal life_lost()
  signal life_gained()
  signal lucky_triggered(minigame_id: String)
  signal phase_completed(phase: int, total_score: int)
  signal game_over(final_score: int)

  # Variables de estado:
  var current_lives: int = 3
  var current_phase: int = 1
  var current_score: int = 0
  var combo_count: int = 0
  var lucky_fragments: int = 0
  var current_mode: String  # "story" | "endless" | "practice" | "multiplayer"
  var minigames_completed_in_phase: int = 0

  # Métodos requeridos:
  func start_game(mode: String) -> void
  func load_next_minigame() -> void
  func on_minigame_success(score: int, time_left: float) -> void
  func on_minigame_failure() -> void
  func get_difficulty_multiplier() -> float  # devuelve 1.0 / 0.8 / 0.6 según fase
  func get_score_multiplier() -> float       # speed bonus + combo
  ```
  → depende de: S0-T05, S0-T06

- [x] **S1-T02** · Implementar `ScoreManager.gd` (autoload)
  ```gdscript
  # Cálculo de puntuación:
  # base_score = 1000 (por minijuego completado)
  # speed_bonus: si time_left > 50% del tiempo total → x2
  # combo_bonus: 3 seguidos sin fallo → x1.5
  # final = base_score * speed_multiplier * combo_multiplier

  func calculate_score(base: int, time_left: float, total_time: float, combo: int) -> int
  func get_speed_multiplier(time_left: float, total_time: float) -> float
  func get_combo_multiplier(combo: int) -> float
  func add_score(points: int) -> void
  func get_total_score() -> int
  func reset() -> void
  ```
  → depende de: S1-T01

- [x] **S1-T03** · Implementar `SaveManager.gd` (autoload)
  ```gdscript
  # Estructura del save file (JSON en user://save.json):
  # {
  #   "high_scores": { "story": 0, "endless": 0 },
  #   "unlocked_minigames": ["mg01", "mg02", ...],
  #   "unlocked_skins": [],
  #   "lucky_fragments": 0,
  #   "stats": {
  #     "mg01": { "attempts": 0, "successes": 0, "best_time": 99.0 },
  #     ...
  #   },
  #   "settings": { "sfx_volume": 1.0, "music_volume": 1.0, "crt_effect": false }
  # }

  func save_game() -> void
  func load_game() -> Dictionary
  func update_minigame_stats(mg_id: String, success: bool, time: float) -> void
  func unlock_minigame(mg_id: String) -> void
  func save_high_score(mode: String, score: int) -> void
  func get_settings() -> Dictionary
  func update_settings(key: String, value) -> void
  ```
  → depende de: S0-T05

- [x] **S1-T04** · Implementar `AudioManager.gd` (autoload)
  ```gdscript
  # Buses de audio: Master, SFX, Music
  # SFX: latencia mínima, un AudioStreamPlayer por canal (pool de 8)
  # Music: loop, fade in/out entre escenas

  func play_sfx(sfx_name: String) -> void   # "success", "fail", "lucky", "tick", "combo"
  func play_music(track_name: String) -> void
  func stop_music(fade_time: float = 0.5) -> void
  func set_sfx_volume(value: float) -> void
  func set_music_volume(value: float) -> void
  # Precargar todos los AudioStream en _ready()
  ```
  → depende de: S0-T05

---

### S1-BASE · MiniGameBase

- [x] **S1-T05** · Crear escena `MiniGameBase.tscn`
  - Nodos: `CanvasLayer` (raíz) → `Control` (full viewport) → `VBoxContainer`
    - `InstructionPanel` (Label + Icon, visible 2s al inicio)
    - `TimerBar` (ProgressBar, muestra tiempo restante)
    - `GameArea` (Control, área de juego, 360×480px)
    - `HUD` (HBoxContainer): `LivesDisplay`, `ScoreDisplay`

- [x] **S1-T06** · Implementar `MiniGameBase.gd`
  ```gdscript
  class_name MiniGameBase
  extends CanvasLayer

  # Config que cada minijuego DEBE sobrescribir:
  @export var mg_id: String = ""
  @export var mg_name: String = ""
  @export var base_time: float = 20.0       # tiempo en segundos (fase 1)
  @export var instruction_text: String = ""
  @export var instruction_icon: Texture2D

  # Estado interno:
  var _time_remaining: float
  var _is_active: bool = false
  var _difficulty_multiplier: float = 1.0

  # Señales:
  signal completed(score: int, time_left: float)
  signal failed()

  # Ciclo de vida (llamar en este orden):
  func setup(difficulty_mult: float) -> void  # configura tiempo según dificultad
  func show_instructions() -> void            # muestra panel 2s, luego llama start()
  func start() -> void                        # activa input, arranca timer
  func _on_success() -> void                  # llama completed(), desactiva input
  func _on_failure() -> void                  # llama failed(), efecto visual error
  func _on_time_up() -> void                  # llama _on_failure()

  # Hook que cada minijuego implementa:
  func _setup_game() -> void                  # virtual, inicializar elementos
  func _start_game() -> void                  # virtual, activar mecánica
  func _cleanup() -> void                     # virtual, limpiar estado
  ```
  → depende de: S1-T01, S0-T05

- [x] **S1-T07** · Implementar `TimerBar` (componente reutilizable)
  - TimeBar: cuenta atrás visual en segundos que desciende de izquierda a derecha (o barra de progreso que merma)
  - Tiempo base por minijuego: configurado en `MiniGameBase.base_time` (ej: 20.0s)
  - Duración ajustada por dificultad: Fase 1 = base_time, Fase 2 = base_time × 0.9, Fase 3 = base_time × 0.8
  - Color: verde (>50% tiempo restante) → amarillo (25–50%) → rojo (<25%)
  - Animación de pulso cuando queda <25% del tiempo
  - Señal `timer_finished()`
  ```gdscript
  func start_timer(duration: float) -> void
  func pause_timer() -> void
  func get_time_remaining() -> float
  func get_progress_ratio() -> float  # 0.0 a 1.0
  ```
  → depende de: S1-T06

- [x] **S1-T08** · Implementar `LivesDisplay` (componente HUD)
  - 3 iconos de prisionero en pixel art (estilo chibi, traje naranja) — referencias visuales: parte inferior de `mg01_labyrinth_gameplay.png`
  - Estados: activo (prisionero de pie, colores vivos) / perdido (prisionero desvanecido/gris)
  - Animación de pérdida: prisionero cae o desaparece con partículas
  - Animación de ganancia: prisionero aparece con bounce
  ```gdscript
  func set_lives(count: int) -> void
  func set_fragments(count: int) -> void  # fragmentos Lucky (0, 1, 2, 3)
  func animate_lose_life() -> void
  func animate_gain_life() -> void
  ```
  → depende de: S0-T09, S1-T06

---

### S1-ROULETTE · Sistema de ruleta

- [x] **S1-T09** · Crear escena `Roulette.tscn`
  - **Referencia visual**: `screen_roulette.png` (mockup de Stitch con layout y estilo)
  - Nodos: `Control` (full screen) → `VBoxContainer`
    - `Title` (Label "NEXT GAME")
    - `SlotContainer` (HBoxContainer con 4 `SlotCard`)
    - `PressButton` (Button "TAP TO STOP!", pulsable)
    - `LuckyEffect` (partículas, oculto por defecto)

- [x] **S1-T10** · Implementar `Roulette.gd`
  ```gdscript
  # La ruleta muestra 4 cartas que rotan rápido (como slot machine)
  # El jugador toca para detenerla
  # Tras 1.5s de animación → emite selected(minigame_id)
  # 10% de probabilidad de "Lucky!" icon

  signal selected(minigame_id: String, is_lucky: bool)

  var _available_minigames: Array[String]  # IDs de minijuegos disponibles en esta fase
  var _spinning: bool = false
  var _spin_speed: float = 0.08            # segundos entre cambios (decrece al frenar)

  func start_spin(available: Array[String]) -> void
  func _on_stop_pressed() -> void
  func _animate_stop(selected_id: String) -> void
  func _trigger_lucky_effect() -> void
  ```
  → depende de: S1-T01, S0-T09

- [x] **S1-T11** · Implementar `SlotCard.gd` (componente de la ruleta)
  - Muestra icono + nombre del minijuego
  - Animación de scroll vertical (los iconos pasan por la tarjeta)
  - Efecto de glow cuando está seleccionada
  ```gdscript
  func set_content(mg_id: String, icon: Texture2D, label: String) -> void
  func animate_spinning(speed: float) -> void
  func animate_stop(final_mg_id: String) -> void
  func highlight() -> void
  ```
  → depende de: S0-T09

---

### S1-UI · Pantallas principales

- [x] **S1-T12** · Implementar `MainMenu.tscn` + `MainMenu.gd`
  - Elementos: logo animado "TANT-R", botones: PLAY, LEADERBOARD, SETTINGS
  - Animación de entrada: logo cae desde arriba con bounce
  - Fondo: detectives corriendo en loop (sprite animation)
  - Touch targets mínimo 44pt para todos los botones
  - Música de fondo en loop

- [x] **S1-T13** · Implementar `ModeSelect.tscn` + `ModeSelect.gd`
  - 4 botones modo: Historia 🕵️, Contrarreloj ⏱️, Práctica 🎮, Multijugador 👥
  - Modo Multijugador: selector de número de jugadores (2/3/4) con stepper
  - Descripción breve de cada modo al seleccionarlo
  - Botón Back

- [x] **S1-T14** · Implementar `MiniGameResult.tscn` + `MiniGameResult.gd`
  - Mostrar: SUCCESS / FAIL con animación
  - SUCCESS: score ganado + multiplicadores aplicados + combo actual
  - FAIL: vida perdida (animación corazón roto) + mensaje motivacional
  - Duración: 1.5s automático (sin necesidad de tap)
  - Transición: wipe horizontal hacia siguiente minijuego o ruleta

- [x] **S1-T15** · Implementar `GameOver.tscn` + `GameOver.gd`
  - Mostrar score final con animación de contador
  - Comparar con high score: si es nuevo record → celebración especial
  - Botones: RETRY, MENU, LEADERBOARD
  - Animación de detectives tristes/felices según resultado

---

### S1-MG · Minijuegos 01–03

- [x] **S1-T16** · Implementar **MG01 · Labyrinth Rush**
  - **Escena**: `mg01_labyrinth/LabyrinthRush.tscn`
  - **Mecánica**: deslizar dedo para mover al detective por un laberinto, el agua sube desde abajo
  - **Assets necesarios**: sprite detective (16×16px), tiles de laberinto, sprite agua
  - **Input**: `InputEventScreenDrag` → mover personaje en 4 direcciones (grid-based)
  - **Generación del laberinto**: algoritmo DFS (Depth-First Search) para asegurar solución en tiempo
  - **Dificultad**:
    - Fase 1: laberinto 7×9, agua sube lento
    - Fase 2: laberinto 9×11, agua +20% velocidad
    - Fase 3: laberinto 9×11 + paredes falsas
  - **Éxito**: detective llega a la salida (estrella en esquina superior)
  - **Fallo**: agua alcanza al detective O tiempo agotado
  - **Paleta de colores**: azul oscuro + cian + naranja (detective)
  ```gdscript
  # LabyrinthRush.gd hereda MiniGameBase
  func _setup_game() -> void   # genera laberinto con DFS
  func _start_game() -> void   # activa agua, activa input
  func _move_player(direction: Vector2i) -> void
  func _check_win_condition() -> void
  func _generate_maze(width: int, height: int) -> Array  # retorna grid 2D
  ```
  → depende de: S1-T06

- [ ] **S1-T17** · Implementar **MG02 · Freeze Timer**
  - **Escena**: `mg02_freeze_timer/FreezeTimer.tscn`
  - **Mecánica**: un cronómetro digital corre hacia 0. Tap para detenerlo exactamente en 0.0–0.3s
  - **Assets**: display digital 7-segmentos (sprite sheet), botón STOP grande
  - **Lógica**:
    - Cronómetro empieza en 10.0s y baja a 0
    - Zona de éxito: 0.0–0.3s (verde), 0.3–0.6s (naranja/parcial), >0.6s o negativo = fallo
    - El tiempo del cronómetro NO es el mismo que el TimerBar del minijuego
    - En fases 2/3: velocidad del cronómetro varía (acelerones aleatorios)
  - **Feedback**: pantalla congela visualmente + número detenido + "PERFECT!" / "CLOSE!" / "MISS!"
  - **Puntuación**: base + bonus según qué tan cerca de 0.0
  ```gdscript
  func _setup_game() -> void     # configura velocidad según dificultad
  func _on_stop_pressed() -> void
  func _calculate_accuracy(stopped_at: float) -> String  # "perfect"|"close"|"miss"
  ```
  → depende de: S1-T06

- [ ] **S1-T18** · Implementar **MG03 · Animal Echo**
  - **Escena**: `mg03_animal_echo/AnimalEcho.tscn`
  - **Mecánica**: se reproduce una secuencia de sonidos animales (3–5 sonidos), el jugador toca los animales en el mismo orden
  - **Assets**: sprites de 6 animales (gato, perro, pájaro, vaca, rana, mono) 32×32px
  - **Audio**: 6 SFX de sonidos animales (cargar en AudioManager)
  - **Lógica**:
    - Fase reproducción (no interactivo): animales se iluminan uno a uno al sonar
    - Fase respuesta (interactivo): jugador toca animales en orden
    - Secuencia: 3 sonidos en fase 1, 4 en fase 2, 5 en fase 3
    - Error inmediato si toca animal incorrecto
  - **UI**: indicadores de progreso (puntos: ●●●○○ = 3 de 5 correctos)
  ```gdscript
  var _sequence: Array[String]     # ej: ["cat", "dog", "bird"]
  var _player_input: Array[String]
  var _is_showing_sequence: bool

  func _generate_sequence(length: int) -> Array[String]
  func _play_sequence() -> void    # corutina: ilumina + sonido con delay
  func _on_animal_tapped(animal_id: String) -> void
  func _check_sequence() -> void
  ```
  → depende de: S1-T06, S1-T04

---

## SPRINT 2 — Minijuegos 04–09 + Feedback Visual (Semanas 5–6)

### S2-MG · Minijuegos 04–09

- [ ] **S2-T01** · Implementar **MG04 · Slot Hunter**
  - **Escena**: `mg04_slot_hunter/SlotHunter.tscn`
  - **Mecánica**: se muestra un patrón objetivo (3 símbolos), el jugador lo localiza en una cuadrícula de 6×8
  - **Assets**: 8 símbolos distintos de frutas/formas (sprites 24×24px)
  - **Lógica**:
    - Cuadrícula generada aleatoriamente con el patrón objetivo embebido
    - Tap en la celda correcta = éxito; tap incorrecto = fallo inmediato
    - Fase 1: patrón de 3 símbolos, cuadrícula 5×6
    - Fase 2: patrón de 3 con símbolos más parecidos, cuadrícula 6×7
    - Fase 3: patrón de 4 símbolos, cuadrícula 6×8, símbolos rotados ±15°
  ```gdscript
  func _generate_grid(pattern: Array, size: Vector2i) -> Array  # grid con patrón embebido
  func _on_cell_tapped(cell_pos: Vector2i) -> void
  func _check_match(cell_pos: Vector2i) -> bool
  ```
  → depende de: S1-T06

- [ ] **S2-T02** · Implementar **MG05 · Shadow Match**
  - **Escena**: `mg05_shadow_match/ShadowMatch.tscn`
  - **Mecánica**: mostrar una pieza y su sombra rotada. El jugador arrastra un slider para rotar la pieza hasta que coincida
  - **Assets**: 8 formas geométricas complejas (polígonos irregulares)
  - **Lógica**:
    - Sombra = pieza rotada X grados (X aleatorio: 45°, 90°, 135°, 180°, 225°, 270°, 315°)
    - Slider circular de 0–360° controla la rotación de la pieza
    - Zona de éxito: ±10° respecto al ángulo correcto
    - Fase 2/3: múltiples posibles rotaciones válidas se eliminan (solo 1 correcta)
  ```gdscript
  func _setup_shape(shape_id: int, target_angle: float) -> void
  func _on_slider_changed(value: float) -> void  # rota la pieza
  func _check_alignment() -> bool               # ±10° de tolerancia
  ```
  → depende de: S1-T06

- [ ] **S2-T03** · Implementar **MG06 · Odd One Out**
  - **Escena**: `mg06_odd_one_out/OddOneOut.tscn`
  - **Mecánica**: 9 elementos en cuadrícula 3×3, uno no pertenece al grupo. Tapearlo.
  - **Assets**: sets de objetos por categoría (frutas, animales, herramientas, colores)
  - **Lógica**:
    - Fase 1: diferencia obvia (color radicalmente distinto)
    - Fase 2: diferencia sutil (misma forma, tamaño diferente)
    - Fase 3: diferencia conceptual (8 herramientas + 1 fruta)
    - Tap correcto = éxito; tap incorrecto = fallo inmediato
  ```gdscript
  func _generate_puzzle(difficulty: int) -> Dictionary  # {items: Array, odd_index: int}
  func _on_item_tapped(index: int) -> void
  ```
  → depende de: S1-T06

- [ ] **S2-T04** · Implementar **MG07 · Tap Frenzy**
  - **Escena**: `mg07_tap_frenzy/TapFrenzy.tscn`
  - **Mecánica**: tap rápido sobre un botón grande para alcanzar número objetivo (ej: 20 taps en 10s)
  - **Assets**: botón grande con efecto de rebote, contador numérico grande
  - **Lógica**:
    - Contador sube con cada tap válido (anti-spam: 1 tap registrado cada 80ms mínimo)
    - Objetivo: Fase 1: 15 taps, Fase 2: 20 taps, Fase 3: 25 taps (mismo tiempo)
    - Barra de progreso visual hacia el objetivo
    - Efecto visual: botón se comprime/expande en cada tap
  ```gdscript
  var _tap_count: int = 0
  var _target_count: int = 15
  var _last_tap_time: float = 0.0
  const MIN_TAP_INTERVAL = 0.08  # 80ms anti-spam

  func _on_button_tapped() -> void
  func _check_win() -> void
  ```
  → depende de: S1-T06

- [ ] **S2-T05** · Implementar **MG08 · Count Fast**
  - **Escena**: `mg08_count_fast/CountFast.tscn`
  - **Mecánica**: objetos aparecen y desaparecen rápidamente. El jugador escribe (o selecciona) cuántos había
  - **Assets**: 3 tipos de objeto simple (estrella, círculo, triángulo)
  - **Lógica**:
    - Objetos aparecen durante 1.5s en posiciones aleatorias, luego desaparecen
    - Se muestran 4 opciones numéricas (A/B/C/D), solo una correcta
    - Fase 1: 5–8 objetos, 1 tipo
    - Fase 2: 8–12 objetos, 2 tipos (contar solo uno)
    - Fase 3: 10–15 objetos, 2 tipos que se solapan visualmente
  ```gdscript
  func _spawn_objects(count: int, types: Array) -> void
  func _hide_objects_after(delay: float) -> void   # corutina
  func _generate_options(correct: int) -> Array    # 4 opciones cercanas
  func _on_option_selected(value: int) -> void
  ```
  → depende de: S1-T06

- [ ] **S2-T06** · Implementar **MG09 · Wire Connect**
  - **Escena**: `mg09_wire_connect/WireConnect.tscn`
  - **Mecánica**: conectar cables del color correcto arrastrando desde punto A al punto B, sin cruces
  - **Assets**: terminales de cable (puntos de colores), sprite de cable (línea dibujable)
  - **Lógica**:
    - 3 pares de colores en fase 1, 4 en fase 2, 5 en fase 3
    - Dibujar cable: `InputEventScreenDrag` desde terminal inicio → detecta terminal destino
    - Validación: no se pueden cruzar cables (intersección de segmentos)
    - Todos los pares deben conectarse para ganar
    - Si se cruza: el cable nuevo se elimina (no el existente)
  ```gdscript
  func _on_drag_start(start_terminal: Node) -> void
  func _on_drag_end(end_terminal: Node) -> void
  func _draw_cable(from: Vector2, to: Vector2, color: Color) -> void
  func _check_intersection(new_cable: Line2D) -> bool
  func _check_all_connected() -> bool
  ```
  → depende de: S1-T06

---

### S2-FX · Feedback visual y audio

- [ ] **S2-T07** · Implementar sistema de screen shake
  ```gdscript
  # En GameController o como autoload ScreenFX:
  func screen_shake(intensity: float = 5.0, duration: float = 0.3) -> void
  # Usar Camera2D con offset animado (Tween)
  # intensity: píxeles de desplazamiento máximo
  # Al fallar un minijuego: shake(8.0, 0.4)
  # Al ganar: shake(3.0, 0.15) (shake suave positivo)
  ```
  → depende de: S1-T01

- [ ] **S2-T08** · Implementar flash de pantalla (success/fail)
  ```gdscript
  # ColorRect full-screen con alpha 0, anima a 0.6 y vuelve a 0
  func flash_success() -> void  # flash verde (Color.GREEN, alpha 0.4, 0.2s)
  func flash_fail() -> void     # flash rojo  (Color.RED,   alpha 0.6, 0.3s)
  func flash_lucky() -> void    # flash dorado (Color.GOLD,  alpha 0.5, 0.5s)
  ```
  → depende de: S1-T01

- [ ] **S2-T09** · Implementar sistema de partículas para Lucky!
  - `GPUParticles2D` con textura de estrella dorada
  - Burst de 50 partículas desde centro de pantalla
  - Duración: 1.5s
  - Llamar desde `GameController` al detectar Lucky
  → depende de: S1-T01

- [ ] **S2-T10** · Añadir SFX a todos los eventos core
  - Cargar en `AudioManager`: `success.ogg`, `fail.ogg`, `lucky.ogg`, `combo.ogg`, `tick.ogg`, `roulette_spin.ogg`, `roulette_stop.ogg`, `life_lost.ogg`, `life_gained.ogg`
  - Conectar señales de `GameController` a `AudioManager._play_event_sfx()`
  - Todos los SFX deben ser < 500ms de duración
  - Volumen master SFX por defecto: 0.8
  → depende de: S1-T04

- [ ] **S2-T11** · Implementar animación de combo
  - Label flotante "+COMBO x1.5!" que aparece en pantalla con animación
  - Usa `Tween`: escala 0→1.2→1.0, sube 30px, fade out en 1s
  - Color: amarillo dorado, borde negro
  ```gdscript
  func show_combo_label(multiplier: float, position: Vector2) -> void
  ```
  → depende de: S2-T07, S2-T08

- [ ] **S2-T12** · Implementar pantalla de resultado de minijuego mejorada
  - Mejorar `MiniGameResult.tscn` con:
    - Animación de score contando desde 0 hasta total (0.8s)
    - Mostrar multiplicadores como ecuación: `1000 × 2.0 × 1.5 = 3000`
    - Estrellas de valoración (1–3) según velocidad de completado
    - Si Lucky!: banner especial con animación dorada
  → depende de: S1-T14, S2-T08

---

## SPRINT 3 — Minijuegos 10–13 + Modo Historia (Semanas 7–8)

### S3-MG · Minijuegos 10–13

- [ ] **S3-T01** · Implementar **MG10 · Mirror Draw**
  - **Escena**: `mg10_mirror_draw/MirrorDraw.tscn`
  - **Mecánica**: pantalla dividida en 2 mitades. La izquierda tiene un dibujo parcial. El jugador completa la mitad derecha simétricamente con el dedo.
  - **Assets**: 6 dibujos parciales (caras, objetos simples) en pixel art
  - **Lógica**:
    - Se captura el trazo del jugador en `Image` (viewport texture)
    - Comparación pixel-a-pixel con la solución correcta (tolerancia de 3px)
    - Fase 1: tolerancia 5px, dibujos simples (líneas rectas)
    - Fase 2: tolerancia 3px, curvas
    - Fase 3: tolerancia 2px, dibujos complejos + línea central parpadeante
    - Barra de "similitud" actualizada en tiempo real mientras dibuja
  ```gdscript
  func _on_draw_input(event: InputEventScreenDrag) -> void
  func _calculate_similarity() -> float  # 0.0 a 1.0
  func _check_completion() -> void       # si similarity > 0.75 = éxito
  ```
  → depende de: S1-T06

- [ ] **S3-T02** · Implementar **MG11 · Safe Cracker**
  - **Escena**: `mg11_safe_cracker/SafeCracker.tscn`
  - **Mecánica**: un indicador oscila (como péndulo). El jugador debe mantenerlo dentro de la zona verde usando micro-taps
  - **Assets**: sprite de caja fuerte, indicador/aguja, zonas coloreadas
  - **Lógica**:
    - Indicador = física de péndulo simple: `angle += velocity * delta; velocity += -sin(angle) * damping`
    - Tap = aplica impulso en dirección opuesta a la velocidad actual
    - Zona verde: ±15° del centro
    - Debe mantenerse en zona verde durante 3s acumulados (no consecutivos)
    - Fase 2/3: oscilación más rápida + zona verde más estrecha (±10°, ±8°)
    - Indicador visual: barra de progreso "tiempo en zona verde"
  ```gdscript
  var _angle: float = PI / 4    # posición inicial
  var _velocity: float = 0.0
  var _time_in_zone: float = 0.0
  const REQUIRED_TIME = 3.0

  func _physics_process(delta: float) -> void   # actualiza péndulo
  func _on_tap() -> void                        # aplica impulso opuesto
  func _check_in_zone() -> bool
  ```
  → depende de: S1-T06

- [ ] **S3-T03** · Implementar **MG12 · Pixel Hunt**
  - **Escena**: `mg12_pixel_hunt/PixelHunt.tscn`
  - **Mecánica**: imagen pixelada (16×16 grid visible). Un pixel tiene color ligeramente diferente. Tapear ese pixel.
  - **Assets**: generado proceduralmente (no necesita sprites externos)
  - **Lógica**:
    - Generar imagen: fondo de color sólido + variaciones de ±5–20% en un pixel
    - Fase 1: diferencia de color 20%, grid 12×12
    - Fase 2: diferencia 10%, grid 16×16
    - Fase 3: diferencia 5%, grid 16×16, fondo con gradiente suave
    - Zoom: el jugador puede pellizcar para hacer zoom (máx 2x)
    - Tap en pixel incorrecto: fallo inmediato
  ```gdscript
  func _generate_pixel_grid(size: Vector2i, difficulty: int) -> Image
  func _find_odd_pixel_position() -> Vector2i
  func _on_pixel_tapped(grid_pos: Vector2i) -> void
  ```
  → depende de: S1-T06

- [ ] **S3-T04** · Implementar **MG13 · Rush Dodge** (bonus final)
  - **Escena**: `mg13_rush_dodge/RushDodge.tscn`
  - **Mecánica**: detective se mueve horizontalmente. Obstáculos caen desde arriba. Deslizar para esquivar.
  - **Assets**: sprite detective corriendo, sprites de obstáculos (3 tipos), fondo parallax
  - **Lógica**:
    - Scroll vertical automático del fondo
    - Input: `InputEventScreenDrag` horizontal → mueve detective
    - Obstáculos generados en carriles (5 carriles), spawn rate creciente
    - Duración: 30s (más largo que el resto)
    - Sin fallo por un golpe: 3 golpes antes de perder (barra de daño)
    - Puntuación por distancia + esquivas perfectas
    - Es el minijuego final del modo Historia (boss stage)
  ```gdscript
  func _spawn_obstacle() -> void
  func _on_swipe(direction: float) -> void  # -1.0 izq, +1.0 der
  func _check_collision() -> void
  func _update_scroll(delta: float) -> void
  ```
  → depende de: S1-T06

---

### S3-STORY · Modo Historia

- [ ] **S3-T05** · Definir mapa de fases del modo Historia
  ```
  Fase 1 (Ciudad):   MG06, MG02, MG07, MG01  + Bonus: BalloonBurst
  Fase 2 (Desierto): MG03, MG05, MG08, MG04, MG09  + Bonus: BalloonBurst
  Fase 3 (Casino):   MG10, MG11, MG12, MG13 (boss)
  ```
  - Crear `StoryConfig.gd` (Resource) con la secuencia de minijuegos por fase
  - El orden dentro de cada fase se decide por ruleta (de los disponibles en esa fase)

- [ ] **S3-T06** · Implementar escena `PhaseIntro.tscn`
  - Animación de 3s: detectives en vehículo viajando hacia nueva localización
  - Fondo de localización (ciudad/desierto/casino) en parallax
  - Texto: "FASE X — [NOMBRE_LUGAR]" con efecto typewriter
  - Sprites estáticos ok para v1 (animar si hay tiempo)

- [ ] **S3-T07** · Implementar escena `BossEscape.tscn`
  - Secuencia de 5s entre fases: el Boss escapa en globo aerostático
  - Detectives en biplanos persiguiendo (animación de sprite)
  - Transición a bonus stage (BalloonBurst)

- [ ] **S3-T08** · Implementar escena bonus `BalloonBurst.tscn`
  - **Mecánica**: globos flotan hacia arriba, tapearlosen para explotarlos. Esquivar misiles (swipe)
  - **Éxito**: explotar todos los globos = vida extra
  - **No hay fallo** en el bonus (solo te puedes quedar sin vida extra)
  - Duración: 15s
  ```gdscript
  func _spawn_balloon() -> void       # globo con velocidad aleatoria
  func _spawn_missile() -> void       # misil horizontal
  func _on_balloon_tapped(b: Node) -> void
  func _check_missile_hit() -> void
  ```
  → depende de: S1-T06 (hereda MiniGameBase parcialmente)

- [ ] **S3-T09** · Implementar escena `FinalCapture.tscn`
  - Secuencia final: detectives capturan al Boss
  - Animación de 5s (sprites)
  - Pantalla de victoria con score total
  - Créditos breves (scroll de texto)
  - Botón: "JUGAR DE NUEVO" / "MENÚ"

- [ ] **S3-T10** · Implementar `PhaseResult.tscn` + `PhaseResult.gd`
  - Score de la fase + total acumulado
  - Mejor racha de combos de la fase
  - Minijuego con mejor puntuación resaltado
  - Animación de transición a `PhaseIntro` de la siguiente fase

- [ ] **S3-T11** · Conectar flujo completo del modo Historia en `GameController.gd`
  - Método `start_story_mode()` que orquesta: PhaseIntro → Ruleta → MG → Result → (loop) → BossEscape → Bonus → PhaseResult → siguiente fase
  - State machine simple: `enum GameState { MENU, PHASE_INTRO, ROULETTE, MINIGAME, RESULT, BONUS, PHASE_END, FINAL }`
  - Transiciones con `SceneTree.change_scene_to_packed()` (escenas pre-cargadas)
  → depende de: S3-T05, S3-T06, S3-T07, S3-T08, S3-T09, S1-T01

---

## SPRINT 4 — Modos Secundarios (Semana 9)

- [ ] **S4-T01** · Implementar Modo Contrarreloj (Endless)
  - En `GameController.gd`: método `start_endless_mode()`
  - Pool de todos los minijuegos, selección aleatoria sin repetir hasta completar ciclo
  - Una sola vida
  - Dificultad: aumenta cada 5 rondas completadas (`difficulty_tier += 1`)
  - Score: acumula sin límite
  - Leaderboard local en `SaveManager` (top 10)
  → depende de: S1-T01, S1-T03

- [ ] **S4-T02** · Implementar Modo Práctica (Free Play)
  - Pantalla de selección: grid de los 13 minijuegos (bloqueados los no desbloqueados)
  - Al seleccionar: lanza el minijuego sin timer de vidas, sin presión
  - Post-partida: muestra estadísticas del jugador (intentos, éxitos, mejor tiempo)
  - Tutorial: primera vez que se accede a cada MG → overlay de instrucciones extendidas
  → depende de: S1-T01, S1-T03

- [ ] **S4-T03** · Implementar Modo Multijugador Local (Pass & Play)
  - En `ModeSelect`: selector de número de jugadores (2–4) + nombres opcionales
  - `MultiplayerManager.gd`: lleva cuenta de victorias por jugador
  - Flujo: Jugador 1 pasa el dispositivo → MG aleatorio → resultado → Jugador 2 → etc.
  - Pantalla de "pasa el teléfono a [NOMBRE]" entre turnos (5s de espera)
  - Final: podium con victorias de cada jugador
  ```gdscript
  # MultiplayerManager.gd
  var players: Array[Dictionary]  # [{name, score, wins}]
  var current_player_index: int
  var rounds_played: int
  const ROUNDS_TO_WIN = 10

  func next_player() -> void
  func record_win(player_index: int) -> void
  func get_winner() -> Dictionary
  ```
  → depende de: S1-T01, S1-T13

- [ ] **S4-T04** · Implementar `Leaderboard.tscn` + `Leaderboard.gd`
  - Tabs: LOCAL / GLOBAL (global solo si Firebase conectado)
  - Lista top 10 con: posición, nombre (editable), score, fecha
  - Animación de entrada de filas (slide desde derecha)
  - Si el score actual es top 10: resaltar con borde dorado
  → depende de: S1-T03

---

## SPRINT 5 — Polish Visual (Semana 10)

### S5-VISUAL · Efectos y animaciones finales

- [ ] **S5-T01** · Implementar shader CRT (efecto retro opcional)
  ```glsl
  // assets/shaders/crt_effect.gdshader
  // Efectos: scanlines horizontales, ligero vignette, leve distorsión barril
  // Activable desde Settings (off por defecto)
  uniform float scanline_intensity: hint_range(0.0, 1.0) = 0.3;
  uniform float vignette_intensity: hint_range(0.0, 1.0) = 0.4;
  uniform float barrel_distortion: hint_range(0.0, 0.1) = 0.02;
  ```
  → depende de: S0-T06

- [ ] **S5-T02** · Implementar transiciones entre escenas
  - `TransitionManager.gd` (autoload): gestiona wipes y fades
  - Tipos: `WIPE_LEFT`, `WIPE_RIGHT`, `FLASH_WHITE`, `FLASH_BLACK`, `FADE`
  - Duración estándar: 0.3s
  ```gdscript
  func transition_to(scene_path: String, type: TransitionType) -> void
  ```
  → depende de: S1-T01

- [ ] **S5-T03** · Añadir animaciones de personajes
  - Detective sprites: estados `idle`, `run`, `celebrate`, `sad`, `surprised`
  - Implementar en `AnimatedSprite2D` con `SpriteFrames`
  - Conectar al estado del juego: éxito → `celebrate`, fallo → `sad`, Lucky → `surprised`

- [ ] **S5-T04** · Implementar efectos de partículas por evento
  - Lucky!: estrellas doradas (ya en S2-T09), añadir confeti
  - Combo: explosión de colores (burst pequeño)
  - Game Over: papel de score cae (texto "GAME OVER" con efecto glitch)
  - Victory: fuegos artificiales (chispas de colores desde bordes)

- [ ] **S5-T05** · Implementar animaciones de UI
  - Botones: efecto press (scale 0.95 en tap, rebote a 1.0)
  - Score counter: digits individuales con animación de "slot" cuando cambian
  - Lives: pulso suave cuando quedan ≤ 1 vida
  - TimerBar: pulso rojo cuando < 25%

- [ ] **S5-T06** · Componer y añadir música
  - Tracks necesarios: `music_menu.ogg`, `music_phase1.ogg`, `music_phase2.ogg`, `music_phase3.ogg`, `music_endless.ogg`, `music_victory.ogg`
  - BPM rápido (140–160 BPM), estilo arcade chiptune
  - Loop seamless (sin click al hacer loop)
  - Implementar crossfade entre tracks en `AudioManager`
  - Fuentes recomendadas: OpenGameArt.org (licencia libre)

- [ ] **S5-T07** · Revisar y añadir SFX restantes
  - Por minijuego: cada MG necesita al menos 3 SFX propios (acción principal, éxito, fallo)
  - Lista completa:
    - MG01: splash_agua, paso_laberinto, salida_alcanzada
    - MG02: tick_reloj, freeze_stop, miss_beep
    - MG03: secuencia_reproduciendo (6 sonidos), secuencia_correcta, secuencia_incorrecta
    - MG04: grid_tap, found_it, wrong_tap
    - MG05: rotar_pieza (scrape), encajado, fallo_rotacion
    - MG06: tap_select, odd_correct, odd_wrong
    - MG07: tap_button (x), objetivo_alcanzado, tiempo_agotado
    - MG08: objetos_aparecen, seleccion_numero, correcto, incorrecto
    - MG09: cable_arrastrar, cable_conectado, cable_cruzado
    - MG10: lapiz_dibujar, simetria_ok, simetria_fail
    - MG11: pendulo_swing, zona_verde, zona_roja
    - MG12: zoom_in, pixel_encontrado, pixel_incorrecto
    - MG13: correr_loop, obstaculo_golpe, esquiva_perfecta

- [ ] **S5-T08** · Optimizar performance para mid-range
  - Reducir draw calls: usar `CanvasGroup` donde sea posible
  - Máx 50 nodos activos simultáneos en cualquier minijuego
  - Sprites: max 256×256px por sprite, usar atlas textures
  - Partículas: máx 100 simultáneas en pantalla
  - Ejecutar profiler Godot en Samsung A52 virtual (o dispositivo real)
  - Target: 60fps estables, < 150ms de carga de escena

---

## SPRINT 6 — Backend + QA (Semana 11)

### S6-BACKEND · Firebase

- [ ] **S6-T01** · Configurar proyecto Firebase
  - Crear proyecto en Firebase Console: `tantr-modern`
  - Habilitar: Analytics, Crashlytics, Realtime Database
  - Descargar `google-services.json` (Android) y `GoogleService-Info.plist` (iOS)
  - Integrar plugin Godot-Firebase: https://github.com/GodotNuts/GodotFirebase

- [ ] **S6-T02** · Implementar leaderboard global
  - Estructura Realtime DB:
    ```
    leaderboards/
      endless/
        {user_id}: { name, score, timestamp }
      story/
        {user_id}: { name, score, timestamp }
    ```
  - `LeaderboardService.gd`: métodos `submit_score()`, `get_top_10()`
  - Validación básica: score máximo posible = fases × minijuegos × 3000 (anti-cheat básico)
  - User ID: generado localmente (UUID v4), no requiere auth

- [ ] **S6-T03** · Implementar Analytics events
  ```gdscript
  # Eventos a trackear:
  Analytics.log_event("game_start", {mode: "story"})
  Analytics.log_event("minigame_start", {mg_id: "mg01", phase: 1})
  Analytics.log_event("minigame_complete", {mg_id: "mg01", score: 2000, time_left: 8.3})
  Analytics.log_event("minigame_fail", {mg_id: "mg01", reason: "timeout"})
  Analytics.log_event("mg_abandoned", {mg_id: "mg01"})   # <- KPI importante
  Analytics.log_event("life_lost", {phase: 1, mg_id: "mg01"})
  Analytics.log_event("game_over", {phase: 2, score: 5400})
  Analytics.log_event("story_complete", {score: 18000, time: 240})
  Analytics.log_event("iap_viewed", {pack: "skin_pack_1"})
  ```
  → depende de: S6-T01

- [ ] **S6-T04** · Implementar Crashlytics
  - Inicializar en `_ready()` del primer autoload
  - Configurar keys de contexto: `phase`, `current_mg`, `score` al crash
  - Test: forzar un crash en debug y verificar en Firebase Console

- [ ] **S6-T05** · Implementar IAP (In-App Purchases) — cosméticos
  - Plugin: `GodotGooglePlayBilling` (Android) + `GodotAppleInAppPurchases` (iOS)
  - Productos: `skin_pack_1` ($0.99), `skin_pack_2` ($0.99), `effects_pack` ($0.99)
  - `IAPManager.gd`: `purchase(product_id)`, `restore_purchases()`, `is_purchased(product_id)`
  - Guardar compras en `SaveManager` + validar con receipt en Firebase Functions

---

### S6-QA · Testing

- [ ] **S6-T06** · Instalar y configurar GUT (Godot Unit Testing)
  - https://github.com/bitwes/Gut
  - Directorio de tests: `res://tests/`
  - Configurar en CI/CD para correr en cada push

- [ ] **S6-T07** · Escribir tests unitarios para sistemas core
  ```gdscript
  # tests/test_score_manager.gd
  func test_speed_bonus_above_50_percent():
    assert_eq(ScoreManager.get_speed_multiplier(12.0, 20.0), 2.0)

  func test_speed_bonus_below_50_percent():
    assert_eq(ScoreManager.get_speed_multiplier(8.0, 20.0), 1.0)

  func test_combo_multiplier_at_3():
    assert_eq(ScoreManager.get_combo_multiplier(3), 1.5)

  # tests/test_game_controller.gd
  func test_life_lost_decrements_lives():
  func test_lucky_increments_fragments():
  func test_three_fragments_grant_life():
  func test_game_over_at_zero_lives():

  # tests/test_save_manager.gd
  func test_save_and_load_score():
  func test_unlock_minigame():
  func test_update_stats():
  ```
  → depende de: S6-T06, S1-T01, S1-T02, S1-T03

- [ ] **S6-T08** · Test de rendimiento en dispositivos objetivo
  - Instalar APK de debug en: Samsung Galaxy A52 (mid-range Android)
  - Instalar en iPhone 12 (iOS target mínimo)
  - Medir con Godot Remote Debugger:
    - FPS en cada minijuego (target: 60fps estables)
    - Tiempo de carga de escena (target: < 300ms)
    - RAM usage (target: < 200MB)
    - Temperatura del dispositivo tras 10 min de juego
  - Documentar resultados y crear issues para cualquier MG por debajo de 55fps

- [ ] **S6-T09** · Testing de input lag
  - Instalar app de medición de latencia táctil en cada dispositivo
  - Medir lag desde tap hasta respuesta visual en: MG02 (Freeze Timer), MG07 (Tap Frenzy), MG04 (Slot Hunter)
  - Target: < 50ms
  - Si > 50ms: revisar que el procesamiento de input esté en `_input()` no `_process()`

- [ ] **S6-T10** · Testing de regresión completo
  - Completar modo Historia de principio a fin (3 veces)
  - Completar 20 rondas de Contrarreloj
  - Probar cada minijuego en dificultad 1, 2 y 3
  - Probar Multijugador con 2 y 4 jugadores
  - Probar Settings: cambio de volumen, activar/desactivar CRT
  - Probar desde primera instalación (borrar datos)
  - Verificar que los saves persisten entre sesiones

- [ ] **S6-T11** · Testing de edge cases
  - Interrumpir app a mitad de minijuego (llamada entrante, home button)
  - Reanudar app: el minijuego debe reiniciarse limpiamente
  - Perder conexión a internet: el juego debe funcionar 100% offline
  - Dispositivo con batería baja (modo ahorro): verificar FPS
  - Pantallas con notch/punch-hole: verificar que UI no queda cortada

- [ ] **S6-T12** · Beta testing (TestFlight + Firebase App Distribution)
  - Subir build a TestFlight (iOS) y Firebase App Distribution (Android)
  - Invitar 10–20 beta testers
  - Recopilar feedback sobre: dificultad percibida, minijuego favorito/peor, bugs encontrados
  - Ajustar dificultad según datos de Analytics (mg_abandoned rate)

---

## SPRINT 7 — Release (Semana 12)

### S7-STORE · Preparación para stores

- [ ] **S7-T01** · Crear assets de store (App Store + Google Play)
  - Icon de app: 1024×1024px, sin esquinas redondeadas (el sistema las añade)
  - Screenshots iPhone: 6.5" (1284×2778px) — 5 mínimo, 10 recomendado
  - Screenshots Android: 16:9 y 9:16 — mínimo 2
  - Feature graphic Android: 1024×500px
  - Contenido de screenshots: mostrar ruleta, 3 minijuegos distintos, modo multijugador, leaderboard

- [ ] **S7-T02** · Redactar descripción para stores
  - Título: "Tant-R Override: Mini Arcade"
  - Subtítulo (iOS): "13 minijuegos · Arcade clásico"
  - Descripción corta (Google): máx 80 caracteres
  - Descripción larga: 4000 chars, incluir keywords: minijuego, arcade, puzzle, retro, familia
  - Keywords (iOS App Store): minijuego, arcade, puzzle, retro, reflejos, rápido, familia
  - Rating: Everyone / PEGI 3

- [ ] **S7-T03** · Crear tráiler de 30 segundos
  - Estructura: 0–5s logo + música, 5–25s gameplay de 4–5 minijuegos distintos, 25–30s CTA "disponible en App Store y Google Play"
  - Grabar con `adb screenrecord` (Android) o QuickTime (iOS)
  - Resolución: 1080×1920px (portrait)
  - Formato: MP4 H.264

- [ ] **S7-T04** · Build de producción Android
  - Firmar con keystore de producción (guardar en lugar seguro, NO en repositorio)
  - Target SDK: 34, min SDK: 29
  - Build type: release (no debug)
  - Activar R8/ProGuard si aplica
  - Verificar con `bundletool` que el AAB es válido

- [ ] **S7-T05** · Build de producción iOS
  - Certificados de distribución en Apple Developer Console
  - Provisioning profile: App Store Distribution
  - Activar Bitcode: No (no compatible con Godot exports)
  - Archivar y validar en Xcode Organizer
  - Subir a App Store Connect

- [ ] **S7-T06** · Submission App Store (iOS)
  - Rellenar información en App Store Connect: categoría (Games > Puzzle), edad, precio
  - Añadir NSAppTransportSecurity si Firebase lo requiere
  - Responder preguntas de privacidad (data collection)
  - Submit for review

- [ ] **S7-T07** · Submission Google Play (Android)
  - Crear app en Google Play Console
  - Configurar content rating questionnaire
  - Subir AAB firmado a internal testing → closed testing → production
  - Rellenar política de privacidad (URL requerida)
  - Submit for review

---

## BACKLOG v1.1 (post-launch)

> Estas tareas están fuera del scope de v1.0 pero documentadas para evitar scope creep

- [ ] **V11-T01** · Añadir minijuegos 14–20 (completar los 20 originales)
- [ ] **V11-T02** · Modo online multiplayer (2 jugadores en red)
- [ ] **V11-T03** · Sistema de logros (15 achievements)
- [ ] **V11-T04** · Modo diario: 5 minijuegos fijos, un solo intento por día
- [ ] **V11-T05** · Localización: inglés, japonés, francés
- [ ] **V11-T06** · Skins adicionales (packs de $0.99)
- [ ] **V11-T07** · Integración Game Center (iOS) y Google Play Games
- [ ] **V11-T08** · Modo accesibilidad: alto contraste, texto grande, haptic feedback
- [ ] **V11-T09** · iPad support (layout adaptado a pantalla grande)
- [ ] **V11-T10** · Animaciones cinemáticas completas para historia

---

## RESUMEN DE TAREAS POR SPRINT

| Sprint | Semanas | Tareas | Entregable verificable |
|--------|---------|--------|------------------------|
| S0 · Setup | 1–2 | S0-T01 → S0-T10 (10 tareas) | APK vacío exportando + assets Stitch importados |
| S1 · Core | 3–4 | S1-T01 → S1-T18 (18 tareas) | MG01+02+03 jugables, ruleta funcional, sistema de vidas |
| S2 · MG 04–09 | 5–6 | S2-T01 → S2-T12 (12 tareas) | 9 minijuegos totales, feedback visual/audio completo |
| S3 · Historia | 7–8 | S3-T01 → S3-T11 (11 tareas) | Modo Historia jugable de inicio a fin |
| S4 · Modos | 9 | S4-T01 → S4-T04 (4 tareas) | Endless, Práctica y Multijugador local funcionales |
| S5 · Polish | 10 | S5-T01 → S5-T08 (8 tareas) | Shaders, música, SFX, 60fps en mid-range |
| S6 · QA | 11 | S6-T01 → S6-T12 (12 tareas) | Firebase integrado, 0 crashes, beta testing |
| S7 · Release | 12 | S7-T01 → S7-T07 (7 tareas) | App en App Store + Google Play |
| **TOTAL** | **12 sem** | **82 tareas** | |

---

## CONVENCIONES PARA CLAUDE CODE

### Al crear una nueva tarea, proporciona este contexto:
```
Tarea: [ID] — [Nombre]
Sprint: [S0–S7]
Depende de: [IDs]
Archivo(s) a crear/modificar: [rutas]
Contexto del PRD: [sección relevante]
```

### Estructura de commits:
```
feat(s1): implement GameController singleton [S1-T01]
feat(mg01): labyrinth rush minigame core [S1-T16]
fix(roulette): lucky icon probability off by one [S1-T10]
test(score): add speed bonus unit tests [S6-T07]
chore(s0): setup project structure and export presets [S0-T05]
```

### Orden recomendado de implementación dentro de cada sprint:
1. Primero las tareas `CORE` / `BASE` (sin dependencias)
2. Luego los sistemas que otros necesitan
3. Los minijuegos en paralelo (son independientes entre sí)
4. Los tests al final de cada sprint
