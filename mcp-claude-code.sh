claude mcp remove everything
claude mcp remove fs
claude mcp remove playwright

claude mcp add everything -- -y npx @modelcontextprotocol/server-everything
claude mcp add fs -- npx -y @modelcontextprotocol/server-filesystem .
claude mcp add playwright -- npx -y @playwright/mcp@latest --headless --output-dir .
