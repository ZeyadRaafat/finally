import "package:flutter/material.dart";

class Emotionsface extends StatelessWidget {
  final String emotionsface;
  const Emotionsface({super.key, required this.emotionsface});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color.fromARGB(178, 221, 230, 236),
          borderRadius: BorderRadius.circular(12)),
      padding: EdgeInsets.all(15),
      child: Center(
        child: Text(
          emotionsface,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
