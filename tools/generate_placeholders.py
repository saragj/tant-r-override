#!/usr/bin/env python3
"""
Generate placeholder .glb files for tant-r-override.
Produces chibi-proportioned cube meshes without needing Blender.
Run: python3 tools/generate_placeholders.py
"""

import struct
import json
import os
import math

BASE_DIR = os.path.join(os.path.dirname(__file__), "..", "src", "assets", "models")

DIRS = [
    os.path.join(BASE_DIR, "characters"),
    os.path.join(BASE_DIR, "props"),
    os.path.join(BASE_DIR, "environments"),
    os.path.join(BASE_DIR, "minigames"),
]

for d in DIRS:
    os.makedirs(d, exist_ok=True)


def box_mesh(sx, sy, sz, ox=0.0, oy=0.0, oz=0.0):
    """Return (positions, normals, indices) for a box centered at (ox, oy, oz)."""
    hx, hy, hz = sx / 2, sy / 2, sz / 2
    # 8 unique corners
    verts = [
        (ox - hx, oy - hy, oz - hz), (ox + hx, oy - hy, oz - hz),
        (ox + hx, oy + hy, oz - hz), (ox - hx, oy + hy, oz - hz),
        (ox - hx, oy - hy, oz + hz), (ox + hx, oy - hy, oz + hz),
        (ox + hx, oy + hy, oz + hz), (ox - hx, oy + hy, oz + hz),
    ]
    # 6 faces, each split into 2 triangles (CCW winding)
    faces = [
        (0, 1, 2, 3),  # -Z
        (5, 4, 7, 6),  # +Z
        (4, 0, 3, 7),  # -X
        (1, 5, 6, 2),  # +X
        (4, 5, 1, 0),  # -Y
        (3, 2, 6, 7),  # +Y
    ]
    face_normals = [
        (0, 0, -1), (0, 0, 1), (-1, 0, 0), (1, 0, 0), (0, -1, 0), (0, 1, 0),
    ]
    positions = []
    normals = []
    indices = []
    vi = 0
    for face, normal in zip(faces, face_normals):
        a, b, c, d = face
        for v in (a, b, c, d):
            positions.append(verts[v])
            normals.append(normal)
        indices += [vi, vi + 1, vi + 2, vi, vi + 2, vi + 3]
        vi += 4
    return positions, normals, indices


def merge_meshes(mesh_list):
    """Merge multiple (positions, normals, indices) tuples into one."""
    all_pos, all_nrm, all_idx = [], [], []
    offset = 0
    for pos, nrm, idx in mesh_list:
        all_pos.extend(pos)
        all_nrm.extend(nrm)
        all_idx.extend(i + offset for i in idx)
        offset += len(pos)
    return all_pos, all_nrm, all_idx


def pack_vec3_list(vecs):
    buf = b""
    for v in vecs:
        buf += struct.pack("<fff", *v)
    return buf


def pack_u16_list(indices):
    buf = b""
    for i in indices:
        buf += struct.pack("<H", i)
    return buf


def build_glb(meshes):
    """
    Build a minimal valid GLB (glTF 2.0 binary) from merged meshes.
    meshes: list of (positions, normals, indices)
    """
    positions, normals, indices = merge_meshes(meshes)

    pos_buf = pack_vec3_list(positions)
    nrm_buf = pack_vec3_list(normals)
    idx_buf = pack_u16_list(indices)

    # Pad each buffer view to 4-byte alignment
    def pad4(b):
        r = len(b) % 4
        return b + b"\x00" * ((4 - r) % 4)

    pos_buf_p = pad4(pos_buf)
    nrm_buf_p = pad4(nrm_buf)
    idx_buf_p = pad4(idx_buf)

    bv0_off = 0
    bv0_len = len(pos_buf)
    bv1_off = len(pos_buf_p)
    bv1_len = len(nrm_buf)
    bv2_off = bv1_off + len(nrm_buf_p)
    bv2_len = len(idx_buf)
    total_bin = len(pos_buf_p) + len(nrm_buf_p) + len(idx_buf_p)

    # Bounding box for positions
    min_pos = [min(v[i] for v in positions) for i in range(3)]
    max_pos = [max(v[i] for v in positions) for i in range(3)]

    gltf = {
        "asset": {"version": "2.0", "generator": "tant-r generate_placeholders.py"},
        "scene": 0,
        "scenes": [{"nodes": [0]}],
        "nodes": [{"mesh": 0, "name": "Placeholder"}],
        "meshes": [{
            "name": "PlaceholderMesh",
            "primitives": [{
                "attributes": {"POSITION": 0, "NORMAL": 1},
                "indices": 2,
                "mode": 4,
            }]
        }],
        "accessors": [
            {
                "bufferView": 0, "componentType": 5126, "count": len(positions),
                "type": "VEC3", "min": min_pos, "max": max_pos,
            },
            {
                "bufferView": 1, "componentType": 5126, "count": len(normals),
                "type": "VEC3",
            },
            {
                "bufferView": 2, "componentType": 5123, "count": len(indices),
                "type": "SCALAR",
            },
        ],
        "bufferViews": [
            {"buffer": 0, "byteOffset": bv0_off, "byteLength": bv0_len, "target": 34962},
            {"buffer": 0, "byteOffset": bv1_off, "byteLength": bv1_len, "target": 34962},
            {"buffer": 0, "byteOffset": bv2_off, "byteLength": bv2_len, "target": 34963},
        ],
        "buffers": [{"byteLength": total_bin}],
    }

    json_bytes = json.dumps(gltf, separators=(",", ":")).encode("utf-8")
    # JSON chunk must be padded to 4 bytes with spaces
    r = len(json_bytes) % 4
    if r:
        json_bytes += b" " * (4 - r)

    bin_chunk = pos_buf_p + nrm_buf_p + idx_buf_p

    json_chunk_len = len(json_bytes)
    bin_chunk_len = len(bin_chunk)

    total_length = 12 + 8 + json_chunk_len + 8 + bin_chunk_len

    header = struct.pack("<III", 0x46546C67, 2, total_length)
    json_header = struct.pack("<II", json_chunk_len, 0x4E4F534A)  # JSON
    bin_header = struct.pack("<II", bin_chunk_len, 0x004E4942)    # BIN

    return header + json_header + json_bytes + bin_header + bin_chunk


PLACEHOLDERS = [
    {
        "path": os.path.join(BASE_DIR, "characters", "char_detective_base_v0.glb"),
        "meshes": [
            box_mesh(0.4, 0.8, 0.4, 0.0, 0.4, 0.0),   # body
            box_mesh(0.35, 0.35, 0.35, 0.0, 1.025, 0.0),  # head (chibi large head)
        ],
    },
    {
        "path": os.path.join(BASE_DIR, "characters", "char_boss_base_v0.glb"),
        "meshes": [
            box_mesh(0.5, 0.75, 0.5, 0.0, 0.375, 0.0),
            box_mesh(0.4, 0.4, 0.4, 0.0, 0.95, 0.0),
        ],
    },
    {
        "path": os.path.join(BASE_DIR, "props", "prop_heart_container_v0.glb"),
        "meshes": [
            box_mesh(0.3, 0.3, 0.3),
        ],
    },
    {
        "path": os.path.join(BASE_DIR, "environments", "env_platform_base_v0.glb"),
        "meshes": [
            box_mesh(2.0, 0.1, 2.0),
        ],
    },
]

for p in PLACEHOLDERS:
    glb = build_glb(p["meshes"])
    with open(p["path"], "wb") as f:
        f.write(glb)
    print(f"Created: {os.path.relpath(p['path'])}")

print("Done. All placeholder models generated.")
