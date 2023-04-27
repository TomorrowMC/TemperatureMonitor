import 'dart:async';

import 'package:flutter/material.dart';
import 'ParameterDetailsPage.dart';

class DeviceDetailsPage extends StatefulWidget {
  final int deviceId;
  final List<String> parameterNames;

  DeviceDetailsPage({required this.deviceId, required this.parameterNames});

  @override
  _DeviceDetailsPageState createState() => _DeviceDetailsPageState();
}

class _DeviceDetailsPageState extends State<DeviceDetailsPage> {
  late String lastRefreshTime;

  @override
  void initState() {
    super.initState();

    // 初始化最后刷新时间
    lastRefreshTime = _getCurrentTime();
    // 每3秒更新最后刷新时间
    Timer.periodic(Duration(seconds: 3), (timer) {
      setState(() {
        lastRefreshTime = _getCurrentTime();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('设备详情'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('最后刷新时间：$lastRefreshTime'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.parameterNames.length,
              itemBuilder: (context, index) {
                String parameterName = widget.parameterNames[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('参数名称: $parameterName',
                          style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 3,
                      width: MediaQuery.of(context).size.width,
                      child: ParameterDetailsPage(
                        deviceId: widget.deviceId,
                        parameterName: parameterName,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String _getCurrentTime() {
    var now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';
  }
}
