# Git Hooks

Hooks Git pour garantir la qualité du code avant chaque commit.

## Installation

### Manuelle

```bash
# Copier les hooks
cp .claude/templates/git-hooks/pre-commit .git/hooks/
cp .claude/templates/git-hooks/commit-msg .git/hooks/

# Rendre exécutables
chmod +x .git/hooks/pre-commit
chmod +x .git/hooks/commit-msg
```

### Avec Husky (recommandé)

```bash
# Installer Husky
npm install -D husky

# Initialiser
npx husky init

# Copier les hooks
cp .claude/templates/git-hooks/pre-commit .husky/
cp .claude/templates/git-hooks/commit-msg .husky/
```

## Hooks disponibles

### pre-commit

Vérifie avant chaque commit :

| Check | Action | Bloquant |
|-------|--------|----------|
| ESLint | Lint du code | ✅ Oui |
| TypeScript | Vérification types | ✅ Oui |
| Prettier | Formatage | ✅ Oui |
| Tests | Tests des fichiers modifiés | ✅ Oui |
| Secrets | Détection de secrets | ✅ Oui |
| Debug | console.log, debugger | ⚠️ Warning |

### commit-msg

Valide le format Conventional Commits :

```
type(scope): description

Types autorisés:
- feat     → Nouvelle fonctionnalité
- fix      → Correction de bug
- docs     → Documentation
- style    → Formatage (pas de changement de code)
- refactor → Refactoring
- perf     → Amélioration de performance
- test     → Ajout de tests
- build    → Système de build
- ci       → Configuration CI
- chore    → Maintenance
- revert   → Annulation de commit
```

## Personnalisation

### Désactiver un check

Commentez la section correspondante dans `pre-commit` :

```bash
# 1. ESLint
# echo "\n📋 Running ESLint..."
# ... (commenté)
```

### Ajouter un check

Ajoutez votre check dans `pre-commit` :

```bash
# Custom check
echo "\n🔍 Running custom check..."
if your_command; then
    echo "${GREEN}✓ Custom check passed${NC}"
else
    echo "${RED}✗ Custom check failed${NC}"
    exit 1
fi
```

### Bypass temporaire

```bash
# Bypass pre-commit (urgence uniquement)
git commit --no-verify -m "fix: urgent hotfix"

# Bypass commit-msg
SKIP_COMMIT_MSG=1 git commit -m "wip"
```

## Intégration CI

Ces hooks sont aussi disponibles en GitHub Actions :

```yaml
# .github/workflows/ci.yml
- name: Lint
  run: npm run lint

- name: Typecheck
  run: npm run typecheck

- name: Test
  run: npm test
```

## Troubleshooting

### Hook non exécuté

```bash
# Vérifier les permissions
ls -la .git/hooks/pre-commit

# Rendre exécutable
chmod +x .git/hooks/pre-commit
```

### Erreur "command not found"

```bash
# Vérifier que node/npm est dans le PATH
which node
which npm

# Ajouter au PATH dans le hook si nécessaire
export PATH="/usr/local/bin:$PATH"
```
