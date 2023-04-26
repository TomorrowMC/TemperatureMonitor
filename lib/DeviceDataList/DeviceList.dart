import 'package:flutter/material.dart';
import 'ParameterDetailsPage.dart';

class DeviceDetailsPage extends StatelessWidget {
  final int deviceId;
  final List<String> parameterNames;

  DeviceDetailsPage({required this.deviceId, required this.parameterNames});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Device Details'),
      ),
      body: ListView.builder(
        itemCount: parameterNames.length,
        itemBuilder: (context, index) {
          String parameterName = parameterNames[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Parameter: $parameterName',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width,
                child: ParameterDetailsPage(
                  deviceId: deviceId,
                  parameterName: parameterName,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
