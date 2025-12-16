import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../data/models/weather_model.dart';
import '../../data/services/weather_service.dart';

/// Widget displaying current weather
class WeatherWidget extends StatefulWidget {
  const WeatherWidget({super.key});

  @override
  State<WeatherWidget> createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  final WeatherService _weatherService = WeatherService();
  WeatherModel? _weather;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadWeather();
  }

  Future<void> _loadWeather() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    final weather = await _weatherService.fetchWeather();

    if (mounted) {
      setState(() {
        _weather = weather;
        _isLoading = false;
        if (weather == null) {
          _error = 'Unable to load weather';
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: _loadWeather,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: _isLoading
              ? _buildLoading()
              : _error != null
                  ? _buildError()
                  : _buildWeather(),
        ),
      ),
    );
  }

  Widget _buildLoading() {
    return const SizedBox(
      height: 80,
      child: Center(
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
    );
  }

  Widget _buildError() {
    return SizedBox(
      height: 80,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.cloud_off, color: AppColors.textSecondary),
            const SizedBox(height: 4),
            Text(
              'Tap to retry',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeather() {
    final weather = _weather!;

    return Row(
      children: [
        // Weather icon/emoji
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              weather.weatherEmoji,
              style: const TextStyle(fontSize: 32),
            ),
          ),
        ),
        const SizedBox(width: 16),
        // Temperature and condition
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${weather.temperature.round()}',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          height: 1,
                        ),
                  ),
                  Text(
                    '°C',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                ],
              ),
              Text(
                weather.condition,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        // Additional info
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _buildInfoRow(Icons.water_drop, '${weather.humidity}%'),
            const SizedBox(height: 4),
            _buildInfoRow(Icons.air, '${weather.windSpeed} km/h'),
            const SizedBox(height: 4),
            _buildInfoRow(Icons.thermostat, 'Feels ${weather.feelsLike.round()}°'),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 12, color: AppColors.textSecondary),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            fontSize: 11,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
