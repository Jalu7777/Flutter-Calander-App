// import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_calender/database/dbhelper.dart';
import 'package:flutter_calender/screen/home.dart';
import 'package:flutter_calender/utils/preferences.dart';

import 'dart:developer' as s1;

import '../model/event.dart';
import '../utils/formatdate.dart';

// ignore: must_be_immutable
class Selectevent extends StatefulWidget {
  final String label;
  Event? event;
   Selectevent({super.key,required this.label,this.event});

  @override
  State<Selectevent> createState() => _SelecteventState();
}

class _SelecteventState extends State<Selectevent> {
  TextEditingController titleController = TextEditingController();
  bool allDay = false;
  bool error = false;
  bool error1 = false;
  late DateTime fromDate;
  late DateTime toDate;
  late DBHelper dbHelper;
  List<Event> event = [];
  List<Map<String,dynamic>> l1=[
    {
      'icons':Icons.circle_outlined,
      'color':'0xffeb5137',
      'title':"Tomato",
      'label':false
    },
    {
      'icons':Icons.circle_outlined,
      'color':'0xffe56c3c',
      'title':"Tangerine",
      'label':false
    },
    {
      'icons':Icons.circle_outlined,
      'color':'0xffecbd57',
      'title':"Banana",
      'label':false
    },
    {
      'icons':Icons.circle_outlined,
      'color':'0xffae63c2',
      'title':"Grape",
      'label':false
    },
    {
      'icons':Icons.circle_outlined,
      'color':'0xffd68579',
      'title':"Flamingo",
      'label':false
    },
    {
      'icons':Icons.circle_outlined,
      'color':'0xff4f99d3',
      'title':"Peacock",
      'label':false
    },
    {
      'icons':Icons.circle_outlined,
      'color':'0xff7674c6',
      'title':"Bluebarry",
      'label':false
    },
    {
      'icons':Icons.circle,
      'color':'0xff538d5b',
      'title':"Default color",
      'label':false
    }
  ];
  int index=0;
  int? id;

  @override
  void initState() {
    super.initState();
    s1.log("init");
    dbHelper = DBHelper();
    if(widget.event==null){
      setDateTimeNow();
      print("hello");
    }
    else{

      final event=widget.event!;
      titleController.text=event.title.toString();
      fromDate=DateTime.parse(event.fromDate.toString());
      toDate=DateTime.parse(event.toDate.toString());
      id=event.id;
      // getCOlorTitile();
      
    }
    
  
  }

// getCOlorTitile()async{
//   Event.colorTitle=await Preferences.getPref('colorTitle');
//   s1.log('get ${Event.colorTitle}');
//   setState(() {    
//   });
// }


  Future<dynamic> customDialog(BuildContext context, String content) {
    return showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              content: Text(
                content,
                style: const TextStyle(fontSize: 18),
              ),
              // contentPadding: EdgeInsets.zero,
              titlePadding: EdgeInsets.zero,
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("OK"))
              ],
            ));
  }

  

  setDateTimeNow() {
    setState(() {
      fromDate = DateTime.now();

      toDate = DateTime.now().add(const Duration(minutes: 30));
    });
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        if(widget.label=="save"){
                          
                          
                          Navigator.pop(context);
                        }
                        else{
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (ctx)=>const Home()), (route) => false);
                          }
                      } ,
                      icon: const Icon(
                        Icons.close,
                        size: 30,
                      )),
                  GestureDetector(
                    onTap: () async {
                      s1.log(error.toString());
                      if (titleController.text.toString().isEmpty) {
                        customDialog(context, "Title should not be empty");
                      } else if (error == true) {
                        customDialog(context,
                            "The end time must be after the start time");
                      } else if (error1 == true) {
                        customDialog(context,
                            "The end date must be after the start date or equal to start date");
                      } else {
                        s1.log("valid");
                        // print('color code= ${l1[index]['title']}');

                        // widget.event==null?

                        dbHelper.insert(Event(
                            title: titleController.text,
                            fromDate: fromDate.toString(),
                            toDate: toDate.toString(),
                            background: 
                            l1[index]['label']==true?
                            
                            l1[index]['color']:
                            
                            l1.last['color'],

                            colorTitle: 
                            
                            l1.last['title'],
                            
                            ),
                             
                            
                            );
                            Navigator.pop(context);
                        //     :

                        // dbHelper.update(Event(
                        //   // id: id,
                        //   title: titleController.text, fromDate: fromDate.toString(), toDate: toDate.toString())).then((value){
                        //     s1.log('id ${value.toString()}');
                        //   });

                            
                            

                       
                      }
                    },
                    child: Container(
                        height: 30,
                        width: 60,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Color(0xff89d0ec)),
                        child:  Center(
                          child: Text(
                            widget.event==null?
                            "Save":"Update",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        )),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: titleController,
              style: const TextStyle(fontSize: 25),
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 30),
                hintText: "Add Title",
              ),
            ),
            const Divider(
              thickness: 2,
              color: Color(0xff2f3336),
            ),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              leading: const Icon(Icons.access_time_rounded),
              title: const Text("All Day"),
              trailing: Switch(
                  activeColor: const Color(0xff89d0ec),
                  inactiveThumbColor: Colors.grey,
                  value: allDay,
                  onChanged: (value) {
                    setState(() {
                      allDay = value;
                      s1.log(allDay.toString());
                    });
                  }),
            ),
            const SizedBox(
              height: 10,
            ),
            ListTile(
                leading: error == true || error1 == true
                    ? const Icon(
                        Icons.error,
                        color: Color(0xfff1ada7),
                      )
                    : const Text(""),
                tileColor: error == true || error1 == true
                    ? const Color(0xff62403f)
                    : null,
                contentPadding: const EdgeInsets.only(left: 15, right: 30),
                title: GestureDetector(
                    onTap: () async {
                      s1.log("fromdatecalled");
                      final pickdate = await showDatePicker(
                          context: context,
                          initialDate: fromDate,
                          firstDate: DateTime(2015),
                          // firstDate:  DateTime.now().subtract(const Duration(days: 0)),
                          lastDate: DateTime(2101));

                      if (pickdate != null) {
                        setState(() {
                          fromDate = pickdate;
                          error = false;
                          final beDate = DateTime(
                              fromDate.year, fromDate.month, fromDate.day);
                          final afDate =
                              DateTime(toDate.year, toDate.month, toDate.day);
                          s1.log(beDate.toString());
                          s1.log(afDate.toString());
                          s1.log(error1.toString());
                          if (error1 == true && beDate.isAfter(toDate)) {
                            final current = DateTime.now();

                            fromDate = DateTime(fromDate.year, fromDate.month,
                                fromDate.day, current.hour, current.minute);

                            toDate = DateTime(toDate.year, toDate.month,
                                    toDate.day, current.hour, current.minute)
                                .add(const Duration(minutes: 25));
                            s1.log(toDate.toString());
                          } else if (error1 == true &&
                              beDate.isBefore(toDate)) {
                            final current = DateTime.now();

                            fromDate = DateTime(fromDate.year, fromDate.month,
                                fromDate.day, current.hour, current.minute);

                            toDate = DateTime(toDate.year, toDate.month,
                                    toDate.day, current.hour, current.minute)
                                .add(const Duration(minutes: 25));
                            s1.log(toDate.toString());
                            error1 = false;
                          } else if (beDate.isAfter(afDate)) {
                            s1.log("after");

                            final current = DateTime.now();
                            fromDate = fromDate.add(Duration(
                                hours: current.hour, minutes: current.minute));
                            toDate = DateTime(fromDate.year, fromDate.month,
                                    fromDate.day, current.hour, current.minute)
                                .add(const Duration(minutes: 30));
                            s1.log(toDate.toString());
                          } else if (beDate.isBefore(afDate)) {
                            s1.log("before");
                            final current = DateTime.now();
                            fromDate = DateTime(fromDate.year, fromDate.month,
                                fromDate.day, current.hour, current.minute);
                            toDate = DateTime(fromDate.year, fromDate.month,
                                    fromDate.day, current.hour, current.minute)
                                .add(const Duration(minutes: 30));
                            error1 = false;
                          } else {
                            s1.log("else called");
                            s1.log(beDate.toString());
                            s1.log(afDate.toString());

                            final current = DateTime.now();

                            fromDate = DateTime(fromDate.year, fromDate.month,
                                fromDate.day, current.hour, current.minute);
                            toDate = DateTime(fromDate.year, fromDate.month,
                                    fromDate.day, current.hour, current.minute)
                                .add(const Duration(minutes: 25));

                            error1 = false;
                          }
                        });
                      }
                    },
                    child: Text(FormatDate.toDate(fromDate),
                        style: const TextStyle(fontSize: 18))),
                trailing: GestureDetector(
                  onTap: () async {
                    s1.log("fromtimecalled");
                    final picktime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(fromDate));

                    if (picktime != null) {
                      DateTime date =
                          DateTime(fromDate.year, fromDate.month, fromDate.day);
                      Duration time = Duration(
                          hours: picktime.hour, minutes: picktime.minute);
                      s1.log(time.toString());
                      setState(() {
                        // date.add(time);

                        fromDate = date.add(time);
                        if (fromDate.isAfter(toDate)) {
                          // error=false;
                          toDate = fromDate.add(const Duration(minutes: 30));
                          s1.log(toDate.toString());
                          s1.log("bye");
                        } else {
                          // error=false;
                          toDate = fromDate.add(const Duration(minutes: 30));
                          s1.log("innn");
                        }
                      });
                    }
                  },
                  child: Text(FormatDate.toTime(fromDate),
                      style: const TextStyle(fontSize: 18)),
                )),
            ListTile(
                leading: const Text(""),
                contentPadding: const EdgeInsets.only(left: 15, right: 30),
                title: GestureDetector(
                    onTap: () async {
                      final pickdate = await showDatePicker(
                        context: context,
                        initialDate: toDate,
                        firstDate: DateTime(2015),
                        lastDate: DateTime(2101),
                        // selectableDayPredicate: (val) => val==? false : true,
                      );

                      if (pickdate != null) {
                        setState(() {
                          toDate = pickdate;
                          error = false;
                          final beDate = DateTime(
                              fromDate.year, fromDate.month, fromDate.day);
                          final afDate =
                              DateTime(toDate.year, toDate.month, toDate.day);
                          s1.log(beDate.toString());
                          s1.log(afDate.toString());

                          if (afDate.isBefore(beDate)) {
                            s1.log("after if");
                            toDate = DateTime(toDate.year, toDate.month,
                                    toDate.day, fromDate.hour, fromDate.minute)
                                .add(const Duration(minutes: 30));
                            error1 = true;
                          } else if (afDate.isAfter(beDate)) {
                            error1 = false;
                            s1.log("after else if");

                            toDate = DateTime(toDate.year, toDate.month,
                                    toDate.day, fromDate.hour, fromDate.minute)
                                .add(const Duration(minutes: 30));
                          } else {
                            s1.log("else");
                            error1 = false;
                            toDate = DateTime(toDate.year, toDate.month,
                                    toDate.day, fromDate.hour, fromDate.minute)
                                .add(const Duration(minutes: 30));
                          }
                          // }
                        });
                      }
                    },
                    child: Text(FormatDate.toDate(toDate),
                        style: const TextStyle(fontSize: 18))),
                trailing: GestureDetector(
                    onTap: () async {
                      final picktime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.fromDateTime(toDate));

                      if (picktime != null) {
                        DateTime date =
                            DateTime(toDate.year, toDate.month, toDate.day);
                        Duration time = Duration(
                            hours: picktime.hour, minutes: picktime.minute);
                        s1.log(time.toString());
                        setState(() {
                          // date.add(time);

                          toDate = date.add(time);
                          if (toDate.isBefore(fromDate)) {
                            s1.log("hello");
                            error = true;
                          } else {
                            error = false;
                          }
                        });
                      }
                    },
                    child: Text(FormatDate.toTime(toDate),
                        style: const TextStyle(fontSize: 18)))),
            const Divider(
              thickness: 2,
              color: Color(0xff2f3336),
            ),
            const SizedBox(
              height: 10,
            ),

              
                 ListTile(
                  
            
                  // selected: l1[i]['label']==true,
                // minVerticalPadding: 0,//it reduce or increase padding between title and subtitle
                // visualDensity: VisualDensity(horizontal: 0,vertical: -4),//it reduce and increase padding between listtile property->title,leadingetc
                onTap: () {
                  
                  showDialog(context: context, builder:(ctx)=>
                   SimpleDialog(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    // contentPadding: EdgeInsets.zero,
                    children: [
                      SizedBox(
                        // height: 200,
                        width:MediaQuery.of(context).size.width,
                       
                        child: ListView.builder(
                          shrinkWrap: true,
                          
                          itemCount: l1.length,
                          itemBuilder: (ctx,index)=>
                        
                        ListTile(
                          selected: l1[index]['label']=true,
                          onTap: (){
                            setState(() {
                              // l1[index]['label']=!l1[index]['label'];
                              this.index=index;
                              
                              
                              // print('hello $value');

                              Navigator.pop(context);
                            });
                          },
                          leading: Icon(l1[index]['icons'],color: Color(int.parse(l1[index]['color']))),
                          title: Text(l1[index]['title']),
                        )
                        
                        ),
                      )
                    ],
                  )
                  );
                  
                },
                leading: l1[index]['label']==true?
                
                Icon(Icons.circle,color:Color(int.parse(l1[index]['color']))): 
                widget.event==null?
                Icon(Icons.circle,color: Color(int.parse(l1.last['color']))):Icon(Icons.circle,color: Color(int.parse(widget.event!.background.toString()))),
                title: l1[index]['label']==true?
                
                Text(l1[index]['title']):
                widget.event==null?
                Text(l1.last['title']):
                Text(widget.event!.colorTitle.toString())
                          ),
                        const Divider(
              thickness: 2,
              color: Color(0xff2f3336),
            ),
          ],
        ),
      ),
    );
  }
}
