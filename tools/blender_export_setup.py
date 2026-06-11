"""
tant-r OVERRIDE — Blender Export Setup Script
Run this in Blender's Script Editor (Scripting workspace) to export the active
collection with the correct settings for Godot 4.x.

Usage:
  1. Open Blender, go to Scripting workspace.
  2. Open this file and click Run Script.
  3. A .glb will be saved next to the .blend file (or in OUTPUT_DIR if set).

Naming convention: {category}_{name}_{variant}.glb
  Categories: char | prop | env | mg
  Example: char_detective_default.glb
"""

import bpy
import os

# ── Configuration ────────────────────────────────────────────────────────────

# Output directory relative to the .blend file, or set an absolute path.
OUTPUT_DIR = ""   # e.g. "/path/to/tant-r-override/src/assets/models/characters"

# Name of the exported file (no extension). Follows naming convention.
EXPORT_NAME = "char_placeholder_v0"

# ── Export Settings (do not edit below unless you know what you're doing) ────

EXPORT_SETTINGS = dict(
    # Format
    export_format="GLB",          # Binary glTF — single file, no external bins
    export_image_format="NONE",   # Textures are separate, not embedded in .glb

    # Transform (Godot uses +Y up, Blender uses +Z up)
    export_yup=True,

    # Geometry
    export_apply=True,            # Apply modifiers before export
    export_normals=True,
    export_tangents=True,         # Required for normal maps in Godot
    export_colors=True,
    export_texcoords=True,

    # Materials
    export_materials="EXPORT",    # Export PBR materials

    # Animation
    export_animations=True,
    export_frame_range=True,      # Use scene frame range
    export_nla_strips=True,
    export_def_bones=False,       # Don't export deform-only bones
    export_optimize_animation_size=True,
    export_anim_single_armature=True,

    # Compression — Godot handles VRAM compression, disable Draco
    export_draco_mesh_compression_enable=False,

    # Selection — export everything visible
    use_selection=False,
    use_visible=True,
    use_renderable=False,
    use_active_collection=True,

    # Extras
    export_extras=False,
    export_cameras=False,
    export_lights=False,
)


def run_export():
    blend_path = bpy.data.filepath
    if not blend_path:
        raise RuntimeError("Save the .blend file first before exporting.")

    if OUTPUT_DIR:
        out_dir = OUTPUT_DIR
    else:
        out_dir = os.path.dirname(blend_path)

    os.makedirs(out_dir, exist_ok=True)
    out_path = os.path.join(out_dir, EXPORT_NAME + ".glb")

    bpy.ops.export_scene.gltf(filepath=out_path, **EXPORT_SETTINGS)
    print(f"[tant-r] Exported: {out_path}")


if __name__ == "__main__":
    run_export()
