import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';
class TaskProgress extends StatelessWidget {
  int _totaltaskdone=0;
  int _totaltask=0;
  double percent=0.0;
  String percentText="0%";
  TaskProgress(this._totaltask,this._totaltaskdone,this.percent,this.percentText);

  @override
  Widget build(BuildContext context) {
    return Container(
                width: double.infinity,
                height: 140,
                child: Card(child: Column(
                  children: [
                    Text("Progress(${DateFormat("yyyy-MM-dd").format(DateTime.now())})"),
                    Container(
                      margin: EdgeInsets.all(15),
                      
                        child: new LinearPercentIndicator(
                                      
                                      lineHeight: 20.0,
                                      percent: percent,
                                      center: Text(percentText),
                                      backgroundColor: Colors.grey,
                                      progressColor: Colors.blue,
                                    ),
                      
                    ),
                    Row(children: [
                  Text("Text Complete:$_totaltaskdone"),
                  Text("Total Task:$_totaltask")
                ],)
                  ],
                )),
                
                );
  }
}