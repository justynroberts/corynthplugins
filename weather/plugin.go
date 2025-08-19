package main

import (
    "context"
    "fmt"
    "strings"
    "time"
    
    "github.com/corynth/corynth-dist/src/pkg/plugin"
)

type WeatherPlugin struct{}

func (p *WeatherPlugin) Metadata() plugin.Metadata {
    return plugin.Metadata{
        Name:        "weather",
        Version:     "1.0.0",
        Description: "Weather information and forecasts",
        Author:      "Corynth Team",
        Tags:        []string{"weather", "forecast", "api", "climate"},
        License:     "Apache-2.0",
    }
}

func (p *WeatherPlugin) Actions() []plugin.Action {
    return []plugin.Action{
        {
            Name:        "current",
            Description: "Get current weather conditions",
            Inputs: map[string]plugin.InputSpec{
                "location": {
                    Type:        "string",
                    Description: "City name or coordinates",
                    Required:    true,
                },
                "units": {
                    Type:        "string",
                    Description: "Temperature units (celsius, fahrenheit)",
                    Required:    false,
                    Default:     "celsius",
                },
                "api_key": {
                    Type:        "string",
                    Description: "Weather API key",
                    Required:    false,
                },
            },
            Outputs: map[string]plugin.OutputSpec{
                "temperature": {
                    Type:        "number",
                    Description: "Current temperature",
                },
                "condition": {
                    Type:        "string",
                    Description: "Weather condition",
                },
                "humidity": {
                    Type:        "number",
                    Description: "Humidity percentage",
                },
            },
        },
        {
            Name:        "forecast",
            Description: "Get weather forecast",
            Inputs: map[string]plugin.InputSpec{
                "location": {
                    Type:        "string",
                    Description: "City name or coordinates",
                    Required:    true,
                },
                "days": {
                    Type:        "number",
                    Description: "Number of forecast days",
                    Required:    false,
                    Default:     3,
                },
                "units": {
                    Type:        "string",
                    Description: "Temperature units (celsius, fahrenheit)",
                    Required:    false,
                    Default:     "celsius",
                },
                "api_key": {
                    Type:        "string",
                    Description: "Weather API key",
                    Required:    false,
                },
            },
            Outputs: map[string]plugin.OutputSpec{
                "forecast": {
                    Type:        "array",
                    Description: "Weather forecast data",
                },
            },
        },
    }
}

func (p *WeatherPlugin) Validate(params map[string]interface{}) error {
    location, ok := params["location"].(string)
    if !ok || strings.TrimSpace(location) == "" {
        return fmt.Errorf("location parameter is required and cannot be empty")
    }
    return nil
}

func (p *WeatherPlugin) Execute(ctx context.Context, action string, params map[string]interface{}) (map[string]interface{}, error) {
    switch action {
    case "current":
        return p.executeCurrent(ctx, params)
    case "forecast":
        return p.executeForecast(ctx, params)
    default:
        return nil, fmt.Errorf("unknown action: %s", action)
    }
}

func (p *WeatherPlugin) executeCurrent(ctx context.Context, params map[string]interface{}) (map[string]interface{}, error) {
    location, _ := params["location"].(string)
    units, _ := params["units"].(string)
    if units == "" {
        units = "celsius"
    }
    
    // Simulate weather API call - in real implementation, you'd call a weather service
    temperature := p.getMockTemperature(location, units)
    condition := p.getMockCondition(location)
    humidity := p.getMockHumidity(location)
    
    return map[string]interface{}{
        "location":    location,
        "temperature": temperature,
        "condition":   condition,
        "humidity":    humidity,
        "units":       units,
        "timestamp":   time.Now().Format(time.RFC3339),
    }, nil
}

func (p *WeatherPlugin) executeForecast(ctx context.Context, params map[string]interface{}) (map[string]interface{}, error) {
    location, _ := params["location"].(string)
    days := 3.0
    if d, ok := params["days"].(float64); ok {
        days = d
    }
    units, _ := params["units"].(string)
    if units == "" {
        units = "celsius"
    }
    
    // Generate mock forecast data
    forecast := make([]map[string]interface{}, int(days))
    baseTemp := p.getMockTemperature(location, units)
    
    for i := 0; i < int(days); i++ {
        date := time.Now().AddDate(0, 0, i)
        tempVariation := float64(i*2 - 2) // Simple variation
        
        forecast[i] = map[string]interface{}{
            "date":        date.Format("2006-01-02"),
            "temperature": baseTemp + tempVariation,
            "condition":   p.getMockCondition(location),
            "humidity":    p.getMockHumidity(location),
            "units":       units,
        }
    }
    
    return map[string]interface{}{
        "location": location,
        "forecast": forecast,
        "days":     int(days),
        "units":    units,
    }, nil
}

func (p *WeatherPlugin) getMockTemperature(location, units string) float64 {
    // Mock temperature based on location hash
    locationHash := 0
    for _, r := range location {
        locationHash += int(r)
    }
    
    baseTemp := 20.0 + float64(locationHash%15) // 20-35°C range
    
    if units == "fahrenheit" {
        return (baseTemp * 9.0 / 5.0) + 32 // Convert to Fahrenheit
    }
    
    return baseTemp
}

func (p *WeatherPlugin) getMockCondition(location string) string {
    conditions := []string{"sunny", "cloudy", "partly cloudy", "rainy", "overcast"}
    locationHash := 0
    for _, r := range location {
        locationHash += int(r)
    }
    return conditions[locationHash%len(conditions)]
}

func (p *WeatherPlugin) getMockHumidity(location string) float64 {
    locationHash := 0
    for _, r := range location {
        locationHash += int(r)
    }
    return 40.0 + float64(locationHash%40) // 40-80% range
}

var ExportedPlugin plugin.Plugin = &WeatherPlugin{}