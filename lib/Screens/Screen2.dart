import 'package:flutter/material.dart';
import 'package:flutter_application_3/Services/httpService.dart';
import '../Model/Weather.dart';

class Screen2 extends StatefulWidget {
  final String cityName;

  const Screen2({super.key, required this.cityName});

  @override
  State<Screen2> createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  Weather? _weatherData;
  bool _isLoading = true;
  final HttpService _httpService = HttpService();

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  void _fetchWeather() async {
    try {
      final data = await _httpService.getWeatherForecast(widget.cityName);
      setState(() {
        _weatherData = data;
        _isLoading = false;
      });
    } catch (e) {
      print("Error fetching weather: $e");
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to load weather")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF004AAD), 
      body: _isLoading
          ? Center(child: CircularProgressIndicator(color: Colors.white))
          : _weatherData == null
              ? Center(child: Text("No data", style: TextStyle(color: Colors.white)))
              : SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.location_pin, size: 20, color: Colors.white),
                            SizedBox(width: 5),
                            Text(
                              _weatherData!.cityName,
                              style: TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Image.asset(
                          'assets/Images/06509ff97ca4966e34e878881cc49db475d84799.png',
                          width: 120,
                          height: 120,
                        ),
                        SizedBox(height: 10),
                        Text(
                          '${_weatherData!.temperature.toStringAsFixed(0)}°',
                          style: TextStyle(
                            fontSize: 60,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Precipitations",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Max.: ${_weatherData!.maxTemp}°  Min.: ${_weatherData!.minTemp}°',
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                        SizedBox(height: 20),
                        _buildWeatherDetails(),
                        SizedBox(height: 20),
                        _buildHourlyForecast(),
                        Spacer(),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[800],
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Text('Back', style: TextStyle(fontSize: 16)),
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }

  Widget _buildWeatherDetails() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.blue[800],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _detailItem(Icons.water_drop, '${_weatherData!.rainProbability}%', 'Rain'),
          _detailItem(Icons.water, '${_weatherData!.humidity}%', 'Humidity'),
          _detailItem(Icons.air, '${_weatherData!.windSpeed} km/h', 'Wind'),
        ],
      ),
    );
  }

  Widget _detailItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 24),
        SizedBox(height: 5),
        Text(value, style: TextStyle(color: Colors.white, fontSize: 16)),
      ],
    );
  }

  Widget _buildHourlyForecast() {
    return Container(
      height: 150,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.blue[800],
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _weatherData!.hourlyForecast.length,
        separatorBuilder: (context, index) => SizedBox(width: 10),
        itemBuilder: (context, index) {
          final forecast = _weatherData!.hourlyForecast[index];
          return Container(
            width: 70,
            decoration: BoxDecoration(
              color: index == 2 ? Colors.blue[700] : Colors.transparent,
              borderRadius: BorderRadius.circular(15),
            ),
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('${forecast.temperature.toStringAsFixed(0)}°C', style: TextStyle(color: Colors.white)),
                Image.network('http:${forecast.iconUrl}', width: 30, height: 30),
                Text(
                  _formatHour(forecast.time),
                  style: TextStyle(color: Colors.white70, fontSize: 10),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  String _formatHour(String time) {
    DateTime dateTime = DateTime.parse(time);
    return '${dateTime.hour.toString().padLeft(2, '0')}:00';
  }
}
