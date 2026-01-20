---
description: Lance le workflow de planning complet (Brainstorm → PRD → Architecture → Stories). Détecte automatiquement le mode FULL ou LIGHT selon le scope.
---

# Discovery Session v2

## Workflow Planning activé

Je vais t'accompagner dans la structuration de ton projet/feature.

## Process automatique

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                                                                             │
│  🎤 Tu expliques    →    📊 J'analyse    →    🎯 Mode détecté               │
│     ton besoin           le scope             FULL / LIGHT                  │
│                                                                             │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  MODE FULL (projet complexe)                                                │
│  🧠 Brainstorm → 📋 PRD → 🏗️ Architecture → 📝 Stories → GitHub             │
│                                                                             │
│  MODE LIGHT (feature simple)                                                │
│  📋 PRD Light → 📝 Stories → GitHub                                         │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

## Critères de détection

| Critère | LIGHT | FULL |
|---------|-------|------|
| Nombre de features | 1-2 | 3+ |
| Complexité technique | Simple | Multi-composants |
| Écrans/pages UI | 1-2 | 3+ |
| Intégrations externes | 0 | 1+ |
| Estimation dev | < 1 jour | > 1 jour |

**Tu peux toujours overrider** mon choix si tu préfères un autre mode.

## Règles

1. **Parle librement** - Speech-to-text OK, pas besoin d'être structuré
2. **Je pose des questions** - Pour bien comprendre le scope
3. **Tu valides chaque phase** - Rien sans ton OK
4. **Documents sauvegardés** - Dans `docs/planning/`

## Checklist globale

```markdown
## Discovery: $ARGUMENTS

### Phase 1: Écoute & Analyse
- [ ] Besoin exprimé
- [ ] Scope analysé
- [ ] Mode détecté : [FULL/LIGHT]
- [ ] ✅ Mode validé

### Phase 2: Brainstorm (si FULL)
- [ ] Idées explorées
- [ ] Direction choisie
- [ ] ✅ Brainstorm validé

### Phase 3: PRD
- [ ] Questions clarifiées
- [ ] PRD rédigé
- [ ] Sauvegardé: docs/planning/prd/PRD-xxx.md
- [ ] ✅ PRD validé

### Phase 4: Architecture (si FULL)
- [ ] Stack défini
- [ ] Composants identifiés
- [ ] Sauvegardé: docs/planning/architecture/ARCH-xxx.md
- [ ] ✅ Architecture validée

### Phase 5: Stories
- [ ] Epics identifiées
- [ ] Stories rédigées
- [ ] ✅ Stories validées

### Phase 6: Publication GitHub
- [ ] Epic créée → Issue #XX
- [ ] Stories créées → Issues #YY, #ZZ
- [ ] Liens partagés

→ Prêt pour: /feature #XX
```

---

## C'est parti !

**Explique-moi ton besoin.**

Parle comme tu veux - en mode speech-to-text, en bullet points, en paragraphes...
Je vais écouter, analyser le scope, et te proposer le mode adapté (FULL ou LIGHT).

Qu'est-ce que tu veux construire ?
