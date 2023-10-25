import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medibox/constant/app_color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medibox/pages/nurse/screens/nurse_homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NurseSignupService{
  static bool isLoading = false;
  static Future<void> nurseSignUp(String email,String password,String confirmPassword,String name,String phone) async{
    if(email.isEmpty || password.isEmpty || confirmPassword.isEmpty || name.isEmpty || phone.isEmpty){
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
        final firestore = FirebaseFirestore.instance.collection(email);
        firestore.doc(email).set({
          'Hospital Name' : name,
          'Mobile Number' : phone,   
        }).then((value) async{
          SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
          sharedPreferences.setString('nurse-email', email);
          Get.to(const NurseHomePage());
        }).then((error){
          // ignore: avoid_print
          print(error);
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