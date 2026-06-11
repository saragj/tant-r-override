<!-- Context: project-intelligence/business | Priority: high | Version: 1.0 | Updated: 2026-06-11 -->

# Business Domain - Tant-R Override

**Purpose**: Game design context, market positioning, and product strategy.
**Last Updated**: 2026-06-11

## Product Summary

| Field | Value |
|-------|-------|
| Project | Tant-R Override |
| Type | Arcade Mobile - Minigames Collection |
| Platforms | iOS 15+ / Android 10+ |
| Engine | Godot Engine 4.x |
| Inspiration | Puzzle & Action: Tant-R (Sega, 1993) |
| Art Style | 3D Stylized / Chibi-High-Poly (per DESIGN.MD) |
| Minigames | 20 unique minigames across 5 categories |
| Game Modes | Story (4 worlds), Endless, Practice, Local Multiplayer |
| Monetization | Premium ($2.99-$4.99) + cosmetic IAP |
| Target Session | 2-5 minutes per session |

## Core Concept

Reimagining of Sega's 1993 arcade classic. Players solve timed minigames in rapid
succession to catch an escaped criminal. The pitch: rhythmic tension through ultra-short
gameplay bursts with modern 3D visuals.

## Design Authority

**DESIGN.MD is the absolute source of truth** for all game design decisions:
- Visual style: 3D Stylized, Fall Guys / Luigi's Mansion 3 aesthetic
- Narrative: Two detectives (Holmes/Watson inspired) vs. "The Boss"
- Structure: 4 arcade worlds + multiplayer highway
- Mechanics: Roulette selection, 20 minigames, 5 categories
- Tone: Absurd humor, 90s culture references, neo-retro pop

## Target Users

| Nostalgic (25-40) | Casual Mobile (18-35) | Competitive Gamer (16-28) |
|---|---|---|
| Knows original Tant-R | Quick play sessions | Leaderboard driven |
| Values retro-modern aesthetic | Plays during commute | Masters all minigames |
| Shares with friends/family | 3-5 min sessions | Multiplayer focused |

## Game Structure (DESIGN.MD)

### Story Mode (4 Worlds)
1. **La Ciudad Euro-Mix** - European landmark mashup, toy architecture
2. **El Desierto de Cactos** - Giant dunes, neon oasis, ancient ruins
3. **El Casino del Caos** - Floating dice, roulette backgrounds, psychedelic carpets
4. **La Obra Lunatica** - Hyperbolic cranes, bouncing beams, dynamic scaffolding

### 5 Minigame Categories (20 total)
1. Puzzle - Pattern matching, piece reorganization (3D)
2. Counting - Count moving objects rapidly
3. Memory/Concentration - Reproduce light/sound sequences
4. Barrage/Reflexes - Timing-based, button mashing
5. Picture Search - Find symbol combinations in 3D grids

### Core Loop
Roulette (select MG) -> Instructions (2s) -> Minigame (5-30s) -> Result -> Repeat

### Life System
- Start: 3 lives (neon heart containers)
- Lose life: Time up OR fail minigame
- Gain life: Complete bonus OR collect 3 Lucky! fragments
- Lucky!: Random roulette option, grants heart piece + random MG

## Success Metrics

| Metric | Target | Tool |
|--------|--------|------|
| D1 Retention | > 45% | Firebase Analytics |
| D7 Retention | > 20% | Firebase Analytics |
| Session Length | 4-8 min | Firebase Analytics |
| Crash Rate | < 0.1% | Firebase Crashlytics |
| Store Rating | >= 4.3 | App Store / Play Console |
| IAP Conversion | > 3% | RevenueCat + Firebase |
| Input Lag | < 50ms | Device testing |
| FPS (mid-range) | 60fps stable | Godot Profiler |

## Monetization Model

### Premium (primary)
- One-time purchase: $2.99-$4.99
- No ads (no banner, interstitial, or rewarded)
- No energy/cooldown systems
- No gameplay behind paywall

### Cosmetic IAP (secondary)
- Detective skin packs ($0.99)
- Scenario skin packs ($0.99)
- Screen effect packs (retro filters) ($0.99)

## Competitive Landscape

The original Tant-R was criticized for repetitiveness. Modern version addresses this with:
- 20 varied minigames (vs. repetitive original)
- 3D stylized visuals (vs. dated 2D)
- Progressive difficulty with meaningful curves
- Multiple game modes for different player types
- Local multiplayer for social play

## Key Risks

| Risk | Impact | Mitigation |
|------|--------|-----------|
| Input lag on low-end | High | Early testing on A52/Pixel 6a |
| Perceived repetitiveness | Medium | Difficulty variants + rotation |
| Store rejection | Low | Follow guidelines, TestFlight beta |
| Scope creep (>20 MGs) | Medium | Hard freeze at Sprint 2 |
| 3D performance on mobile | High | LOD + Mobile renderer + budgets |
