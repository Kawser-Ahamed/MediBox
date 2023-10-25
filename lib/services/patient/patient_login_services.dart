import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medibox/constant/app_color.dart';
import 'package:medibox/pages/homepage.dart';
import 'package:medibox/pages/patient/screens/patient_homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PatientLoginService{
  static bool isLoading = false;
  static Future<void> patientLogin(String email,String password) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance(); 
    final auth = FirebaseAuth.instance;
    if(email.isEmpty || password.isEmpty){
      Get.snackbar('MediBox', 'Please fill all information',
          backgroundColor: AppColor.mainColor,
          colorText: Colors.white,
      );
    }
    else{
      try{
        isLoading = true;
        await auth.signInWithEmailAndPassword(
          email: email, 
          password: password
        ).then((value){
          patientEmail = email;
          Get.to(const PatientHomePage());
          sharedPreferences.setString('patient-email', email);
        });
      } on FirebaseAuthException catch(e){
        if(e.code == 'user-not-found'){
          Get.snackbar('MediBox', 'Your Email Is Incorrect',
          backgroundColor: AppColor.mainColor,
          colorText: Colors.white,
          );
        }
        else if(e.code == 'wrong-password'){
          Get.snackbar('MediBox', 'Your Password Is Wrong',
          backgroundColor: AppColor.mainColor,
          colorText: Colors.white,
          );
        }
      } catch(e){
        // ignore: avoid_print
        print(e);
      }finally{
        isLoading = false;
      }
    }
  }
}