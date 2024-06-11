import 'package:flutter/material.dart';

class About extends StatelessWidget {

  static const screenRoute = '/about';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          title: Row(mainAxisSize: MainAxisSize.min, children: [
            Text("About ",
                style: TextStyle(
                  fontSize: 25,
                  fontFamily: 'MadimiOne',
                  color: Color.fromARGB(255, 121, 155, 228),
                  //fontWeight: FontWeight.bold,
                )),
          ]),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Text(
              "Tourism Guiding is your essential tool for exploring new destinations with ease. Whether you're a seasoned traveler or embarking on your first adventure, this intuitive app provides expert guidance every step of the way. From must-see attractions to hidden gems, Tourism Guiding offers personalized recommendations tailored to your interests and preferences. With detailed maps, insider tips, and real-time updates, you'll navigate unfamiliar territories like a pro. Say goodbye to travel stress and hello to unforgettable experiences with Tourism Guiding in your pocket. Download now and let the journey begin!👍",
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'MadimiOne',
                color: Color.fromARGB(255, 22, 23, 82),
                //fontWeight: FontWeight.bold,
              )),
        ));
  }
}
