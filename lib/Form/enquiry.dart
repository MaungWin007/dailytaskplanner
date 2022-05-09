import 'package:dailytaskplanner/main.dart';
import 'package:flutter/material.dart';

class Enquiry extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Enquiry Form"),),
        body:Column(
        children: [
          Text("Enquiry Form"),
          ElevatedButton(onPressed: (){  
            // Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MyApp()));
          },
           child: Text("Back to Main Form")),
           
        ],
      ),
      ),
    );
  }
}
