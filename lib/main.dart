import 'package:dailytaskplanner/newtask.dart';
import 'package:dailytaskplanner/tasklist.dart';
import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
import './model/task.dart'; 
import './taskprogress.dart';
import './Form/aboutapp.dart';
import './Form/enquiry.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


void main()=>runApp(MaterialApp(home: MyApp())); 
class MyApp extends StatefulWidget { 
  _MyAppState createState()=>_MyAppState();
  
}

  class _MyAppState extends State<MyApp>  {
    String uri="https://www.ttesmyanmar.com/api/taskprocess";
    late FlutterLocalNotificationsPlugin notifyplugin;
    void initState(){
      super.initState();  
      var androidIntialize = new AndroidInitializationSettings("app_icon");
      var iosIntialize=new IOSInitializationSettings();
      var initializationsetting= new InitializationSettings(
        android: androidIntialize, iOS: iosIntialize);
      notifyplugin = new FlutterLocalNotificationsPlugin();
      notifyplugin.initialize(initializationsetting);
      getTaskData("");
    }
    Future displayNotification(String taskdate, String starttime, String taskname, String taskdescription) async{

        var androidDetail=new AndroidNotificationDetails("My App", "Notification", "");
        var iosDetail=new IOSNotificationDetails();
        var generalnotification= new NotificationDetails(android: androidDetail,iOS: iosDetail);
        var tmp=taskdate.split(" ");
        var scheduletime=tmp[0]+" "+starttime+":00";
        notifyplugin.schedule(1, taskname, taskdescription, DateTime.parse(scheduletime), generalnotification);
    }

    void getTaskData(String response) async
    {
      tasklist.clear();
      if(response=="")
      {
        // response null url data fetch
        response= await getRequest(uri);
      }
       
      final list =jsonDecode(response)as List;
      list.forEach((element) {
        Map<String, dynamic> datatamp=element;

        TimeOfDay _time1=new TimeOfDay(hour:int.parse(datatamp["starttime"].split(":")[0]), minute: int.parse(datatamp["starttime"].split(":")[1]));

        TimeOfDay _time2=new TimeOfDay(hour:int.parse(datatamp["endtime"].split(":")[0]), minute: int.parse(datatamp["endtime"].split(":")[1]));


        Task t=new Task(
        id:datatamp["id"].toString(),
        taskname:datatamp["taskname"],
        taskdescription:datatamp["taskdescription"],
        taskdate: DateTime.parse(datatamp["taskdate"]),
        starttime: _time1,
        endtime: _time2,

        );
        setState(() {
          tasklist.add(t);
        });
        

      });
      // print(response);

    }

    void sendTaskToHttpServer(String ataskname,String ataskdescription,String ataskDate,String astarttime,String aendtime) async
    {
       DateTime tdate=DateTime.parse(ataskDate);
      Map<String, dynamic> data={
        "taskname": ataskname,
        "taskdescription": ataskdescription,
        "taskdate": tdate.toIso8601String(),
        "starttime": astarttime,
        "endtime": aendtime
      };
      String response= await postRequest(uri, data);
      getTaskData(response);
      // print(response);

    }
// GetPost->sever ko connect
  Future<String> getRequest(String uri) async {
    String reply = "";

    try {
      HttpClient httpClient = new HttpClient();
      HttpClientRequest request = await httpClient.getUrl(Uri.parse(uri));
      request.headers.set('Content-Type', 'application/json;charset=UTF-8');
      request.headers.set('Accept', 'application/json');
      HttpClientResponse response = await request.close();

      if (response.statusCode == 200 || response.statusCode == 201)
        reply = await response.transform(utf8.decoder).join();

      httpClient.close();
    } catch (e) {}

    return reply;
  }
// Post Request
  Future<String> postRequest(String uri, Map jsonMap) async {
    String reply = "";

    try {
      await http
          .post(Uri.parse(uri),
              headers: {
                'Accept': 'application/json',
              },
              body: jsonMap)
          .then((http.Response response) {
        reply = response.body.toString();
    });
    } catch (ex) {
      print(ex);
    }

    return reply;
  }
// ========================================

  int _totaltaskdone=0;
  int _totaltask=0;
  double percent=0.0;
  String percentText="0%";
  // int _removeindex=0;

   List<Task> tasklist=[
    // new Task(
    //   id:"1",
    //   taskname:"Teach Flutter",
    //   taskdescription: "ABCDFEFF",
    //   taskdate: DateTime.now(),
    //   starttime: TimeOfDay(hour: 11,minute: 0),
    //    endtime: TimeOfDay(hour: 12,minute: 0) 
    //    ),
    //   new Task(
    //   id:"2",
    //   taskname:"Flutter Exercise",
    //   taskdescription: "ABCDFEFF",
    //   taskdate: DateTime.now(), 
    //   starttime: TimeOfDay(hour: 11,minute: 0),
    //    endtime: TimeOfDay(hour: 12,minute: 0)
    //    ),
  ];
  addNewTask(String ataskname,String ataskdescription,String ataskDate,String astarttime,String aendtime )
  {
      print("Maung");
      String aid=autoID();
       DateTime tdate=DateTime.parse(ataskDate);
         int _stimeHr=int.parse(astarttime.split(":")[0]);
            int _stimrMin=int.parse(astarttime.split(":")[1]);
                TimeOfDay _time1=new TimeOfDay(hour: _stimeHr, minute: _stimrMin);
                TimeOfDay _time2=new TimeOfDay(hour:int.parse(aendtime.split(":")[0]), minute: int.parse(aendtime.split(":")[1]));




      Task newTask=new Task(
        id:aid,
        taskname: ataskname,
        taskdescription: ataskdescription,
        taskdate: tdate,
        starttime: _time1,
        endtime: _time2
      );
      setState(() {
        tasklist.add(newTask);

        displayNotification(tdate.toString(), astarttime.toString(), ataskname, ataskdescription);
      });
      progressUpdate();
      fillingpercentage();
      

  }

  void fillingpercentage(){
    setState(() { 
      double percentadd=(100/_totaltask)*_totaltaskdone;
        percent=percentadd/100;
        percentText=(percentadd).toString()+" % "; 
    });
  }

  void completeTask(String taskid)
  {
    // var taskrecord=tasklist.firstWhere((t) => t.id==taskid);
    var listindex=tasklist.indexWhere((taskitem) => taskitem.id==taskid);
    setState(() {
      tasklist[listindex].status="done";
      _totaltaskdone=tasklist.where((element) => element.status=="done").toList().length;
    });
    progressUpdate();
    fillingpercentage();
  }

  void deleteTask(String? removeid){
    
      // tasklist.removeAt(removeindex);

      // int removeindex=0;
      // for (int i=0; i<tasklist.length; i++)
      // {
      //   var t=tasklist[i];
      //   if (t.id==removeid)
      //   {
      //     removeindex=i;
      //     break;
      //   }
      // }
      setState(() {
        // tasklist.removeAt(removeindex);
        tasklist.removeWhere((taskobject) => taskobject.id==removeid);
      });
      progressUpdate();
      fillingpercentage();
  
   
  }

  void progressUpdate() {
    setState(() {
      _totaltask = tasklist.length;
      _totaltaskdone =
          tasklist.where((element) => element.status == "done").toList().length;
    });
  }
  
  String autoID(){
   if (tasklist.length>0)
   {
      String id=tasklist[tasklist.length-1].id.toString();
      return (int.parse(id)+1).toString();
   }
   else
   {
     return "1";
   }  
       
     
  }
  void browseToOtherForm(BuildContext context,int index){
    Navigator.of(context).pop();
    var form;
    switch (index){
      case 0:
      form= Enquiry();
      break;
      case 1:
      form=AboutApp();
      
    }
    if (form != null){
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>form));
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:ThemeData(
        textTheme: TextTheme(
          headline1: TextStyle(
            fontSize: 25,
            fontStyle: FontStyle.italic,
            fontFamily: 'Courier New',
          )),
          elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(primary: Colors.red.shade200)),
      ),
      home:Scaffold(
        drawer: Drawer(
          child:ListView(
            // padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
              //   margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
              //   child:Container(
              //   height: 135,
              //   width:MediaQuery.of(context).size.width,
              //   child: Image.asset("images/app_icon.png"),
              // ),
              // decoration:BoxDecoration(
              //   color: Colors.red, 
              //   shape: BoxShape.circle,
              //   image: DecorationImage(image: AssetImage("images/app_icon.png",),)
              //   )
              decoration:BoxDecoration(
                gradient: LinearGradient(
                  colors:<Color>[Colors.deepOrange,Colors.orangeAccent] ),
                ),
              child:Container(
                child: Column(
                   children:<Widget> [
                    Material(
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      elevation: 10,
                      child: Padding(padding: EdgeInsets.all(8.0),
                      child: Image.asset("images/app_icon.png",width: 80,height: 80,),),
                      
                    ),
                    Padding(padding: EdgeInsets.all(5.0),
                    child: Text("Maung Win",style: TextStyle(color: Colors.black,fontSize: 20),),)
                  ],
                ),
              ),


                ),
              


              ListTile(
                leading: Icon(Icons.ad_units_outlined),
                title: Text("Enquiry"),
                onTap: (){
                  // Navigator.of(context).pop();
                  // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Enquiry()));
                  browseToOtherForm(context, 0);
                },
              ),
              ListTile(
                leading: Icon(Icons.format_shapes_outlined),
                title: Text("About App"),
                onTap: (){
                  browseToOtherForm(context, 1);
                },
              ),
              
            ],
          )
        ),
        appBar: AppBar(title: Text("Task Planner"),),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Progress Area
              
                TaskProgress(_totaltask,_totaltaskdone,percent,percentText),
               //New Task Area
               NewTask(sendTaskToHttpServer),
                // Registration Area
              
                // All task area
              TaskList(tasklist,deleteTask,completeTask),
            ],
          ),
        ),
      ),
    );
      
  
  }
}