import 'package:flutter/material.dart';
import './uiutil/datepicker.dart';
import './uiutil/timepicker.dart';
class NewTask extends StatefulWidget {
  
  Function addtransaction;
  NewTask(this.addtransaction);

  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  var _tasknametextcontroller=new TextEditingController();

  var _taskdescriptiontextcontroller=new TextEditingController();

  var _taskdatecontroller=new TextEditingController();

  var _starttimecontroller=new TextEditingController();

  var _endtimecontroller=new TextEditingController(); 

  void clearText(){
    
    _tasknametextcontroller.clear();
    _taskdescriptiontextcontroller.clear();
    _taskdatecontroller.clear();
    _starttimecontroller.clear();
    _endtimecontroller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
                child: Card(
                  child: Column(
                    children: [
                      Text("Registration Form"),
                      
                      TextField(
                        decoration: InputDecoration(labelText: "TextName:"),
                        controller: _tasknametextcontroller,
                      ),
                      TextField(
                        decoration: InputDecoration(labelText: "Description:"),
                        controller: _taskdescriptiontextcontroller,
                      ),
                   
                        DatePicker(_taskdatecontroller),
                        TimePicker("Start Time",_starttimecontroller),TimePicker("End Time",_endtimecontroller),
                      // TextField(
                      //   decoration: InputDecoration(labelText: "Start Time:"),
                      //   controller: _starttimecontroller,
                      // ),
                      // TextField(
                      //   decoration: InputDecoration(labelText: "End Time:"),
                      //   controller: _endtimecontroller,
                      // ),
                      //()execute method  directly
                      // without ()method will work when user click button
                      ElevatedButton(onPressed: (){                 
                        widget.addtransaction(
                          
                          _tasknametextcontroller.text,
                          _taskdescriptiontextcontroller.text,
                          _taskdatecontroller.text,
                          _starttimecontroller.text,
                          _endtimecontroller.text);
                          clearText();
                          //fillingpercentage();
                          },
                         
                      child: Text("Add Button "))
                    ],
                    
                  ),
                ),
                
                );
  }
}