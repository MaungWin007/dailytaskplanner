import 'package:flutter/material.dart';

class AboutApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Enquiry Form"),),
        body:Column(
        children: [
          Text("Enquiry Form"),
          ElevatedButton(onPressed: null,
           child: Text("Back to Main Form"))
        ],
      ),
      ),
    );
  }
}