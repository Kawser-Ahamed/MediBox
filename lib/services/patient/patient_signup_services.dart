import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medibox/constant/app_color.dart';
import 'package:medibox/pages/homepage.dart';
import 'package:medibox/pages/patient/screens/patient_homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PatientSignupService{
  static bool isLoading = false;
  static Future<void> patientSignUp(String email,String password,String confirmPassword,String name,String age,String address,String hospital,String ward) async{
    DateTime currentTime = DateTime.now();
    int miliSecond = currentTime.microsecondsSinceEpoch;
    if(email.isEmpty || password.isEmpty || confirmPassword.isEmpty || name.isEmpty || age.isEmpty || address.isEmpty || hospital.isEmpty || ward.isEmpty){
      Get.snackbar('MediBox', 'Please fill all the information', 
        backgroundColor: AppColor.mainColor,
        colorText: Colors.black,
        duration: const Duration(seconds: 2),
      );
    }
    else if(password != confirmPassword){
      Get.snackbar('MediBox', 'Password & Confirm password are not same',
        backgroundColor: AppColor.mainColor,
        colorText: Colors.black,
        duration: const Duration(seconds: 2),
      );
    }
    else{
      try{
        isLoading = true;
        final auth = FirebaseAuth.instance;
        UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, 
          password: password
        ); 
        userCredential.user!.sendEmailVerification();
        final database = FirebaseDatabase.instance.ref('patient');
        database.child(miliSecond.toString()).set({
          'Patient Id' : miliSecond.toString(),
          'Patient Name' : name,
          'Age' : age,
          'Patient Email' :  email,
          'Address' : address,
          'Hospital Name' : hospital,
          'Ward No' : ward,
          'Nurse' : 'false',
        }).then((value) async{
          SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
          sharedPreferences.setString('patient-email', email);
          patientEmail = email;
          Get.to(const PatientHomePage());
        }).then((error){
          // ignore: avoid_print
          print(error);
        });
        final firestore = FirebaseFirestore.instance.collection(email);
        firestore.doc(miliSecond.toString()).set({
          'Patient Id' : miliSecond.toString(),
          'Patient Name' : name,
          'Age' : age,
          'Patient Email' :  email,
          'Address' : address,
          'Hospital Name' : hospital,
          'Ward No' : ward,
          'Nurse' : 'false',
        });
        FirebaseDatabase.instance.ref('Patient-Time-Scheduling').child(miliSecond.toString()).update({
          'buzzer' : "on",
          "led" : "on",
        });
        
      } on FirebaseAuthException catch (e){
        if(e.code == 'weak-password'){
          Get.snackbar('MediBox', 'Weak Password',
           backgroundColor: AppColor.mainColor,
           colorText: Colors.black,
           duration: const Duration(seconds: 2),
          );
        }
        else if(e.code == 'email-already-in-use'){
          Get.snackbar('MediBox', 'Email already in used',
            backgroundColor: AppColor.mainColor,
            colorText: Colors.black,
            duration: const Duration(seconds: 2),
          );
        }
      } catch (error) {
        Get.snackbar('Error', 'MediBox Server is Down',
          backgroundColor: AppColor.mainColor,
          colorText: Colors.black,
          duration: const Duration(seconds: 2),
        );
      }finally{
        isLoading = false;
      }
    }
  }
}