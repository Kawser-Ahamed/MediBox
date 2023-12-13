// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medibox/constant/my_text.dart';

class TimeScheduleProvider{
  TimeOfDay currentTime = TimeOfDay.now();
  Future<void> setTime(BuildContext context,String firebaseKey,String patientId) async{
    TimeOfDay? selectedTime = await showTimePicker(
      context: context, 
      initialTime: currentTime,
      helpText: 'Set time schedule for patient',
    );
    if(selectedTime!=null){
      currentTime = selectedTime;
    }
    // int hour = currentTime.hour,minute2 = currentTime.minute;
    // String minute = '';
    // if(minute2.toString().length<2){
    //   minute = '0';
    // }
    // minute+=minute2.toString();
    // if(currentTime.hour == 12 || currentTime.hour==0){
    //   hour+=12;
    // }
    print('12 hour time: ${currentTime.format(context)}');
    //print('24 hour time: $hour:$minute');
    showMyDialog(context,firebaseKey,patientId,currentTime);
  }

  showMyDialog(BuildContext context,String firebaseKey,String patientId,TimeOfDay currentTime){
    return showDialog(
      context: context, 
      builder: (context) {
        return AlertDialog(
          title: MyText(text: 'Time Sheduling', size: 60.sp, overflow: false, bold: true, color: Colors.black),
          content: MyText(text: 'Are you sure, you want to set time ${currentTime.format(context)} for $firebaseKey', size: 50.sp, overflow: false, bold: false, color: Colors.black),
          actions: [
            TextButton(
              onPressed: (){
                Navigator.pop(context);
              },
               child: MyText(text: 'No', size: 50.sp, overflow: false, bold: false, color: Colors.red),
            ),
            TextButton(
              onPressed: (){
                FirebaseDatabase.instance.ref('Patient-Time-Scheduling').child(patientId).update({
                  firebaseKey : currentTime.format(context).toString(),
                }).then((value) => Navigator.pop(context)).catchError((error)=>print(error));
              },
               child: MyText(text: 'Yes', size: 50.sp, overflow: false, bold: false, color: Colors.green),
            ),
          ],
        );
      },
    );
  }
}