import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medibox/constant/app_color.dart';
import 'package:medibox/pages/homepage.dart';

class PatientAddByNurse{
  static Future<void> patientAdd(String id,String name,String email,String age,String address,String hospital,String ward,String doctorName,String history,String gender,String mobileNo) async{
    FirebaseFirestore.instance.collection('$nurseEmail-Patients').doc(email).set({
      'Patient Email' : email,
      'Patient Name' : name,
      'Age' : age,
      'Address' : address,
      'Hospital Name' : hospital,
      'Ward No' : ward,
      'Doctor Name' : doctorName,
      'Medical History' : history,
      'Gender' : gender,
      'Mobile No' : mobileNo,
    }).then((value) => {
      FirebaseFirestore.instance.collection(email).doc(id).update({
        'Nurse' : 'true',
      }).then((value) => {
        FirebaseFirestore.instance.collection('$email-Nurse').doc(nurseEmail).set({
          'Nurse Email' : nurseEmail,
        })
      }),
      Get.snackbar('MediBox', 'Patient add successfull',
          backgroundColor: AppColor.mainColor,
          colorText: Colors.white,
      )
    }).onError((error, stackTrace) => {
      Get.snackbar('', error.toString()),
    });
  }
}