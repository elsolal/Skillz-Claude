# Dev Container Templates

Configuration Docker pour un environnement de développement reproductible.

## Installation

### Option 1: Simple (sans services)

```bash
# Créer le dossier .devcontainer
mkdir -p .devcontainer

# Copier les fichiers
cp .claude/templates/devcontainer/devcontainer.json .devcontainer/
cp .claude/templates/devcontainer/Dockerfile .devcontainer/
```

### Option 2: Avec services (PostgreSQL, Redis)

```bash
# Créer le dossier .devcontainer
mkdir -p .devcontainer

# Copier tous les fichiers
cp .claude/templates/devcontainer/devcontainer.json .devcontainer/
cp .claude/templates/devcontainer/Dockerfile .devcontainer/
cp .claude/templates/devcontainer/docker-compose.yml .devcontainer/

# Modifier devcontainer.json pour utiliser docker-compose
```

Puis modifier `.devcontainer/devcontainer.json` :

```json
{
  "name": "Project Dev Container",
  "dockerComposeFile": "docker-compose.yml",
  "service": "app",
  "workspaceFolder": "/workspaces/${localWorkspaceFolderBasename}"
}
```

## Usage

### VS Code

1. Installer l'extension "Dev Containers"
2. Ouvrir le projet
3. `Cmd/Ctrl + Shift + P` → "Dev Containers: Reopen in Container"

### GitHub Codespaces

Le projet sera automatiquement ouvert dans un Codespace avec cette configuration.

## Fichiers

### devcontainer.json

Configuration principale :

| Option | Description |
|--------|-------------|
| `features` | Node.js 20, Git, GitHub CLI |
| `forwardPorts` | 3000 (app), 5432 (PostgreSQL) |
| `extensions` | ESLint, Prettier, Tailwind, Prisma, etc. |
| `postCreateCommand` | `npm install` |

### Dockerfile

Image basée sur Node.js 20 avec :
- Git, curl, wget, jq
- Zsh + Oh My Zsh
- PostgreSQL client
- Global npm packages (typescript, eslint, prettier, vercel, claude-code)

### docker-compose.yml

Services optionnels :

| Service | Port | Description |
|---------|------|-------------|
| `app` | 3000 | Application Node.js |
| `db` | 5432 | PostgreSQL 16 |
| `redis` | 6379 | Redis 7 |
| `mailhog` | 8025 | Email testing (optionnel) |
| `minio` | 9000 | S3-compatible storage (optionnel) |

## Personnalisation

### Changer la version Node.js

Dans `devcontainer.json` :

```json
"features": {
  "ghcr.io/devcontainers/features/node:1": {
    "version": "18"  // ou "lts", "latest"
  }
}
```

### Ajouter des extensions VS Code

```json
"customizations": {
  "vscode": {
    "extensions": [
      "votre.extension-id"
    ]
  }
}
```

### Ajouter des variables d'environnement

```json
"containerEnv": {
  "MY_VAR": "value"
}
```

### Ajouter un service

Dans `docker-compose.yml` :

```yaml
services:
  mongodb:
    image: mongo:7
    ports:
      - "27017:27017"
```

## Troubleshooting

### Container ne démarre pas

```bash
# Rebuild complet
docker-compose -f .devcontainer/docker-compose.yml build --no-cache
```

### Permissions sur node_modules

```bash
# Dans le container
sudo chown -R node:node /workspaces/*/node_modules
```

### Port déjà utilisé

```bash
# Vérifier les ports
lsof -i :3000

# Ou changer le port dans devcontainer.json
"forwardPorts": [3001, 5432]
```
