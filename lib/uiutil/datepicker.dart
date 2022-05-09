import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget {
  TextEditingController _datecontroller=new TextEditingController();
  DatePicker(this._datecontroller);

  @override
  _DatePickerState createState() => _DatePickerState();
}
 
class _DatePickerState extends State<DatePicker> {
  
  void _displayDatePicker(){
        showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate:DateTime(2021),
          lastDate: DateTime.now()).then((value){
            setState(() {
              if (value==null){
                widget._datecontroller.text=DateFormat("yyyy-MM-dd").format(DateTime.now());
              }
              else{
                widget._datecontroller.text=DateFormat("yyyy-MM-dd").format(value);
              }
            });
          }
        );
      }
  @override
  Widget build(BuildContext context) {
    return Row(
                children:[
                        Flexible(child:
                        TextField(
                          decoration: InputDecoration(labelText: "Text Date:"),
                          controller: widget._datecontroller,
                        )),
                        IconButton(onPressed:_displayDatePicker,
                        icon: Icon(Icons.calendar_today))
                        ] );
  }
}