import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medibox/constant/app_color.dart';
import 'package:medibox/pages/patient/screens/patient_homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PatientEditProfileServicees{
  static Future<void> update(String phone,String doctorName,String medicalHistory,String gender) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var email = sharedPreferences.getString('patient-email');
    if(phone.isEmpty || doctorName.isEmpty || medicalHistory.isEmpty || gender.isEmpty){
      Get.snackbar('MediBox', 'Please fill all the information', 
        backgroundColor: AppColor.mainColor,
        colorText: Colors.black,
        duration: const Duration(seconds: 2),
      );
    }
    else{
      try{
        final firestore = FirebaseFirestore.instance.collection(email.toString());
        firestore.doc(userId).update({
          'Mobile Number' : phone,
          'Doctor Name' : doctorName,
          'Medical History' : medicalHistory,
          'Gender' : gender,
        });
        final database  = FirebaseDatabase.instance.ref('patient');
        database.child(userId).update({
          'Mobile Number' : phone,
          'Doctor Name' : doctorName,
          'Medical History' : medicalHistory,
          'Gender' : gender,
        });
        Get.to(const PatientHomePage());
      }
      catch(e){
        // ignore: avoid_print
        print(e);
      }
    }
  }
}