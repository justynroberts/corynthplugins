#!/bin/bash

# Create a new Corynth plugin from template
set -e

if [ $# -ne 1 ]; then
    echo "Usage: $0 <plugin-name>"
    echo "Example: $0 my-awesome-plugin"
    exit 1
fi

PLUGIN_NAME="$1"
PLUGIN_DIR="${PLUGIN_NAME}"

# Validate plugin name
if [[ ! "$PLUGIN_NAME" =~ ^[a-z][a-z0-9-]*$ ]]; then
    echo "Error: Plugin name must start with a letter and contain only lowercase letters, numbers, and hyphens"
    exit 1
fi

if [ -d "$PLUGIN_DIR" ]; then
    echo "Error: Plugin directory '$PLUGIN_DIR' already exists"
    exit 1
fi

echo "Creating plugin: $PLUGIN_NAME"
mkdir -p "$PLUGIN_DIR"

# Convert plugin name for Go struct (capitalize and remove hyphens)
STRUCT_NAME=$(echo "$PLUGIN_NAME" | sed 's/-//g' | sed 's/\b\w/\U&/g')Plugin

# Create plugin.go
cat > "$PLUGIN_DIR/plugin.go" << EOF
package main

import (
    "context"
    "fmt"
    
    "github.com/corynth/corynth-dist/src/pkg/plugin"
)

type ${STRUCT_NAME} struct{}

func (p *${STRUCT_NAME}) Metadata() plugin.Metadata {
    return plugin.Metadata{
        Name:        "${PLUGIN_NAME}",
        Version:     "1.0.0",
        Description: "TODO: Add description for ${PLUGIN_NAME} plugin",
        Author:      "TODO: Add your name",
        Tags:        []string{"TODO", "add", "tags"},
        License:     "Apache-2.0",
    }
}

func (p *${STRUCT_NAME}) Actions() []plugin.Action {
    return []plugin.Action{
        {
            Name:        "example",
            Description: "TODO: Example action - replace with your actual actions",
            Inputs: map[string]plugin.InputSpec{
                "input1": {
                    Type:        "string",
                    Description: "TODO: Description of input parameter",
                    Required:    true,
                },
                "input2": {
                    Type:        "string",
                    Description: "TODO: Optional parameter with default",
                    Required:    false,
                    Default:     "default-value",
                },
            },
            Outputs: map[string]plugin.OutputSpec{
                "result": {
                    Type:        "string",
                    Description: "TODO: Description of output",
                },
                "success": {
                    Type:        "boolean",
                    Description: "Whether the operation succeeded",
                },
            },
        },
    }
}

func (p *${STRUCT_NAME}) Validate(params map[string]interface{}) error {
    // TODO: Add parameter validation logic
    return nil
}

func (p *${STRUCT_NAME}) Execute(ctx context.Context, action string, params map[string]interface{}) (map[string]interface{}, error) {
    switch action {
    case "example":
        return p.executeExample(ctx, params)
    default:
        return nil, fmt.Errorf("unknown action: %s", action)
    }
}

func (p *${STRUCT_NAME}) executeExample(ctx context.Context, params map[string]interface{}) (map[string]interface{}, error) {
    input1, ok := params["input1"].(string)
    if !ok {
        return nil, fmt.Errorf("input1 parameter is required")
    }
    
    input2 := "default-value"
    if i2, ok := params["input2"].(string); ok {
        input2 = i2
    }
    
    // TODO: Implement your plugin logic here
    result := fmt.Sprintf("Processed: %s with %s", input1, input2)
    
    return map[string]interface{}{
        "result":  result,
        "success": true,
        "input1":  input1,
        "input2":  input2,
    }, nil
}

var ExportedPlugin plugin.Plugin = &${STRUCT_NAME}{}
EOF

# Create README.md
cat > "$PLUGIN_DIR/README.md" << EOF
# ${PLUGIN_NAME} Plugin

TODO: Add a brief description of what this plugin does.

## Actions

### example
TODO: Replace with your actual action description.

**Parameters:**
- \`input1\` (string, required): TODO: Description
- \`input2\` (string, optional): TODO: Description (default: "default-value")

**Returns:**
- \`result\` (string): TODO: Description
- \`success\` (boolean): Whether the operation succeeded

**Example:**
\`\`\`hcl
step "use_${PLUGIN_NAME//-/_}" {
  plugin = "${PLUGIN_NAME}"
  action = "example"
  params = {
    input1 = "test value"
    input2 = "optional value"
  }
}
\`\`\`

## Installation

\`\`\`bash
corynth plugin install ${PLUGIN_NAME}
\`\`\`

The plugin will be compiled from source and installed automatically.

## Development

TODO: Add development notes, testing instructions, etc.
EOF

# Create example workflow
mkdir -p "$PLUGIN_DIR/examples"
cat > "$PLUGIN_DIR/examples/workflow.hcl" << EOF
workflow "${PLUGIN_NAME}-example" {
  description = "Example workflow using the ${PLUGIN_NAME} plugin"
  
  step "test_${PLUGIN_NAME//-/_}" {
    plugin = "${PLUGIN_NAME}"
    action = "example"
    params = {
      input1 = "Hello World"
      input2 = "from ${PLUGIN_NAME}"
    }
  }
  
  step "show_result" {
    plugin = "shell"
    action = "exec"
    params = {
      command = "echo"
      args = [step.test_${PLUGIN_NAME//-/_}.outputs.result]
    }
  }
}
EOF

echo "✓ Plugin '$PLUGIN_NAME' created successfully!"
echo ""
echo "Next steps:"
echo "1. Edit $PLUGIN_DIR/plugin.go to implement your plugin logic"
echo "2. Update $PLUGIN_DIR/README.md with proper documentation"
echo "3. Test your plugin: corynth plugin install $PLUGIN_NAME"
echo "4. Run example: corynth run $PLUGIN_DIR/examples/workflow.hcl"
echo ""
echo "Plugin structure:"
echo "├── $PLUGIN_DIR/"
echo "│   ├── plugin.go           # Main plugin implementation"
echo "│   ├── README.md           # Plugin documentation" 
echo "│   └── examples/"
echo "│       └── workflow.hcl    # Example workflow"
echo ""
echo "Happy coding! 🚀"