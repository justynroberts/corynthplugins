#!/bin/bash

# Bulk create DevOps plugins from built-in implementations
set -e

BUILTIN_DIR="/Users/justynroberts/work/corynth-dist/src/pkg/plugin"

echo "Creating DevOps plugins from built-in implementations..."

# Create plugin directories
plugins=(
    "vault:HashiCorp Vault secrets management"
    "docker:Docker container operations"
    "mysql:MySQL database operations"
    "redis:Redis cache operations"
    "http:HTTP client operations"
    "shell:Shell command execution"
    "file:File system operations"
    "git:Git version control operations" 
    "slack:Slack messaging operations"
)

for plugin_info in "${plugins[@]}"; do
    IFS=':' read -r plugin_name plugin_desc <<< "$plugin_info"
    
    if [ ! -d "$plugin_name" ]; then
        echo "Creating $plugin_name plugin..."
        mkdir -p "$plugin_name"
        
        # Create plugin.go from builtin implementation
        echo "package main

import (
    \"context\"
    \"fmt\"
    
    \"github.com/corynth/corynth-dist/src/pkg/plugin\"
)" > "$plugin_name/plugin.go"

        # Read the builtin plugin and convert to standalone
        if [ -f "$BUILTIN_DIR/builtin_${plugin_name}.go" ]; then
            # Extract plugin implementation, remove package plugin and New functions
            grep -A 1000 "type ${plugin_name^}Plugin struct" "$BUILTIN_DIR/builtin_${plugin_name}.go" | \
            sed "s/package plugin//g" | \
            sed "/^\/\/ New${plugin_name^}Plugin/,+3d" | \
            sed "s/Metadata {/plugin.Metadata {/g" | \
            sed "s/Action {/plugin.Action {/g" | \
            sed "s/InputSpec {/plugin.InputSpec {/g" | \
            sed "s/OutputSpec {/plugin.OutputSpec {/g" | \
            sed "s/\[\]Action/\[\]plugin.Action/g" | \
            sed "s/map\[string\]InputSpec/map\[string\]plugin.InputSpec/g" | \
            sed "s/map\[string\]OutputSpec/map\[string\]plugin.OutputSpec/g" >> "$plugin_name/plugin.go"
            
            # Add the exported plugin line
            echo "" >> "$plugin_name/plugin.go"
            echo "var ExportedPlugin plugin.Plugin = &${plugin_name^}Plugin{}" >> "$plugin_name/plugin.go"
        else
            echo "Warning: No builtin implementation found for $plugin_name"
        fi
        
        # Create README.md
        cat > "$plugin_name/README.md" << EOF
# ${plugin_name^} Plugin

$plugin_desc for Corynth workflows.

## Installation

\`\`\`bash
corynth plugin install $plugin_name
\`\`\`

The plugin will be compiled from source and installed automatically.

## Usage

See the plugin actions for detailed usage information:

\`\`\`bash
corynth plugin info $plugin_name
\`\`\`
EOF
    else
        echo "$plugin_name already exists, skipping..."
    fi
done

echo "✓ All plugins created successfully!"