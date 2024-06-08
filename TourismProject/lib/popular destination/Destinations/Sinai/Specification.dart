import 'package:flutter/material.dart';
import './hotels.dart';
import './places.dart';
import './rest.dart';

class Specify extends StatelessWidget {
  const Specify({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 121, 155, 228), // Background color
      padding: EdgeInsets.all(16.0), // Add padding for spacing
      child: Row(
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ScreenOne()),
              );
            },
            child: Text(
              'Hotels',
              style: TextStyle(color: Color.fromARGB(255, 4, 28, 82)), // Text color
            ),
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ScreenTwo()),
              );
            },
            child: Text(
              'Restaurants',
              style: TextStyle(color: Color.fromARGB(255, 4, 28, 82)), // Text color
            ),
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ScreenThree()),
              );
            },
            child: Text(
              'Places',
              style: TextStyle(color: Color.fromARGB(255, 4, 28, 82)), // Text color
            ),
          ),
        ],
      ),
    );
  }
}