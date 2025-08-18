# Corynth Official Plugin Repository

Official plugin repository for the Corynth workflow orchestration engine. This repository contains compiled plugins that are automatically downloaded and installed when referenced in Corynth workflows.

## 🚀 Quick Start

Plugins are automatically installed when you use them in workflows:

```hcl
workflow "example" {
  step "calculate" {
    plugin = "calculator"  # Automatically downloaded from this repository
    action = "calculate"
    params = {
      expression = "2 + 3 * 4"
    }
  }
}
```

## 📦 Available Plugins

| Plugin | Version | Size | Description | Actions |
|--------|---------|------|-------------|---------|
| **aws-s3** | 1.0.0 | 3.7M | AWS S3 storage operations | `list_buckets` |
| **calculator** | 1.0.0 | 4.5M | Mathematical calculations and unit conversions | `calculate`, `convert` |
| **csv-processor** | 1.0.0 | 3.9M | CSV file processing and data manipulation | `read`, `filter`, `sort` |
| **discord** | 1.0.0 | 3.7M | Discord messaging and bot operations | `send_message` |
| **image-processor** | 1.0.0 | 4.4M | Image processing and format conversion | `info`, `convert`, `validate` |
| **hello-world** | 1.0.0 | 3.8M | Multi-language greetings and learning examples | `greet`, `echo` |
| **postgresql** | 1.0.0 | 3.7M | PostgreSQL database operations | `query`, `ping` |
| **redis** | 1.0.0 | 3.7M | Redis cache operations and key-value storage | `set`, `get` |
| **http-client** | 1.0.0 | 12M | HTTP requests with timeout and header support | `get`, `post` |
| **slack** | 1.0.0 | 12M | Slack workspace messaging and management | `send_message`, `get_channels` |
| **github** | 1.0.0 | 12M | GitHub repository operations and CI/CD | `create_issue` |

## 🔍 Plugin Discovery

### Browse Available Plugins
```bash
corynth plugin discover
```

### Search for Plugins
```bash
# Search by keyword
corynth plugin search data

# Search by tags
corynth plugin search --tags api,http
```

### Get Plugin Information
```bash
corynth plugin info calculator
```

### Browse by Category
```bash
corynth plugin categories
```

## 📋 Categories

### Cloud Storage
- `aws-s3` - AWS S3 operations

### Data Processing
- `csv-processor` - CSV file manipulation
- `calculator` - Mathematical operations

### Communication
- `slack` - Slack messaging
- `http-client` - HTTP/REST API calls
- `discord` - Discord messaging

### Database
- `postgresql` - PostgreSQL operations
- `redis` - Redis caching

### Development
- `github` - GitHub integration
- `hello-world` - Learning examples

### Media
- `image-processor` - Image manipulation

### Utilities
- `calculator` - Calculations and conversions
- `hello-world` - Example plugin

## 💻 Manual Installation

While plugins are auto-installed, you can also install them manually:

```bash
# Install a specific plugin
corynth plugin install calculator

# Update to latest version
corynth plugin update calculator

# List installed plugins
corynth plugin list

# Remove a plugin
corynth plugin remove calculator
```

## 📖 Plugin Examples

### Calculator Plugin
```hcl
step "math" {
  plugin = "calculator"
  action = "calculate"
  params = {
    expression = "10 * 5 + 3"
    precision = 2
  }
}

step "convert_temp" {
  plugin = "calculator"
  action = "convert"
  params = {
    value = 25
    from_unit = "celsius"
    to_unit = "fahrenheit"
  }
}
```

### CSV Processor Plugin
```hcl
step "read_csv" {
  plugin = "csv-processor"
  action = "read"
  params = {
    file_path = "data.csv"
    has_header = true
  }
}

step "filter_data" {
  plugin = "csv-processor"
  action = "filter"
  params = {
    file_path = "data.csv"
    column = "status"
    value = "active"
    output_path = "filtered.csv"
  }
}
```

### HTTP Client Plugin
```hcl
step "api_call" {
  plugin = "http-client"
  action = "get"
  params = {
    url = "https://api.example.com/data"
    headers = {
      "Authorization" = "Bearer ${var.api_token}"
    }
    timeout = 30
  }
}
```

### Slack Plugin
```hcl
step "notify" {
  plugin = "slack"
  action = "send_message"
  params = {
    token = var.slack_token
    channel = "#notifications"
    message = "Workflow completed successfully!"
  }
}
```

### AWS S3 Plugin
```hcl
step "list_buckets" {
  plugin = "aws-s3"
  action = "list_buckets"
  params = {
    access_key = var.aws_access_key
    secret_key = var.aws_secret_key
    region = "us-east-1"
  }
}
```

### Discord Plugin
```hcl
step "notify_discord" {
  plugin = "discord"
  action = "send_message"
  params = {
    token = var.discord_token
    channel_id = "123456789"
    message = "Build completed successfully!"
  }
}
```

### PostgreSQL Plugin
```hcl
step "query_users" {
  plugin = "postgresql"
  action = "query"
  params = {
    host = "localhost"
    database = "myapp"
    username = var.db_user
    password = var.db_pass
    sql = "SELECT * FROM users WHERE active = true"
  }
}
```

### Redis Plugin
```hcl
step "cache_data" {
  plugin = "redis"
  action = "set"
  params = {
    host = "localhost"
    key = "user:${var.user_id}"
    value = "${step.get_user.outputs.user_data}"
    ttl = 3600
  }
}
```

## 🔧 Configuration

Add this repository to your `corynth.hcl` configuration (this is the default):

```hcl
plugins {
  auto_install = true
  local_path = "bin/plugins"
  
  repository "official" {
    name     = "official"
    url      = "https://github.com/justynroberts/corynthplugins"
    branch   = "main"
    priority = 1
  }
  
  cache {
    enabled  = true
    path     = ".corynth/cache"
    ttl      = "24h"
  }
}
```

## 🏗️ Architecture

- **Language**: Go 1.21+
- **Format**: Compiled shared libraries (.so files)
- **Architecture**: ARM64 (Apple Silicon) and AMD64
- **OS Support**: macOS and Linux
- **Interface**: Standard Corynth plugin interface

## 📊 Plugin Registry

The `registry.json` file contains detailed metadata about all available plugins:
- Plugin descriptions and versions
- Available actions with examples
- System requirements
- Tags and categories
- File sizes and formats

## 🔒 Security

- All plugins are compiled from reviewed source code
- Plugins run with limited permissions
- No network access unless explicitly required (http-client, slack, github)
- Regular security updates

## 📝 Contributing

Want to contribute a plugin? 

1. Implement the Corynth plugin interface
2. Compile as a shared library
3. Submit a pull request with:
   - Your compiled .so file
   - Updated registry.json entry
   - Documentation and examples

See the [Plugin Development Guide](https://docs.corynth.io/plugins) for details.

## 📈 Stats

- **Total Plugins**: 11
- **Total Size**: ~53MB
- **Downloads**: Auto-tracked by Corynth
- **Last Updated**: 2024-08-18

## 🏷️ Featured Plugins

⭐ **calculator** - Essential for data processing workflows  
⭐ **csv-processor** - Handle CSV data with ease  
⭐ **slack** - Team notifications and alerts  

## 🆕 New Plugins

🎉 **discord** - Discord bot messaging  
🎉 **postgresql** - Database operations  
🎉 **redis** - In-memory caching  
🎉 **aws-s3** - Cloud storage integration  

## 📱 Support

- **Documentation**: https://docs.corynth.io
- **Issues**: https://github.com/justynroberts/corynthplugins/issues
- **Discussions**: https://github.com/justynroberts/corynthplugins/discussions

## 📄 License

All plugins in this repository are licensed under Apache 2.0 unless otherwise specified.

---

*This repository is automatically used by Corynth for plugin discovery and installation. No manual setup required!*