# Fuentes del Proyecto

## Fuentes disponibles

### 1. PressStart2P-Regular.ttf
- **Uso**: HUD, arcade, elementos retro
- **Tamaño base**: 16px
- **Recurso Godot**: `font_pressstart2p.tres`
- **Caracteres**: Latino (ASCII) + algunos símbolos
- **Fuente**: Google Fonts (OFL)

### 2. Montserrat-Bold.ttf
- **Uso**: UI moderna, menús, botones, títulos
- **Tamaño base**: 24px
- **Recurso Godot**: `font_montserrat_bold.tres`
- **Caracteres**: Latino extendido
- **Fuente**: Google Fonts (OFL)

### 3. NotoSansJP-Bold.ttf
- **Uso**: Textos en japonés (cuando i18n locale = "ja")
- **Tamaño base**: 24px
- **Recurso Godot**: `font_notosansjp_bold.tres`
- **Caracteres**: CJK (chino, japonés, coreano) + latino
- **Fuente**: Google Fonts (OFL)

## Cómo usar en Godot

### Asignar fuente a un Label (en el editor):
1. Selecciona el nodo `Label`
2. En el Inspector, ve a **Theme Overrides → Fonts**
3. Asigna el recurso `.tres` correspondiente:
   - Para HUD (arcade): `font_pressstart2p.tres`
   - Para UI (menus, botones): `font_montserrat_bold.tres`
   - Para texto japones: `font_notosansjp_bold.tres`

### Asignar fuente desde GDScript:
```gdscript
# Para PressStart2P (arcade)
label.add_theme_font_override("font", load("res://assets/fonts/font_pressstart2p.tres"))

# Para Montserrat (UI)
label.add_theme_font_override("font", load("res://assets/fonts/font_montserrat_bold.tres"))

# Para NotoSansJP (Japonés)
label.add_theme_font_override("font", load("res://assets/fonts/font_notosansjp_bold.tres"))
```

### Cambiar tamaño de fuente:
```gdscript
label.add_theme_font_size_override("font_size", 32)  # 32px
```

## Recomendaciones

- **PressStart2P**: Usa tamaños pequeños (14-20px) para mantener el estilo retro
- **Montserrat**: Versátil, funciona bien en 20-32px
- **NotoSansJP**: Necesita al menos 18px para ser legible en caracteres CJK

## Fallback para japonés

Si necesitas mezclar inglés y japonés en el mismo Label, considera:
1. Crear dos Labels separados (inglés con Montserrat, japonés con NotoSansJP)
2. O usar una fuente que soporte ambos (como Noto Sans Regular que tiene soporte multiidioma)

---

**Instaladas con S0-T10**
