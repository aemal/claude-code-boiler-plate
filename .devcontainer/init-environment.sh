#!/bin/bash
set -euo pipefail

echo "Initializing environment..."

# Load environment variables from .env file if it exists
if [ -f "/workspace/.env" ]; then
    echo "Loading environment variables from .env file..."
    export $(grep -v '^#' /workspace/.env | xargs)
    echo "Environment variables loaded successfully"
else
    echo "No .env file found at /workspace/.env"
    echo "Please create a .env file with your API keys to enable MCP setup"
    echo "Expected format:"
    echo "ANTHROPIC_API_KEY=your_anthropic_key_here"
    echo "PERPLEXITY_API_KEY=your_perplexity_key_here"
fi

# Run firewall initialization
echo "Setting up firewall..."
sudo /usr/local/bin/init-firewall.sh

# Set up MCP connection if environment variables are available
if [ -n "${ANTHROPIC_API_KEY:-}" ] && [ -n "${PERPLEXITY_API_KEY:-}" ]; then
    echo "Setting up MCP connection..."
    /usr/local/bin/setup-mcp.sh
else
    echo "Skipping MCP setup - API keys not found in environment"
    echo "You can run 'sudo /usr/local/bin/setup-mcp.sh' manually after setting up your .env file"
fi

echo "Environment initialization complete!" if [ -d "/workspace/.taskmaster" ]; then
    echo "✅ Taskmaster already initialized - .taskmaster folder found"
else
    echo "🚀 Initializing Taskmaster project..."
    
    # Ensure the npm global bin is in PATH
    export PATH="/usr/local/share/npm-global/bin:$PATH"
    
    # Change to workspace directory and initialize taskmaster
    cd /workspace
    
    if task-master init -y; then
        echo "✅ Taskmaster project initialized successfully!"
