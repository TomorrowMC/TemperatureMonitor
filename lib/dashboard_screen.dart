import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'DeviceDataList/DeviceList.dart';
import 'dart:convert';

import 'Model/model_of_cars.dart';
import 'editPage/editProfile_car.dart';

class FriendsListPage extends StatefulWidget {
  @override
  _FriendsListPageState createState() => _FriendsListPageState();
}

class _FriendsListPageState extends State<FriendsListPage>
    with SingleTickerProviderStateMixin {
  Future<bool> _goToLogin(BuildContext context) {
    return Navigator.of(context)
        .pushReplacementNamed('/auth')
        .then((_) => false);
  }

  List<Car> _cars = [];
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 3), (Timer t) => _loadFriends());
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  _loadFriends() async {
    http.Response response =
    await http.get(Uri.parse('http://124.222.108.174:8003/api1/devices'));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      List<Car> cars =
      jsonResponse.map((carJson) => Car.fromJson(carJson)).toList();

      setState(() {
        _cars = cars;
      });
    } else {
      print('Failed to load data from URL');
    }
  }

  Widget _buildFriendListTile(BuildContext context, int index) {
    var car = _cars[index];

    return ListTile(
      onTap: () => _navigateToFriendDetails(car, index),
      leading: Hero(
        tag: index,
        child: CircleAvatar(),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('设备ID: ${car.deviceId.toString()}'),
          Text('最近一次的湿度: ${car.latestHumidity}'),
        ],
      ),
      trailing: Container(
        width: 40.0,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (c) {
                    return profile_car(car);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToFriendDetails(Car car, int tag) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (c) {
          return DeviceDetailsPage(
            deviceId: car.deviceId,
            parameterNames: car.parameterNames,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content;

    if (_cars.isEmpty) {
      content = Center(
        child: CircularProgressIndicator(),
      );
    } else {
      content = ListView.builder(
        itemCount: _cars.length,
        itemBuilder: _buildFriendListTile,
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('传感器列表')),
      body: content,
    );
  }
}
