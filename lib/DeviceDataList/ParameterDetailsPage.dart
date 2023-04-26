import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fl_chart/fl_chart.dart';

class ParameterDetailsPage extends StatefulWidget {
  final int deviceId;
  final String parameterName;

  ParameterDetailsPage({required this.deviceId, required this.parameterName});

  @override
  _ParameterDetailsPageState createState() => _ParameterDetailsPageState();
}

class _ParameterDetailsPageState extends State<ParameterDetailsPage> {
  List<int> values = [];
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    fetchData();
    _timer = Timer.periodic(Duration(seconds: 3), (timer) => fetchData());
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Future<void> fetchData() async {
    final response = await http.post(
      Uri.parse(
          'http://124.222.108.174:8003/api2/get_updatedata?device_id=${widget.deviceId}&param_name=${widget.parameterName}'),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        values = List<int>.from(data['values']);
      });
    } else {
      print('Failed to load data');
    }
  }

  List<FlSpot> getSpots() {
    return List.generate(values.length, (index) => FlSpot(index.toDouble(), values[index].toDouble()));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
        ),
        child: LineChart(
          LineChartData(
            gridData: FlGridData(show: false),
            titlesData: FlTitlesData(show: false),
            borderData: FlBorderData(show: false),
            lineBarsData: [
              LineChartBarData(
                spots: getSpots(),
                isCurved: true,
                barWidth: 2,
                belowBarData: BarAreaData(show: false),
                dotData: FlDotData(show: false),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
