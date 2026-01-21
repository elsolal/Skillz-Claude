# GitHub Templates

Templates pour les Pull Requests et Issues GitHub.

## Installation

```bash
# Créer le dossier .github
mkdir -p .github

# Copier tous les templates
cp .claude/templates/github/PULL_REQUEST_TEMPLATE.md .github/
cp -r .claude/templates/github/ISSUE_TEMPLATE .github/
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

### ISSUE_TEMPLATE/

Templates pour les Issues GitHub :

| Template | Description | Label auto |
|----------|-------------|------------|
| `bug_report.md` | Rapport de bug | `bug` |
| `feature_request.md` | Demande de fonctionnalité | `enhancement` |
| `config.yml` | Configuration (liens, options) | - |

#### bug_report.md

Sections :
- Description du bug
- Steps to Reproduce
- Expected vs Actual Behavior
- Screenshots
- Environment (OS, Node, Browser)

#### feature_request.md

Sections :
- Problem statement
- Proposed Solution
- Alternatives Considered
- Use Case

#### config.yml

Configure les options des issues :
- `blank_issues_enabled` : Autoriser les issues vides
- `contact_links` : Liens vers documentation, discussions

## Personnalisation

### PR Template

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

### Issue Templates

Modifiez les templates selon vos besoins :

```yaml
---
name: Custom Template
about: Description de votre template
title: '[PREFIX] '
labels: label1, label2
assignees: username
---
```

### Templates multiples PRs

Pour différents types de PRs, créez un dossier :

```
.github/
├── PULL_REQUEST_TEMPLATE/
│   ├── feature.md
│   ├── bugfix.md
│   └── hotfix.md
```

Les contributeurs pourront choisir le template via `?template=feature.md`.
