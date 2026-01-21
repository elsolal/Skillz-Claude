# Dev Container Dockerfile
# Based on official Node.js image with development tools

FROM node:20-bookworm

# Install additional tools
RUN apt-get update && apt-get install -y \
    git \
    curl \
    wget \
    zsh \
    vim \
    jq \
    postgresql-client \
    && rm -rf /var/lib/apt/lists/*

# Install Oh My Zsh for better terminal experience
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Install global npm packages
RUN npm install -g \
    typescript \
    ts-node \
    eslint \
    prettier \
    vercel \
    wrangler \
    @anthropic-ai/claude-code

# Set zsh as default shell
ENV SHELL=/bin/zsh

# Create workspace directory
WORKDIR /workspaces

# Set user
USER node

# Default command
CMD ["sleep", "infinity"]
