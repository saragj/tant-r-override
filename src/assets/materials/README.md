# Materiales del Proyecto

## Materiales disponibles

### 1. mat_toon_base.tres
- **Uso**: Base para modelos 3D con estilo chibi
- **Tipo**: StandardMaterial3D
- **Configuración**: Shading simple, color gris neutro
- **Renderer**: Mobile (compatible)
- **Aplicación**: Modelos de personajes, props genéricos

### 2. mat_neon_emissive.tres
- **Uso**: Elementos luminosos, neón, glow
- **Tipo**: StandardMaterial3D con emisión
- **Color base**: Cyan (#1AE8E8)
- **Emisión**: Cyan brillante, 2.0x multiplicador
- **Renderer**: Mobile (compatible)
- **Aplicación**: Elementos HUD, bordes brillantes, efectos especiales

### 3. mat_holographic.tres
- **Uso**: Ruleta holográfica, objetos especiales
- **Tipo**: StandardMaterial3D
- **Propiedades**: Semi-transparente (60%), metallic, emisivo
- **Color base**: Azul claro (#3399FF)
- **Emisión**: Azul brillante, 1.5x multiplicador
- **Metallicness**: 0.5 (reflectivo parcial)
- **Roughness**: 0.3 (superficie pulida)
- **Renderer**: Mobile (compatible)
- **Aplicación**: Ruleta de minijuegos, efectos de Lucky

### 4. mat_transparent.tres
- **Uso**: Efectos transparentes, partículas, fondos
- **Tipo**: StandardMaterial3D
- **Opacidad**: 50% (0.5 alpha)
- **Alpha scissor**: Habilitado para cortes precisos
- **Renderer**: Mobile (compatible)
- **Aplicación**: Efectos de transición, fondos semitransparentes

## Cómo usar en Godot

### Asignar material a un MeshInstance3D (en el editor):
1. Selecciona el nodo `MeshInstance3D`
2. En el Inspector, ve a **Material Override**
3. Asigna el recurso `.tres` correspondiente

### Asignar material desde GDScript:
```gdscript
# Para mat_toon_base
mesh_instance.set_surface_override_material(0, load("res://assets/materials/mat_toon_base.tres"))

# Para mat_neon_emissive
mesh_instance.set_surface_override_material(0, load("res://assets/materials/mat_neon_emissive.tres"))

# Para mat_holographic
mesh_instance.set_surface_override_material(0, load("res://assets/materials/mat_holographic.tres"))

# Para mat_transparent
mesh_instance.set_surface_override_material(0, load("res://assets/materials/mat_transparent.tres"))
```

## Notas importantes

- Todos los materiales están configurados para el **Mobile Renderer**
- La emisión funciona mejor si la escena tiene un WorldEnvironment adecuado
- Para modelos complejos, puede necesitarse un ShaderMaterial personalizado en lugar de StandardMaterial3D
- La transparencia en Mobile puede requerir ajustes en la profundidad de render

---

**Instalados con S0-T11**
