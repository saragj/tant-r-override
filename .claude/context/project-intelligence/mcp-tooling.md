<!-- Context: project-intelligence/mcp-tooling | Priority: high | Version: 1.4 | Updated: 2026-06-11 -->

# MCP Tooling

**Purpose**: MCP servers configured in `opencode.json`, their purpose, and agent usage rules.
**Last Updated**: 2026-06-11

## Quick Reference

**Update Triggers**: New MCP added | Tool disabled/enabled | Usage patterns change
**Audience**: AI agents, developers

## Active MCPs

| MCP      | Type   | Command / URL                      | Purpose                                    |
| -------- | ------ | ---------------------------------- | ------------------------------------------ |
| `stitch` | remote | `https://stitch.googleapis.com/mcp` | UI mockup generation & design from prompts |

---

## Setup & Configuration

### 🧵 Stitch MCP

Google Stitch is used for generating UI mockups and design screens from text prompts.

**Configuration** (in `opencode.json`):
```json
{
  "mcp": {
    "stitch": {
      "type": "remote",
      "url": "https://stitch.googleapis.com/mcp",
      "enabled": true,
      "headers": {
        "X-Goog-Api-Key": "{env:STITCH_API_KEY}"
      }
    }
  }
}
```

**Setup**:
1. Ensure `STITCH_API_KEY` env var is set with a valid Google Cloud API key
2. The MCP is `remote` type — no local server to start

**Usage**:
- Generate new screens: `stitch_generate_screen_from_text`
- Edit existing screens: `stitch_edit_screens`
- Manage design systems: `stitch_create_design_system` / `stitch_update_design_system`
- Get project info: `stitch_get_project` / `stitch_list_projects`

**Debugging**: If Stitch tools return auth errors → verify `STITCH_API_KEY` env var is set and valid.

---

## Decision: When to Use Which

| Task                          | Use        |
| ----------------------------- | ---------- |
| UI mockup generation          | Stitch MCP |
| Design system creation/update | Stitch MCP |
| Screen iteration/editing      | Stitch MCP |

## 📂 Codebase References

**Config**: `opencode.json` — MCP server definitions and enabled state
**PRD**: `TantR_Modern_PRD_v1.md` — Stitch referenced for UI mockup pipeline
**Tasks**: `TantR_Modern_Tasks_v1.md` — S0-T09: Export mockups UI desde Stitch
