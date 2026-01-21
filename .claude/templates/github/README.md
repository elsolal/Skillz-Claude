# GitHub Templates

Templates pour les Pull Requests et Issues GitHub.

## Installation

```bash
# Créer le dossier .github
mkdir -p .github

# Copier le template PR
cp .claude/templates/github/PULL_REQUEST_TEMPLATE.md .github/
```

## Templates disponibles

### PULL_REQUEST_TEMPLATE.md

Template standard pour les Pull Requests :

| Section | Description |
|---------|-------------|
| Summary | Description courte (1-2 phrases) |
| Changes | Liste des changements |
| Type | Bug, Feature, Breaking, Docs, Refactor |
| Testing | Checklist de validation |
| Screenshots | Pour les changements UI |
| Closes # | Lien vers l'issue |

### Personnalisation

Vous pouvez personnaliser le template selon vos besoins :

```markdown
## Summary
<!-- Votre description ici -->

## Changes
- [ ]

## Checklist
- [ ] Tests ajoutés
- [ ] Documentation mise à jour
- [ ] Code review demandée
```

### Templates multiples

Pour différents types de PRs, créez un dossier :

```
.github/
├── PULL_REQUEST_TEMPLATE/
│   ├── feature.md
│   ├── bugfix.md
│   └── hotfix.md
```

Les contributeurs pourront choisir le template via `?template=feature.md`.

## Issue Templates (optionnel)

Vous pouvez aussi ajouter des templates d'issues :

```
.github/
├── ISSUE_TEMPLATE/
│   ├── bug_report.md
│   ├── feature_request.md
│   └── config.yml
```

Exemple `bug_report.md` :

```markdown
---
name: Bug Report
about: Report a bug
labels: bug
---

## Description
<!-- What happened? -->

## Steps to reproduce
1.
2.
3.

## Expected behavior
<!-- What should have happened? -->

## Environment
- OS:
- Node version:
- Browser:
```
