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
| **awscli** | 1.0.0 | 3.7M | AWS CLI operations for cloud resource management | `ec2_describe_instances`, `s3_list_buckets`, `cloudformation_describe_stacks` |
| **calculator** | 1.0.0 | 4.5M | Mathematical calculations and unit conversions | `calculate`, `convert` |
| **csv-processor** | 1.0.0 | 3.9M | CSV file processing and data manipulation | `read`, `filter`, `sort` |
| **discord** | 1.0.0 | 3.7M | Discord messaging and bot operations | `send_message` |
| **docker** | 1.0.0 | 3.7M | Docker container operations and image management | `build`, `run`, `ps`, `stop` |
| **image-processor** | 1.0.0 | 4.4M | Image processing and format conversion | `info`, `convert`, `validate` |
| **hello-world** | 1.0.0 | 3.8M | Multi-language greetings and learning examples | `greet`, `echo` |
| **jenkins** | 1.0.0 | 3.7M | Jenkins CI/CD pipeline automation and build management | `trigger_build`, `get_build_status`, `list_jobs`, `get_console_output` |
| **mysql** | 1.0.0 | 3.7M | MySQL database operations and management | `query`, `ping`, `backup`, `restore` |
| **pagerduty** | 1.0.0 | 3.7M | PagerDuty incident management and alerting | `create_incident`, `resolve_incident`, `list_incidents`, `get_oncall` |
| **postgresql** | 1.0.0 | 3.7M | PostgreSQL database operations | `query`, `ping` |
| **prometheus** | 1.0.0 | 3.7M | Prometheus monitoring and metrics collection | `query`, `query_range`, `get_targets`, `get_alerts`, `get_series` |
| **redis** | 1.0.0 | 3.7M | Redis cache operations and key-value storage | `set`, `get` |
| **terraform** | 1.0.0 | 3.7M | Terraform Infrastructure as Code operations | `plan`, `apply`, `destroy`, `init` |
| **vault** | 1.0.0 | 3.7M | HashiCorp Vault secrets management and encryption | `read_secret`, `write_secret`, `delete_secret`, `list_secrets`, `authenticate`, `encrypt`, `decrypt` |
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
- `awscli` - AWS CLI operations

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
- `mysql` - MySQL operations

### Development
- `github` - GitHub integration
- `hello-world` - Learning examples
- `docker` - Container management
- `jenkins` - CI/CD automation

### Infrastructure
- `awscli` - AWS cloud operations
- `docker` - Containerization
- `terraform` - Infrastructure as Code

### Monitoring
- `pagerduty` - Incident management
- `prometheus` - Metrics collection

### Security
- `vault` - Secrets management

### CI/CD
- `jenkins` - Build automation
- `terraform` - Infrastructure deployment

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

### AWS CLI Plugin
```hcl
step "list_ec2_instances" {
  plugin = "awscli"
  action = "ec2_describe_instances"
  params = {
    region = "us-west-2"
    profile = "production"
  }
}

step "list_cf_stacks" {
  plugin = "awscli"
  action = "cloudformation_describe_stacks"
  params = {
    region = "us-east-1"
    stack_status_filter = "CREATE_COMPLETE"
  }
}
```

### Docker Plugin
```hcl
step "build_image" {
  plugin = "docker"
  action = "build"
  params = {
    dockerfile_path = "./Dockerfile"
    image_tag = "myapp:${var.version}"
    build_args = {
      NODE_ENV = "production"
    }
  }
}

step "run_container" {
  plugin = "docker"
  action = "run"
  params = {
    image = "myapp:latest"
    ports = ["3000:3000"]
    environment = {
      NODE_ENV = "production"
      DATABASE_URL = var.db_url
    }
    detached = true
  }
}
```

### PagerDuty Plugin
```hcl
step "create_alert" {
  plugin = "pagerduty"
  action = "create_incident"
  params = {
    integration_key = var.pagerduty_key
    summary = "Deployment failed for ${var.app_name}"
    severity = "critical"
    details = {
      deployment_id = var.deployment_id
      environment = "production"
    }
  }
}

step "check_oncall" {
  plugin = "pagerduty"
  action = "get_oncall"
  params = {
    api_token = var.pagerduty_api_token
    schedule_id = var.primary_schedule_id
  }
}
```

### Terraform Plugin
```hcl
step "terraform_plan" {
  plugin = "terraform"
  action = "plan"
  params = {
    working_dir = "./infrastructure"
    var_file = "production.tfvars"
  }
}

step "terraform_apply" {
  plugin = "terraform"
  action = "apply"
  params = {
    working_dir = "./infrastructure"
    plan_file = "${step.terraform_plan.outputs.plan_file}"
    auto_approve = true
  }
}
```

### Jenkins Plugin
```hcl
step "trigger_build" {
  plugin = "jenkins"
  action = "trigger_build"
  params = {
    jenkins_url = "https://jenkins.company.com"
    username = var.jenkins_user
    api_token = var.jenkins_token
    job_name = "deploy-production"
    parameters = {
      BRANCH = "main"
      ENVIRONMENT = "production"
    }
    wait_for_completion = true
  }
}

step "get_build_logs" {
  plugin = "jenkins"
  action = "get_console_output"
  params = {
    jenkins_url = "https://jenkins.company.com"
    username = var.jenkins_user
    api_token = var.jenkins_token
    job_name = "deploy-production"
    build_number = step.trigger_build.outputs.build_number
  }
}
```

### MySQL Plugin
```hcl
step "backup_database" {
  plugin = "mysql"
  action = "backup"
  params = {
    host = "db.company.com"
    database = "production_db"
    username = var.db_user
    password = var.db_password
    output_file = "/backups/prod_backup_${timestamp()}.sql"
    compress = true
  }
}

step "query_users" {
  plugin = "mysql"
  action = "query"
  params = {
    host = "db.company.com"
    database = "production_db"
    username = var.db_user
    password = var.db_password
    sql = "SELECT COUNT(*) as user_count FROM users WHERE created_at >= CURDATE()"
  }
}
```

### Prometheus Plugin
```hcl
step "check_service_health" {
  plugin = "prometheus"
  action = "query"
  params = {
    prometheus_url = "https://prometheus.company.com"
    query = "up{job=\"api-server\"}"
  }
}

step "get_error_rate" {
  plugin = "prometheus"
  action = "query_range"
  params = {
    prometheus_url = "https://prometheus.company.com"
    query = "rate(http_requests_total{status=~\"5..\"}[5m])"
    start = "2024-08-18T10:00:00Z"
    end = "2024-08-18T11:00:00Z"
    step = "1m"
  }
}
```

### Vault Plugin
```hcl
step "get_db_credentials" {
  plugin = "vault"
  action = "read_secret"
  params = {
    vault_addr = "https://vault.company.com"
    vault_token = var.vault_token
    path = "secret/database/production"
  }
}

step "store_api_key" {
  plugin = "vault"
  action = "write_secret"
  params = {
    vault_addr = "https://vault.company.com"
    vault_token = var.vault_token
    path = "secret/api-keys/external-service"
    data = {
      api_key = var.external_api_key
      created_by = "corynth-workflow"
      expires = "2024-12-31"
    }
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

- **Total Plugins**: 19
- **Total Size**: ~53MB
- **Downloads**: Auto-tracked by Corynth
- **Last Updated**: 2024-08-18

## 🏷️ Featured Plugins

⭐ **terraform** - Infrastructure as Code for any cloud provider  
⭐ **vault** - Enterprise secrets management and encryption  
⭐ **jenkins** - Industry-standard CI/CD pipeline automation  
⭐ **prometheus** - Cloud-native monitoring and alerting  
⭐ **mysql** - World's most popular open source database  

## 🆕 New Plugins

🎉 **terraform** - Complete Infrastructure as Code operations  
🎉 **jenkins** - CI/CD pipeline automation and build management  
🎉 **mysql** - MySQL database operations and management  
🎉 **prometheus** - Monitoring, metrics, and alerting  
🎉 **vault** - HashiCorp Vault secrets management  

## 📱 Support

- **Documentation**: https://docs.corynth.io
- **Issues**: https://github.com/justynroberts/corynthplugins/issues
- **Discussions**: https://github.com/justynroberts/corynthplugins/discussions

## 📄 License

All plugins in this repository are licensed under Apache 2.0 unless otherwise specified.

---

*This repository is automatically used by Corynth for plugin discovery and installation. No manual setup required!*