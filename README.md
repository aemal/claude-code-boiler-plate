# Claude Code Sandbox with Task Master AI MCP

This project creates a powerful three-agent development environment that combines **Claude Code**, **Cursor**, and **Task Master AI** to work together on complex software development tasks.

## Overview

This dockerized development environment orchestrates three AI agents working in harmony:

- **Claude Code** - Provides advanced code generation and analysis capabilities
- **Cursor IDE** - Offers intelligent code editing and development features
- **Task Master AI** - Manages and coordinates tasks across the development workflow

Both Claude Code and Cursor can produce code simultaneously, while Task Master AI handles task management and coordination between the agents. This setup is specifically dockerized for safety, as Claude's YOLO mode (using `--dangerously-skip-permissions`) can be risky in unrestricted environments.

**Key Benefits:**

- **Long-running execution** - Designed to run uninterrupted for extended periods
- **Feature completion** - Capable of finishing entire application features autonomously
- **Safe isolation** - Docker containment prevents system-level risks from aggressive AI permissions
- **Multi-agent coordination** - Three specialized agents working together for optimal results

The project automatically sets up Model Context Protocol (MCP) connections between all agents when the container starts, creating a seamless collaborative development environment.

## Prerequisites

Before using this devcontainer, make sure you have:

1. **Docker Desktop** installed and running on your system

   - [Download Docker Desktop](https://www.docker.com/products/docker-desktop/)

2. **Cursor IDE** with the Dev Containers extension

   - Install the "Dev Containers" extension in Cursor
   - You can find it in the extensions marketplace by searching for "Dev Containers"

3. **API Keys** for the MCP connection:
   - **Anthropic API Key** for Claude
   - **Perplexity API Key** for enhanced functionality

## Setup Instructions

Follow these simple steps to get your development environment up and running:

### Step 1: Clone the Project

```bash
git clone https://github.com/aemal/claude-code-boiler-plate
cd claude-code-boiler-plate
```

### Step 2: Prepare Your Environment

1. **Run Docker Desktop** - Make sure Docker Desktop is installed and running on your system
2. **Install Dev Containers Extension** - Ensure you have the "Dev Containers" extension installed in Cursor
3. **Open the project** in Cursor:

```bash
cursor .
```

> **Note**: You might not be able to open Cursor by typing `cursor .`. If this doesn't work, search ChatGPT for "how to set up cursor command line" to find instructions for your operating system.

![Docker Desktop & Dev Containers running](images/01-dev-container-and-docker.png)

### Step 3: Configure API Keys

Open the `.env` file and provide your API keys:

```env
ANTHROPIC_API_KEY=your_anthropic_key_here
PERPLEXITY_API_KEY=your_perplexity_key_here
```

![.env file configuration](images/02-env-variables.png)

### Step 4: Open in Dev Container

Click on **"Reopen in Container"** when prompted, or manually trigger it:

1. Press `Cmd+Shift+P` (macOS) or `Ctrl+Shift+P` (Windows/Linux)
2. Select **"Dev Containers: Open Folder in Container"**

![Command palette Dev Containers option](images/command-palette-dev-containers.png)
![Reopen in Container notification](images/reopen-in-container-notification.png)

### Step 5: Wait for the Magic! ✨

The system will automatically:
- Create a Docker container
- Install Claude Code
- Install Task Master AI
- Set up the MCP server

You should see the Docker container running in the Docker Desktop app.

![Docker Desktop running container](images/docker-desktop-running-container.png)
![Terminal setup completion](images/terminal-setup-completion.png)

---

## Detailed Setup Information

## What Happens During Container Startup

When the devcontainer starts, it automatically:

1. **Builds the Docker environment** with Node.js, development tools, and dependencies
2. **Sets up firewall rules** for secure network access
3. **Loads environment variables** from your `.env` file
4. **Installs Claude CLI and task-master-ai** packages
5. **Configures the MCP connection** between Claude and task-master-ai
6. **Verifies the connection** to ensure everything is working properly

## Viewing Setup Logs

During container initialization, you can monitor the setup progress in **Cursor's Terminal/Output panel**:

1. **During Container Build**: Look for the "Dev Containers" output channel in Cursor's Terminal panel
2. **Container Creation Logs**: The initialization logs appear in the terminal as the container starts
3. **Post-Creation**: You can also view logs by running the setup script manually

You'll see output similar to this during startup:

```
Initializing environment...
Loading environment variables from .env file...
Setting up firewall...
Setting up MCP connection...
Adding task-master-ai MCP connection...
Verifying MCP connection status...
✅ MCP connection verified successfully!
🎉 MCP setup complete! You can now use task-master-ai through Claude MCP.
```

**To view logs after container is running:**

- Check current MCP status: `claude mcp list`
- Re-run setup manually: `sudo /usr/local/bin/setup-mcp.sh`
- View initialization logs: Check Cursor's Terminal → Output → Dev Containers

## Using the MCP Connection

Once the container is running and the MCP connection is established, you can:

### Check Connection Status

```bash
claude mcp list
```

This should show `task-master-ai` with a status of `connected`.

### Use Task Master AI

The task-master-ai tool is now available through Claude's MCP interface and can help with:

- Project management and task organization
- Code analysis and suggestions
- Development workflow automation
- Research and information gathering (via Perplexity integration)

## File Structure

```
.
├── .devcontainer/
│   ├── devcontainer.json       # Dev container configuration
│   ├── Dockerfile              # Container image definition
│   ├── init-environment.sh     # Environment initialization script
│   ├── setup-mcp.sh           # MCP connection setup script
│   └── init-firewall.sh       # Network security setup
├── .env.example               # Template for environment variables
├── .env                       # Your actual API keys (don't commit!)
├── .gitignore                # Git ignore rules
└── README.md                 # This file
```

## Troubleshooting

### Connection Failed

If the MCP connection fails during setup:

1. **Check your API keys** in the `.env` file
2. **Verify internet connectivity** within the container
3. **Manually retry the setup**:
   ```bash
   sudo /usr/local/bin/setup-mcp.sh
   ```

### Environment Variables Not Loaded

If environment variables aren't being loaded:

1. **Ensure the `.env` file exists** in the project root
2. **Check the file format** - no spaces around the `=` sign
3. **Rebuild the container**:
   - Press `Cmd+Shift+P` → "Dev Containers: Rebuild Container"

### Network Issues

If you encounter network connectivity problems:

1. **Check Docker Desktop** is running
2. **Verify firewall settings** on your host system
3. **Try restarting** Docker Desktop

### Manual MCP Management

You can manually manage MCP connections:

```bash
# List all MCP connections
claude mcp list

# Remove a connection
claude mcp remove task-master-ai

# Re-add the connection
sudo /usr/local/bin/setup-mcp.sh
```

## Development Features

This devcontainer includes:

- **Node.js 22** runtime environment
- **Git** with delta for better diffs
- **ESLint and Prettier** for code quality
- **Zsh with Powerlevel10k** theme
- **Network security** with firewall rules
- **Persistent command history**
- **Port forwarding** for web development (port 3000)

## Security Notes

- The container runs with restricted network access via firewall rules
- Only whitelisted domains (GitHub, NPM, Anthropic, etc.) are accessible
- API keys are kept in environment variables and not logged
- The `.env` file is automatically excluded from version control

## Support

If you encounter issues:

1. Check the container logs during startup
2. Verify your API keys are valid and have the necessary permissions
3. Ensure Docker Desktop has sufficient resources allocated
4. Try rebuilding the container if problems persist

## Credits

This repository was created by **[Aemal Sayer](https://aemalsayer.com)**, an experienced software engineer with 23 years of software development experience, including 17 years as a full-stack developer and 7+ years in AI/ML. For the past 2.5 years, he has been specializing in building AI agents.

**Connect with Aemal:**

- 🌐 Website: [aemalsayer.com](https://aemalsayer.com)
- 💼 LinkedIn: [linkedin.com/in/aemal](https://linkedin.com/in/aemal)
- 📺 YouTube: [youtube.com/@agentgeeks](https://youtube.com/@agentgeeks)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

**Note**: This setup is designed for development and testing purposes. For production use, consider additional security measures and proper secrets management.
