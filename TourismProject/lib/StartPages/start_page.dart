import 'dart:async';
import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';


String? finalEmail;


class Startpage extends StatefulWidget {
  const Startpage({super.key});

  @override
  State<Startpage> createState() => startpage();
}

class startpage extends State<Startpage> {
  @override
  void initState() {
    getValidationData().whenComplete(() async{
      Timer(Duration(seconds: 2), () => Navigator.pushNamed(context, finalEmail==null ? 'login': 'homepage'));
    });
    super.initState();
  }

  Future getValidationData() async{
    final SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    var OptainedEmail =sharedPreferences.getString('email');
    setState(() {
      finalEmail=OptainedEmail;
    });
    print(finalEmail);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.black,
            image: DecorationImage(
              image: AssetImage("images/7.jpg"),
              fit: BoxFit.cover,
              opacity: 0.5,
            )),
        child: Column(
          // Padding(
          // padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 250),
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "TOURISM GUIDING",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'MadimiOne'),
            )
          ],
        ),
      ),
      //)
    );
  }
}
