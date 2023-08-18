import 'package:flutter/material.dart';
import 'package:flutter_calender/database/dbhelper.dart';
import 'package:flutter_calender/model/event.dart';
import 'package:flutter_calender/screen/selectevent.dart';
import 'package:flutter_calender/utils/formatdate.dart';

class ViewScreen extends StatelessWidget {
  final Event event;
  const ViewScreen({super.key,required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:  IconButton(
          onPressed:()=>Navigator.pop(context),
          icon:const Icon(Icons.close)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          
             
            //  SizedBox(width: 10,),
           Padding(
            padding:  const EdgeInsets.only(right: 10),
            child: Row(
              children: [
                 IconButton(
                  onPressed:(){
                    Navigator.push(context, MaterialPageRoute(builder: (ctx)=> Selectevent(label: "update",event: event)));
                  },
                  icon:const Icon(Icons.edit)),
                const SizedBox(width: 20,),
                IconButton(
          onPressed:(){
            DBHelper().delete(event.id!).then((value) {
              print(value);
            });
            Navigator.pop(context);
          },
          icon:const Icon(Icons.delete)),
                
              ],
            ),
          )
          
        
         
        ]
      ),
      
      body:  Column(
        children: [
          ListTile(
            leading: Icon(Icons.square_rounded,color: Color(int.parse(event.background.toString())),),
            title: Text(event.title.toString(),style: const TextStyle(
              fontSize: 30,
            ),),
          ),
          const SizedBox(
            height: 10,
          ),
           ListTile(
            leading: const Text("From",style:  TextStyle(
              fontSize: 20,
            )),
            trailing: Text(FormatDate.toDateTIme(DateTime.parse(event.fromDate.toString())),style: const TextStyle(
              fontSize: 15
            ),),
          ),
           ListTile(
            leading: const Text("To",style: TextStyle(
              fontSize: 20,
            )),
            trailing: Text(FormatDate.toDateTIme(DateTime.parse(event.toDate.toString())),style: const TextStyle(
              fontSize: 15
            ),),
          ),
        ],
      ),
    );
    
  }
}