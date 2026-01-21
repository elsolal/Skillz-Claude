# GitHub Actions Templates

Templates CI/CD prêts à l'emploi pour vos projets.

## Installation

```bash
# Créer le dossier .github/workflows
mkdir -p .github/workflows

# Copier les templates souhaités
cp .claude/templates/github-actions/ci.yml .github/workflows/
cp .claude/templates/github-actions/security.yml .github/workflows/
cp .claude/templates/github-actions/dependabot.yml .github/
```

## Templates disponibles

### ci.yml - Intégration Continue

| Job | Description |
|-----|-------------|
| `lint` | ESLint |
| `typecheck` | TypeScript |
| `test` | Tests + Coverage |
| `build` | Build + Artifacts |

**Triggers** : Push/PR sur main/master

### release.yml - Release automatique

| Job | Description |
|-----|-------------|
| `release` | Changelog + GitHub Release |
| `docker` | Build Docker (optionnel) |

**Triggers** : Push tag `v*`

```bash
# Créer une release
git tag v1.0.0
git push --tags
```

### security.yml - Scans de sécurité

| Job | Description |
|-----|-------------|
| `dependency-audit` | npm audit |
| `codeql` | CodeQL Analysis |
| `secret-scanning` | TruffleHog + Gitleaks |
| `snyk` | Snyk (optionnel) |
| `ossf-scorecard` | OSSF Scorecard |

**Triggers** : Push/PR + Weekly

### deploy.yml - Déploiement

| Platform | Status | Secrets requis |
|----------|--------|----------------|
| Vercel | `if: false` | `VERCEL_TOKEN` |
| Netlify | `if: false` | `NETLIFY_AUTH_TOKEN`, `NETLIFY_SITE_ID` |
| AWS S3 | `if: false` | `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, `AWS_S3_BUCKET` |
| Kubernetes | `if: false` | `KUBE_CONFIG` |
| Railway | `if: false` | `RAILWAY_TOKEN` |

**Pour activer** : Changer `if: false` en `if: true`

### dependabot.yml - Mises à jour automatiques

- npm : Weekly (Monday 09:00)
- GitHub Actions : Weekly
- Docker : Weekly

## Configuration

### Secrets requis

| Secret | Usage |
|--------|-------|
| `CODECOV_TOKEN` | Coverage reports |
| `NPM_TOKEN` | Publish npm (optionnel) |
| `VERCEL_TOKEN` | Deploy Vercel |
| `NETLIFY_AUTH_TOKEN` | Deploy Netlify |
| `SNYK_TOKEN` | Snyk security |

### Personnalisation

1. **Node version** : Modifier `node-version: '20'`
2. **Package manager** : Remplacer `npm` par `pnpm` ou `yarn`
3. **Build output** : Modifier `dist/`, `.next/`, `build/`

## Exemples

### Projet Next.js

```yaml
# ci.yml - Ajouter le cache Next.js
- name: Cache Next.js
  uses: actions/cache@v4
  with:
    path: .next/cache
    key: nextjs-${{ hashFiles('**/package-lock.json') }}
```

### Monorepo avec Turborepo

```yaml
# ci.yml - Utiliser turbo
- name: Run tests
  run: npx turbo run test

- name: Build
  run: npx turbo run build
```

### Python

```yaml
# ci.yml - Remplacer Node par Python
- name: Setup Python
  uses: actions/setup-python@v5
  with:
    python-version: '3.12'
    cache: 'pip'

- name: Install dependencies
  run: pip install -r requirements.txt

- name: Run tests
  run: pytest
```
