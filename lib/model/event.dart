// import 'package:flutter/material.dart';

class Event{
   int? id;
   String? title;
   String? fromDate;
   String? toDate;
   String? background;
   bool? isAllDay;
   String? colorTitle;

  
  Event({
    required this.title,
    required this.fromDate,
    required this.toDate,
    this.id,
    this.background,
    this.isAllDay=false,
    this.colorTitle
});

//convert class object into map

Map<String,dynamic> toMap(){
  Map<String,dynamic> data={};
  data['id']=id;
  data['title']=title;
  data['fromDate']=fromDate;
  data['toDate']=toDate;
  data['background']=background;
  data['colorTitle']=colorTitle;
  return data;
}

Event.fromMap(Map<String,dynamic> data) {
id=data['id'];
title=data['title'];
fromDate=data['fromDate'];
toDate=data['toDate'];
background=data['background'];
colorTitle=data['colorTitle'];

}



}