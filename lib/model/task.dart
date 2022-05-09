import 'package:flutter/material.dart';

class Task
{
  String? id;
  String? taskname;
  String? taskdescription;
  DateTime taskdate;
  TimeOfDay? starttime;
  TimeOfDay? endtime;
  String status="notdone";

  Task({this.id,this.taskname,this.taskdescription,required this.taskdate,this.starttime,this.endtime});

}