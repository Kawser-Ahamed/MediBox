import 'dart:io';
import 'package:encrypt/encrypt.dart' as encrypt;
//import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medibox/constant/app_color.dart';
import 'package:medibox/pages/patient/screens/patient_homepage.dart';
import 'package:medibox/providers/my_secret_key.dart';

class Upload{
  static bool isLoading = false;
  Future<void> uploadPrescription(File file,String patientName) async{
    try{
      isLoading = true;
      DateTime currentTime = DateTime.now();
      int miliSecond = currentTime.microsecondsSinceEpoch;
      String secretKey = MySecretKey.secretKey;
      final encrypt.Key key = encrypt.Key.fromUtf8(secretKey); 
      final encrypt.IV iv = encrypt.IV.fromLength(16);
      final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc));
      final encrypted = encrypter.encrypt(patientName, iv: iv);
      final encryptedName = encrypted.base64;
      debugPrint('Name: ${encryptedName.toString()}');
      final storageRef = FirebaseStorage.instance.ref(encryptedName);
      final imageRef = storageRef.child('/$miliSecond.png');
      await imageRef.putFile(file).then((value){
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
    catch(error){
      // ignore: avoid_print
      print(error);
    }
    finally{
      isLoading = false;
    }
    // final imageLink = await imageRef.getDownloadURL();
    // FirebaseFirestore.instance.collection(patientEmail).doc(patientId).update({
    //   'Prescription Upload Date' : DateTime.now().toString(),
    //   'Prescription Url' : imageLink,
    // }).then((value){
    //   Get.snackbar('MediBox', 'Your Image Upload Sucessfull',
    //       backgroundColor: Colors.deepPurple,
    //       colorText: Colors.white,
    //       duration: const Duration(seconds: 2),
    //   );
    //   Get.to(const PatientHomePage());
    // }).catchError((error){
    //   Get.snackbar('MediBox', 'Try Again',
    //       backgroundColor: AppColor.mainColor,
    //       colorText: Colors.black,
    //       duration: const Duration(seconds: 2),
    //   );
    // });
  }

}