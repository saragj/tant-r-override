# Agent Models Configuration

> Tant-R Override agent system | Last Updated: Jun 2026

## Core Principle

Models are defined in:

- `.opencode/agent/core/*.md` (Core orchestrator agents)
- `.opencode/agent/subagents/**/*.md` (Subagents)
- `opencode.json` (Build/Plan agents)

## Model Assignment

### Core Agents

| Agent | Model | Temperature |
|-------|-------|-------------|
| OpenAgent | github-copilot/claude-sonnet-4.6 | 0.2 |
| OpenCoder | github-copilot/claude-sonnet-4.6 | 0.1 |

### Utility Subagents

| Subagent | Model | Temperature |
|----------|-------|-------------|
| ContextScout | opencode/m2.5-free | — |
| ExternalScout | github-copilot/claude-haiku-4.5 | 0.1 |
| TaskManager | github-copilot/claude-sonnet-4.5 | 0.1 |
| CoderAgent | github-copilot/claude-sonnet-4.6 | 0 |
| TestEngineer | github-copilot/gpt-5-mini | 0.1 |
| CodeReviewer | github-copilot/claude-sonnet-4.6 | 0.1 |
| BuildAgent | github-copilot/gpt-4o | 0.1 |
| DocWriter | github-copilot/claude-sonnet-4 | 0.2 |
| ContextOrganizer | opencode/m2.5-free | 0.1 |

### Game Development Subagents (Tant-R Override)

| Subagent | Model | Temperature | Notes |
|----------|-------|-------------|-------|
| Game_Design_Agent | github-copilot/claude-sonnet-4.6 | 0.1 | Precision critical (DESIGN.MD validation) |
| Lead_Developer_Agent | github-copilot/claude-sonnet-4.6 | 0.1 | Code quality critical |
| QA_Agent | github-copilot/claude-sonnet-4.6 | 0.1 | Test accuracy critical |
| Audio_Agent | github-copilot/claude-sonnet-4 | 0.2 | Creative + technical |
| VFX_Shader_Agent | github-copilot/claude-sonnet-4.5 | 0.2 | Creative + technical |
| Asset_Pipeline_Agent | github-copilot/claude-sonnet-4 | 0.1 | Pipeline precision |
| Narrative_Level_Agent | github-copilot/claude-sonnet-4.5 | 0.3 | Needs creativity for narrative |

### Build/Plan (opencode.json)

| Agent | Model | Temperature |
|-------|-------|-------------|
| build | opencode/m2.5-free | 0.3 |
| plan | opencode/m2.5-free | 0.1 |

## Model Providers

- **opencode/*** - OpenCode's own models (m2.5-free for lightweight tasks)
- **github-copilot/*** - GitHub Copilot models
- **github-copilot/claude-*** - Anthropic Claude via Copilot
- **github-copilot/gpt-*** - OpenAI GPT via Copilot

## Usage

When delegating to subagents, the model is automatically selected based on the agent definition:

```javascript
task(subagent_type="Game_Design_Agent", description="Validate minigame design", prompt="...")
task(subagent_type="Lead_Developer_Agent", description="Implement MG07", prompt="...")
task(subagent_type="QA_Agent", description="Run regression tests", prompt="...")
```

## Reference

- Agent definitions: `.opencode/agent/`
- Game dev agents: `.opencode/agent/subagents/gamedev/`
- OpenCode config: `opencode.json`
