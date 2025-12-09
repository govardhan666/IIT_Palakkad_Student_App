import '../../domain/entities/weather.dart';

/// Weather data model with JSON parsing
class WeatherModel extends Weather {
  const WeatherModel({
    required super.temperature,
    required super.feelsLike,
    required super.humidity,
    required super.condition,
    required super.conditionDescription,
    required super.windSpeed,
    required super.icon,
    required super.lastUpdated,
  });

  /// Parse from wttr.in JSON format
  factory WeatherModel.fromWttrJson(Map<String, dynamic> json) {
    final current = json['current_condition']?[0] ?? {};

    return WeatherModel(
      temperature: double.tryParse(current['temp_C']?.toString() ?? '0') ?? 0,
      feelsLike: double.tryParse(current['FeelsLikeC']?.toString() ?? '0') ?? 0,
      humidity: int.tryParse(current['humidity']?.toString() ?? '0') ?? 0,
      condition: current['weatherDesc']?[0]?['value'] ?? 'Unknown',
      conditionDescription: current['weatherDesc']?[0]?['value'] ?? '',
      windSpeed: int.tryParse(current['windspeedKmph']?.toString() ?? '0') ?? 0,
      icon: current['weatherCode']?.toString() ?? '',
      lastUpdated: DateTime.now(),
    );
  }

  /// Create from stored JSON
  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      temperature: (json['temperature'] as num?)?.toDouble() ?? 0,
      feelsLike: (json['feelsLike'] as num?)?.toDouble() ?? 0,
      humidity: json['humidity'] as int? ?? 0,
      condition: json['condition'] as String? ?? 'Unknown',
      conditionDescription: json['conditionDescription'] as String? ?? '',
      windSpeed: json['windSpeed'] as int? ?? 0,
      icon: json['icon'] as String? ?? '',
      lastUpdated: json['lastUpdated'] != null
          ? DateTime.parse(json['lastUpdated'] as String)
          : DateTime.now(),
    );
  }

  /// Convert to JSON for storage
  Map<String, dynamic> toJson() {
    return {
      'temperature': temperature,
      'feelsLike': feelsLike,
      'humidity': humidity,
      'condition': condition,
      'conditionDescription': conditionDescription,
      'windSpeed': windSpeed,
      'icon': icon,
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }
}
