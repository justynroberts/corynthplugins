# Weather Plugin

Get weather information and forecasts for Corynth workflows.

## Actions

### current
Get current weather conditions for a location.

**Parameters:**
- `location` (string, required): City name or coordinates
- `units` (string, optional): Temperature units - "celsius" or "fahrenheit" (default: "celsius")  
- `api_key` (string, optional): Weather API key for real data

**Returns:**
- `temperature` (number): Current temperature
- `condition` (string): Weather condition (sunny, cloudy, rainy, etc.)
- `humidity` (number): Humidity percentage
- `timestamp` (string): When the data was retrieved

**Example:**
```hcl
step "check_weather" {
  plugin = "weather" 
  action = "current"
  params = {
    location = "New York"
    units = "fahrenheit"
  }
}
```

### forecast
Get weather forecast for multiple days.

**Parameters:**
- `location` (string, required): City name or coordinates
- `days` (number, optional): Number of forecast days (default: 3)
- `units` (string, optional): Temperature units - "celsius" or "fahrenheit" (default: "celsius")
- `api_key` (string, optional): Weather API key for real data

**Returns:**
- `forecast` (array): Array of forecast objects with date, temperature, condition, humidity
- `days` (number): Number of forecast days returned
- `location` (string): Location queried

**Example:**
```hcl
step "get_forecast" {
  plugin = "weather"
  action = "forecast" 
  params = {
    location = "London"
    days = 5
    units = "celsius"
  }
}
```

## Installation

```bash
corynth plugin install weather
```

The plugin will be compiled from source and installed automatically.

## Note

This plugin currently returns mock data for demonstration. In a production environment, you would integrate with a real weather API service.