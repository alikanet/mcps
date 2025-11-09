FROM node:20-slim

WORKDIR /app

# Install curl for downloading binaries
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Install mcp-hub
RUN npm install -g mcp-hub

# Install portainer-mcp binary
RUN curl -Lo /tmp/portainer-mcp.tar.gz \
    https://github.com/portainer/portainer-mcp/releases/download/v0.2.0/portainer-mcp-v0.2.0-linux-amd64.tar.gz && \
    tar -xzf /tmp/portainer-mcp.tar.gz -C /usr/local/bin && \
    chmod +x /usr/local/bin/portainer-mcp && \
    rm /tmp/portainer-mcp.tar.gz

# Copy config file
COPY config.json /app/config.json

EXPOSE 3737

CMD ["mcp-hub", "--port", "3737", "--config", "/app/config.json"]