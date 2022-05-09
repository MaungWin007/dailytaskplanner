import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

class TimePicker extends StatefulWidget {
  final timeText;
  final TextEditingController timeTextController;
  TimePicker(this.timeText,this.timeTextController);  

  @override
  _TimePickerState createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  TimeOfDay _current=TimeOfDay.now();
  TimeOfDay _selectedTime=TimeOfDay.now();
  Future<Null> pickTime(BuildContext context) async {
    _selectedTime= (await showTimePicker(context: context, initialTime: _current))!;
    
    
      setState(() {
        if(_selectedTime != null && _selectedTime !=_current){
        _current=_selectedTime;}
        widget.timeTextController.text=_current.toString().substring(10, 15);
      });
    
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          
          Flexible(child: TextField(decoration: InputDecoration(labelText:widget.timeText.toString() ),
          controller: widget.timeTextController,)),
          IconButton(onPressed:(){ pickTime(context);}, 
          icon: Icon(Icons.alarm))
        ],
      ),
      
    );
  }
}