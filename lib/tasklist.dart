import 'package:flutter/material.dart';
import './model/task.dart';
import 'package:intl/intl.dart';
class TaskList extends StatelessWidget {
Function _deleteTask,_completeTask;
final List<Task> _taskdatalist;
TaskList(this._taskdatalist,this._deleteTask,this._completeTask);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1000,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
         Container(
                    child: Column(
                      children: [
                        Text("Task List", style: Theme.of(context).textTheme.headline1,),
                        Card(
                          color:Colors.cyan.shade500,
                          child: Container(
                          height: 40,
                          child: Row(
                            children: [
                              Container(width:30,child: Center(child: Text(""))),
                              Container(width:30,child: Center(child: Text(""))),
                              Container(width:40,child: Center(child: Text("ID",style: TextStyle(color:Theme.of(context).accentColor,fontWeight: FontWeight.bold)))),
                              Container(width:100,child: Center(child: Text("Task",style: TextStyle(color:Theme.of(context).accentColor,fontWeight: FontWeight.bold)))),
                              Container(width:100,child: Center(child: Text("Description",style: TextStyle(color:Theme.of(context).accentColor,fontWeight: FontWeight.bold)))),
                              Container(width:80,child: Center(child: Text("Date",style: TextStyle(color:Theme.of(context).accentColor,fontWeight: FontWeight.bold)))),
                              Container(width:60,child: Center(child: Text("Start",style: TextStyle(color:Theme.of(context).accentColor,fontWeight: FontWeight.bold)))),
                              Container(width:60,child: Center(child: Text("End",style: TextStyle(color:Theme.of(context).accentColor,fontWeight: FontWeight.bold)))),
                            ],),
                        ),),
                        ..._taskdatalist.map((e) {
                          // _removeindex+=1;
                          
                          return Card(
                            color:Colors.cyan.shade500,
                            child: Row(
                              children: [
                                 Container(
                                   width: 30,
                                   child: IconButton(onPressed: (){
                                    _deleteTask(e.id);
                                }, 
                                icon: Icon(Icons.cancel),
                                color: Colors.red.shade600,),
                                 ),
                                Container(
                                  width: 30,
                                  child: IconButton(onPressed: (){
                                    _completeTask(e.id);
                                  }, 
                                  icon: Icon(Icons.check_circle),
                                  color: Theme.of(context).accentColor,),
                                ),
                                Container(
                                  width: 40,
                                  
                                  child: Center(
                                    child: Text(e.id.toString(),
                                    style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold),),
                                  ),
                                ),
                                Container(
                                  width: 100,
                                  child: Center(
                                    child: Text(e.taskname.toString(),
                                    style: TextStyle(color:Theme.of(context).accentColor,fontWeight: FontWeight.bold)
                                    ,))),
                                Container(
                                  width: 100,
                                  child: Center(child: Text(e.taskdescription.toString(), style: TextStyle(color:Theme.of(context).accentColor,fontWeight: FontWeight.bold)))),
                                
                                Container(
                                  width: 80,
                                  child: Center(child: Text(DateFormat('y/MM/d').format(e.taskdate),
                                  style: TextStyle(color:Theme.of(context).accentColor,fontWeight: FontWeight.bold)))),
                                Container(
                                  width: 60,
                                  child: Center(child: Text(e.starttime.toString().substring(10,15),
                                  style: TextStyle(color:Theme.of(context).accentColor,fontWeight: FontWeight.bold)))),
                                Container(
                                  width: 60,
                                  child: Center(child: Text(e.endtime.toString().substring(10,15),
                                  style: TextStyle(color:Theme.of(context).accentColor,fontWeight: FontWeight.bold)))),
                                // Container(child: Center(child: Text(e.status)))
                               
            
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
                    ),
      ],
        
      ),
    ) ;
  }
}