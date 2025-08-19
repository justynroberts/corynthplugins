# Corynth Plugin Registry

This repository contains the official plugin registry for Corynth workflow orchestration.

## Built-in Plugin System

**All plugins listed in this registry are available as built-in lazy-loaded plugins in Corynth >= 1.2.0.**

### No Installation Required!

Unlike traditional plugin systems, Corynth plugins are built-in and automatically load when first used. This approach provides:

- **Zero installation friction** - Plugins work immediately
- **Perfect compatibility** - No version conflicts or interface mismatches  
- **Better performance** - No dynamic loading overhead
- **Enhanced security** - No external code execution

### Core Plugins (Always Available)
- **git** - Git version control operations
- **slack** - Slack workspace messaging and management

### Lazy-Loaded Plugins (Available on Demand)
- **redis** - Redis cache operations and key-value storage
- **mysql** - MySQL database operations and management  
- **terraform** - Terraform Infrastructure as Code operations
- **vault** - HashiCorp Vault secrets management
- **docker** - Docker container operations and image management
- **http** - HTTP requests with timeout and header support
- **shell** - Execute shell commands and scripts
- **file** - File and directory operations

## Usage

### Check Available Plugins
```bash
corynth plugin search ""
```

### Get Plugin Information  
```bash
corynth plugin info redis
corynth plugin info mysql
```

### Use Plugins in Workflows
Plugins automatically load when referenced in your workflow files:

```hcl
workflow "example" {
  step "cache_data" {
    plugin = "redis"
    action = "set"
    params = {
      key   = "user:123"
      value = "john_doe"
    }
  }

  step "query_db" {
    plugin = "mysql"
    action = "query"
    params = {
      host     = "localhost"
      database = "myapp"
      query    = "SELECT * FROM users WHERE active = 1"
    }
  }
}
```

## Plugin Categories

- **Core**: git, slack
- **Database**: redis, mysql  
- **Infrastructure**: terraform, vault, docker
- **Network**: http
- **System**: shell, file

## Requirements

- Corynth >= 1.2.0 for lazy-loaded plugins
- Corynth >= 1.0.0 for core plugins (git, slack)

## Registry Information

- **Version**: 1.0.0
- **Last Updated**: 2025-08-19
- **Total Plugins**: 10
- **Format**: Built-in lazy-loaded