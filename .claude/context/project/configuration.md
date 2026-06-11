# Configuration - Tant-R Override

> Godot project configuration | Last Updated: Jun 2026

## project.godot (Key Settings)

```ini
[application]
config/name="Tant-R Override"
run/main_scene="res://scenes/ui/MainMenu.tscn"

[autoload]
GameController="*res://autoloads/GameController.gd"
ScoreManager="*res://autoloads/ScoreManager.gd"
AudioManager="*res://autoloads/AudioManager.gd"
SaveManager="*res://autoloads/SaveManager.gd"
TransitionManager="*res://autoloads/TransitionManager.gd"

[display]
window/size/viewport_width=1080
window/size/viewport_height=1920
window/stretch/mode="canvas_items"
window/stretch/aspect="keep"
window/handheld/orientation="portrait"

[rendering]
renderer/rendering_method="forward_plus"
renderer/rendering_method.mobile="mobile"
```

## Export Presets

### Android
- Package: `com.tantrmodern.game`
- Min SDK: 29 (Android 10)
- Target SDK: 34
- Architecture: arm64-v8a (primary) + armeabi-v7a
- Keystore: `release.keystore` (NOT in repo, stored securely)

### iOS
- Bundle ID: `com.tantrmodern.game`
- Deployment Target: iOS 15.0
- Architectures: arm64
- Signing: Automatic (Xcode manages)

## Firebase Configuration

- Project: `tan-r-override`
- Services enabled: Analytics, Crashlytics, Realtime Database
- Config files (NOT in repo):
  - Android: `google-services.json`
  - iOS: `GoogleService-Info.plist`

## Audio Buses

```
Master (0dB)
+-- Music (-3dB default)
+-- SFX (0dB default)
+-- UI (-6dB default)
```

## Import Defaults

### 3D Models (.glb)
- generate_lods: true
- light_baking: static
- animation_fps: 24

### Textures (game assets)
- compress/mode: VRAM Compressed
- compress/format: ETC2
- mipmaps: true
- max size: 1024

### Textures (UI)
- compress/mode: Lossless
- mipmaps: false
- fix_alpha_border: true

## Git Configuration

### Branching Strategy
- `main` — production releases (protected)
- `develop` — integration branch
- `feature/{sprint}-{description}` — feature work
- `fix/{bug-id}` — bug fixes

### .gitignore (Godot)
```
.godot/
*.translation
export_presets.cfg
*.import
android/build/
```
