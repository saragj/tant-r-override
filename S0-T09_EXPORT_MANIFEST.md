# S0-T09 · Exportar Mockups UI desde Stitch

## Pantallas finalizadas para exportar

Estas son las pantallas LISTAS para exportar de Stitch. Exporta como PNG a los directorios indicados:

### 1. Start Menu (Main Menu Screen)
**Pantalla Stitch**: `start-remaster`  
**Archivo destino**: `assets/ui_sprites/screens/screen_main_menu.png`  
**Propósito**: Referencia visual para MainMenu.tscn  
**Notas**: Logo animado "TANT-R", botones PLAY, LEADERBOARD, SETTINGS

---

### 2. Game Over Screen
**Pantalla Stitch**: `game-over-remaster`  
**Archivo destino**: `assets/ui_sprites/screens/screen_game_over.png`  
**Propósito**: Referencia visual para GameOver.tscn  
**Notas**: Score final, comparación high score, botones RETRY/MENU/LEADERBOARD

---

### 3. Roulette Selection Page
**Pantalla Stitch**: `roulette-game`  
**Archivo destino**: `assets/ui_sprites/roulette/screen_roulette.png`  
**Propósito**: Referencia para Roulette.tscn (slot machine de minijuegos)  
**Notas**: 4 SlotCards girando, botón "TAP TO STOP!"

---

### 4. Bonus Game Selection
**Pantalla Stitch**: `bonus-game`  
**Archivo destino**: `assets/ui_sprites/screens/screen_bonus_select.png`  
**Propósito**: Referencia para BalloonBurst intro  
**Notas**: Selección visual del bonus game

---

### 5. Minigame 1: Labyrinth Rush
**Pantalla Stitch**: `Minigame: Labyrinth Rush`  
**Archivo destino**: `assets/ui_sprites/minigames/mg01_labyrinth_gameplay.png`  
**Propósito**: Referencia para LabyrinthRush.tscn  
**Notas**: Detective en laberinto, agua subiendo, barra de tiempo, HUD de vidas/score

---

### 6. Minigame 2: Freeze Timer
**Pantalla Stitch**: `Minigame: Freeze Timer`  
**Archivo destino**: `assets/ui_sprites/minigames/mg02_freeze_timer_gameplay.png`  
**Propósito**: Referencia para FreezeTimer.tscn  
**Notas**: Display digital 7-segmentos, botón STOP grande, cronómetro contando hacia 0

---

### 7. Minigame 3: Animal Echo
**Pantalla Stitch**: `Minigame: Animal Echo`  
**Archivo destino**: `assets/ui_sprites/minigames/mg03_animal_echo_gameplay.png`  
**Propósito**: Referencia para AnimalEcho.tscn  
**Notas**: 6 animales (gato, perro, pájaro, vaca, rana, mono), indicador de progreso (●●●○○)

---

## Instrucciones de exportación

### Desde tu VS Code local con Stitch MCP:

1. Abre cada pantalla en Stitch
2. Usa el comando Stitch MCP para exportar como PNG:
   ```
   /stitch export [nombre-pantalla] [ruta-destino]
   ```
   Ej:
   ```
   /stitch export "start-remaster" "assets/ui_sprites/screens/screen_main_menu.png"
   ```

3. **IMPORTANTE**: Antes de exportar, confirma conmigo que los PNGs son FINALES (como mencionaste)
4. Una vez exportados, haz commit con:
   ```
   git add assets/ui_sprites/
   git commit -m "feat(s0): export UI mockups from Stitch [S0-T09]"
   git push -u origin claude/nifty-newton-32lrd7
   ```

---

## Checklist de validación

- [ ] Todos los PNGs están en sus carpetas correspondientes
- [ ] Los nombres de archivo siguen la convención: `screen_*` o `mg*`
- [ ] Las imágenes son referencias (mockups), no assets finales
- [ ] Los PNGs están listos para git add (no son WIP)
- [ ] Commit pusheado a rama `claude/nifty-newton-32lrd7`

---

## Próximo paso después de S0-T09

Una vez exportados los PNGs aquí, los minijuegos 01–03 usan estas referencias en **S1-T16, S1-T17, S1-T18** para definir la estructura visual de las escenas.

