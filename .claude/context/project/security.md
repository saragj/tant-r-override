# Security - Tant-R Override

> Game security and data protection | Last Updated: Jun 2026

## Security Considerations

### Local Data (SaveManager)
- Save data stored in `user://save.json` (app sandbox)
- No sensitive data in saves (just scores, settings, unlocks)
- No encryption needed (no personal data, no auth tokens)
- Backup: cloud save via Firebase (optional, anonymous)

### Firebase
- Anonymous user IDs (UUID v4, no auth required)
- Realtime DB rules: write-limited (anti-spam)
- Leaderboard anti-cheat: max score validation server-side
  - Max possible score = phases x minigames x 3000
  - Reject scores exceeding theoretical maximum
- API key in app (acceptable for Firebase mobile, restricted in Console)

### In-App Purchases
- Receipt validation via Firebase Functions (server-side)
- Purchases stored in SaveManager + verified against store receipts
- Restore purchases flow for both iOS and Android

### Build Security
- Release keystore NOT in repository (stored in CI secrets)
- Provisioning profiles NOT in repository
- `google-services.json` / `GoogleService-Info.plist` in .gitignore
- No hardcoded API keys in GDScript (use project settings or env)

### Anti-Cheat (Basic)
- Score submissions include: mg_id, time_left, phase (sanity check)
- Client-side validation before submission
- No sensitive game logic exposed via signals/network
- Leaderboard names sanitized (no HTML/scripts)

### Data Privacy
- No personal data collected (no accounts, no email)
- Anonymous analytics (Firebase, GDPR compliant)
- Privacy policy URL required for store submission
- No third-party SDKs beyond Firebase

## Files NOT to Commit

```
*.keystore
*.jks
google-services.json
GoogleService-Info.plist
*.p12
*.mobileprovision
.env*
export_presets.cfg
```
