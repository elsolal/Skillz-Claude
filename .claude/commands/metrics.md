---
description: Affiche un dashboard des métriques du projet (coverage, issues, qualité, RALPH). Usage: /metrics [--full]
---

# Project Metrics Dashboard 📊

## Mode activé : Métriques

Je vais collecter et afficher les métriques clés du projet.

---

## 📥 Données à collecter

**Métriques à récupérer avec les outils disponibles.**

| Catégorie | Métriques | Action |
|-----------|-----------|--------|
| **Git** | Commits, branche, dernier commit | `Bash: git rev-list --count HEAD`, `git log --oneline -1` |
| **GitHub** | Issues ouvertes, PRs ouvertes | `Bash: gh issue list --state open`, `gh pr list --state open` |
| **Code** | Fichiers source, fichiers test | `Glob: **/*.ts **/*.tsx` (compter) |
| **Coverage** | Pourcentage | `Read: coverage/coverage-summary.json` |
| **Dependencies** | Vulnérabilités | `Bash: npm audit --json` |
| **RALPH** | Sessions | `Glob: docs/ralph-logs/*.md` (compter) |
| **Docs** | PRDs, Architecture, Stories | `Glob: docs/planning/**/*.md docs/stories/**/*.md` |

### Instructions de chargement
1. Exécuter les commandes git pour les stats de repo
2. Utiliser `gh` CLI pour GitHub si disponible
3. Compter les fichiers avec `Glob`
4. Lire les fichiers de coverage si existants

---

## Arguments

| Argument | Default | Description |
|----------|---------|-------------|
| `--full` | false | Affiche toutes les métriques détaillées |
| `--json` | false | Output en JSON |
| `--compare <branch>` | - | Compare avec une autre branche |

---

## Dashboard Output

```
╔══════════════════════════════════════════════════════════════════════════════╗
║                           📊 PROJECT METRICS                                  ║
╠══════════════════════════════════════════════════════════════════════════════╣
║                                                                              ║
║  📁 CODEBASE                          🧪 TESTS                               ║
║  ┌─────────────────────────────┐      ┌─────────────────────────────┐       ║
║  │ Files:        [XXX]         │      │ Test files:    [XX]         │       ║
║  │ Lines:        [XX,XXX]      │      │ Coverage:      [XX%] ████░░ │       ║
║  │ Commits:      [XXX]         │      │ Passing:       [XX/XX] ✅   │       ║
║  │ Last commit:  [XX ago]      │      │ Skipped:       [X]          │       ║
║  └─────────────────────────────┘      └─────────────────────────────┘       ║
║                                                                              ║
║  📋 GITHUB                            📦 DEPENDENCIES                        ║
║  ┌─────────────────────────────┐      ┌─────────────────────────────┐       ║
║  │ Open issues:  [XX]          │      │ Total:         [XX]         │       ║
║  │ Open PRs:     [XX]          │      │ Outdated:      [X]          │       ║
║  │ Labels:       [XX]          │      │ Vulnerabilities:            │       ║
║  │ Milestones:   [X]           │      │   Critical: [X] High: [X]   │       ║
║  └─────────────────────────────┘      └─────────────────────────────┘       ║
║                                                                              ║
║  📚 DOCUMENTATION                     🤖 RALPH SESSIONS                      ║
║  ┌─────────────────────────────┐      ┌─────────────────────────────┐       ║
║  │ PRDs:         [X]           │      │ Total:         [X]          │       ║
║  │ Architecture: [X]           │      │ Completed:     [X] ✅       │       ║
║  │ Stories:      [XX]          │      │ Interrupted:   [X] ⚠️       │       ║
║  │ API specs:    [X]           │      │ Avg iterations:[X.X]        │       ║
║  └─────────────────────────────┘      └─────────────────────────────┘       ║
║                                                                              ║
╠══════════════════════════════════════════════════════════════════════════════╣
║  🏥 HEALTH SCORE: [XX]/100                                                   ║
║  ████████████████████░░░░░░░░░░                                              ║
║                                                                              ║
║  [Coverage 20%] [Tests 20%] [Docs 20%] [Security 20%] [Activity 20%]         ║
╚══════════════════════════════════════════════════════════════════════════════╝
```

---

## Health Score Calculation

| Composant | Poids | Calcul |
|-----------|-------|--------|
| **Coverage** | 20% | % coverage (cap 100) |
| **Tests** | 20% | % tests passing |
| **Documentation** | 20% | (PRD + Arch + Stories) / expected × 100 |
| **Security** | 20% | 100 - (critical×25 + high×10 + medium×5) |
| **Activity** | 20% | Commits last 30 days / 30 × 100 (cap 100) |

### Seuils

| Score | Status | Signification |
|-------|--------|---------------|
| 80-100 | 🟢 Excellent | Projet en très bonne santé |
| 60-79 | 🟡 Good | Quelques améliorations possibles |
| 40-59 | 🟠 Fair | Attention requise |
| 0-39 | 🔴 Poor | Actions urgentes nécessaires |

---

## Mode --full

Ajoute les détails suivants :

### Code Quality Details

```
📊 Code Quality
├── Lint errors:     [X]
├── Type errors:     [X]
├── Complexity:      [avg X.X]
├── Duplications:    [X%]
└── Tech debt:       [Xh estimated]
```

### Issue Breakdown

```
📋 Issues by Label
├── bug:             [XX] 🔴
├── feature:         [XX] 🟢
├── enhancement:     [XX] 🔵
├── documentation:   [XX] 📚
└── other:           [XX] ⚪
```

### Dependency Details

```
📦 Dependencies
├── Production:      [XX]
├── Development:     [XX]
├── Peer:            [XX]
└── Outdated:
    ├── Major:       [X] ⚠️
    ├── Minor:       [X]
    └── Patch:       [X]
```

### RALPH Session History

```
🤖 Recent RALPH Sessions
┌────────────┬─────────────────┬────────┬────────────┐
│ Date       │ Type            │ Iters  │ Status     │
├────────────┼─────────────────┼────────┼────────────┤
│ 2024-01-20 │ auto-feature    │ 12/50  │ ✅ Complete │
│ 2024-01-19 │ auto-discovery  │ 8/30   │ ✅ Complete │
│ 2024-01-18 │ auto-loop       │ 20/20  │ ⚠️ Max iter │
└────────────┴─────────────────┴────────┴────────────┘
```

---

## Mode --compare

Compare les métriques avec une autre branche :

```
📊 Comparison: main vs feature/new-auth

| Metric          | main    | feature | Delta  |
|-----------------|---------|---------|--------|
| Test coverage   | 75%     | 82%     | +7% ✅ |
| Open issues     | 12      | 12      | =      |
| Lines of code   | 15,420  | 16,102  | +682   |
| Test files      | 45      | 52      | +7 ✅  |
| Vulnerabilities | 2       | 1       | -1 ✅  |
```

---

## Exemples

### Dashboard standard

```bash
/metrics
```

### Dashboard complet

```bash
/metrics --full
```

### Comparaison de branches

```bash
/metrics --compare main
```

### Export JSON

```bash
/metrics --json > metrics.json
```

---

## Démarrage 🚀

**Arguments reçus :** $ARGUMENTS

Je collecte les métriques du projet...
