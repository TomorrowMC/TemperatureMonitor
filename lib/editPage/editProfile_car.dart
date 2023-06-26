import 'package:flutter/material.dart';
import '../Model/model_of_cars.dart';

class profile_car extends StatefulWidget {
  Car car;
  profile_car(this.car);

  @override
  State<profile_car> createState() => _profile_carState(this.car);
}

class _profile_carState extends State<profile_car> {
  Car _car;
  _profile_carState(this._car);

  @override
  Widget build(BuildContext context) {
    //return three text fields and two buttons, update and delete
    return Scaffold(
      appBar: AppBar(
        title: Text('Coordinator Information'),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                icon: Icon(Icons.car_crash),
                labelText: 'Coordinator Name',
                hintText: _car.deviceId.toString(),
              ),
            ),
            TextField(
              decoration: InputDecoration(
                icon: Icon(Icons.note_alt_rounded),
                labelText: 'Remark',
                hintText: _car.deviceId.toString(),
              ),
              maxLines: 4,
            ),
            TextField(
              decoration: InputDecoration(
                icon: Icon(Icons.more),
                labelText: 'Other',
                hintText: _car.deviceId.toString(),
              ),
            ),
            //some space
            SizedBox(height: 60.0),
            RaisedButton(
              color: Colors.blue, // Set the button color to blue
              child: Text('Save Changes'),
              onPressed: null,
              //     () {
              //   Navigator.pop(context);
              // },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              padding: EdgeInsets.all(30.0),
            ),
            // some space
            SizedBox(height: 30.0),
            RaisedButton(
              //delete button use red color
              color: Colors.red, // Set the button color to red
              child: Text('Delete Device'),
              onPressed: null,
              //     () {
              //   Navigator.pop(context);
              // },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              //set the size of the button
              padding: EdgeInsets.all(30.0),
            ),
          ],
        ),
      ),
    );
  }
}
