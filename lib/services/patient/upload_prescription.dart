import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medibox/constant/app_color.dart';
import 'package:medibox/pages/homepage.dart';
import 'package:medibox/pages/patient/screens/patient_homepage.dart';
import 'package:medibox/pages/patient/screens/prescription_upload.dart';

class Upload{
    Random random = Random();
    String secretKey = '';

    void keyGenerator(){
      for(int i=1;i<=16;i++){
        int digit = random.nextInt(10);
        secretKey+=digit.toString();
      } 
    }
  Future<void> uploadPrescription(File file,String patientName) async{
    keyGenerator();
    final encrypt.Key key = encrypt.Key.fromUtf8(secretKey); // Replace with your own secret key
    final encrypt.IV iv = encrypt.IV.fromLength(16);
    final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc));
    final encrypted = encrypter.encrypt(patientName, iv: iv);
    final encryptedName = encrypted.base64;
    Firebase.initializeApp();
    final storageRef = FirebaseStorage.instance.ref('prescriptions');
    final imageRef = storageRef.child('images/$encryptedName.png');
    await imageRef.putFile(file);
    final imageLink = await imageRef.getDownloadURL();
    FirebaseFirestore.instance.collection(patientEmail).doc(patientId).update({
      'Prescription Upload Date' : DateTime.now().toString(),
      'Prescription Url' : imageLink,
    }).then((value){
      Get.snackbar('MediBox', 'Your Image Upload Sucessfull',
          backgroundColor: Colors.deepPurple,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
      );
      Get.to(const PatientHomePage());
    }).catchError((error){
      Get.snackbar('MediBox', 'Try Again',
          backgroundColor: AppColor.mainColor,
          colorText: Colors.black,
          duration: const Duration(seconds: 2),
      );
    });
  }

}