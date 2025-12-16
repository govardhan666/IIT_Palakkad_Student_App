/// Weather data entity
class Weather {
  final double temperature;
  final double feelsLike;
  final int humidity;
  final String condition;
  final String conditionDescription;
  final int windSpeed;
  final String icon;
  final DateTime lastUpdated;

  const Weather({
    required this.temperature,
    required this.feelsLike,
    required this.humidity,
    required this.condition,
    required this.conditionDescription,
    required this.windSpeed,
    required this.icon,
    required this.lastUpdated,
  });

  /// Get weather icon based on condition
  String get weatherEmoji {
    final lowerCondition = condition.toLowerCase();
    if (lowerCondition.contains('sun') || lowerCondition.contains('clear')) {
      return '☀️';
    } else if (lowerCondition.contains('cloud') || lowerCondition.contains('overcast')) {
      return '☁️';
    } else if (lowerCondition.contains('rain') || lowerCondition.contains('drizzle')) {
      return '🌧️';
    } else if (lowerCondition.contains('thunder') || lowerCondition.contains('storm')) {
      return '⛈️';
    } else if (lowerCondition.contains('fog') || lowerCondition.contains('mist')) {
      return '🌫️';
    } else if (lowerCondition.contains('snow')) {
      return '❄️';
    } else {
      return '🌤️';
    }
  }
}
