# Sistema de Internacionalización (i18n)

## Overview

El sistema i18n está configurado para soportar **3 idiomas**:
- **en** (English) - idioma por defecto
- **es** (Español)
- **ja** (日本語)

## Estructura

```
assets/i18n/
├── en.json
├── es.json
├── ja.json
└── README.md (este archivo)
```

Cada archivo JSON contiene pares clave-valor:
```json
{
  "ui.menu.play": "PLAY",
  "mg01.name": "LABYRINTH RUSH",
  ...
}
```

## Uso en GDScript

### Traducir texto
Usa la función global `tr()` con la clave de traducción:

```gdscript
label.text = tr("ui.menu.play")  # "PLAY" en EN, "JUGAR" en ES, "プレイ" en JA
```

### Cambiar idioma en tiempo de ejecución
```gdscript
I18nManager.set_locale("es")  # Cambiar a español
I18nManager.set_locale("ja")  # Cambiar a japonés
I18nManager.set_locale("en")  # Cambiar a inglés
```

### Obtener el idioma actual
```gdscript
var current = I18nManager.get_current_locale()  # devuelve "en", "es" o "ja"
```

### Obtener idiomas disponibles
```gdscript
var locales = I18nManager.get_available_locales()  # ["en", "es", "ja"]
```

## Convenciones de claves

Las claves siguen este patrón:
```
{scope}.{screen/minigame}.{element}
```

### Ejemplos:
- `ui.menu.play` — botón PLAY en el menú principal
- `ui.roulette.title` — título de la ruleta
- `mg01.name` — nombre del minijuego 01
- `phase.1.name` — nombre de la fase 1

Todos en **minúsculas con puntos** como separadores.

## Cómo añadir nuevas claves

Cuando implementes una nueva pantalla o minijuego con texto visible:

1. **Añade la clave a los 3 JSON** (en.json, es.json, ja.json)
2. **Usa `tr(clave)` en el GDScript**, nunca strings literales
3. **Nunca hardcodees texto visible en `Label` nodes** — usa GDScript para asignar el valor traducido

### Ejemplo:
```gdscript
# ❌ INCORRECTO
label.text = "Success!"

# ✅ CORRECTO
label.text = tr("ui.result.success")  # "SUCCESS!" en EN, "¡ÉXITO!" en ES, etc.
```

## Soporte de fuentes

- **EN / ES**: Usa `PressStart2P` o `Montserrat` (incluye caracteres latinos)
- **JA**: Usa `NotoSansJP` o similar (incluye caracteres CJK)

Si usas una fuente personalizada para JA, configúrala en el nodo `Label` o crea una `FontVariation` específica.

## Testing

Cambia el idioma en settings y verifica que todo el texto se traduce correctamente:

```gdscript
# En _ready() de cualquier nodo:
I18nManager.set_locale("es")
```

---

**Última actualización**: S0-T12 · Implementado sistema de i18n EN/ES/JP
