import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medibox/constant/my_text.dart';
import 'package:medibox/services/nurse/upload_presscription_nurse.dart';

// ignore: prefer_typing_uninitialized_variables
var patientIdforNurse;

class EditPrescription extends StatefulWidget {
  final String email;
  const EditPrescription({super.key, required this.email});

  @override
  State<EditPrescription> createState() => _EditPrescriptionState();
}

class _EditPrescriptionState extends State<EditPrescription> {

  final imagePicker = ImagePicker(); 
  XFile? image;
  bool permission =false;

  Future<void> pickImage() async{
    final gallaryImage = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      image = gallaryImage;
    });
  }

  Map<dynamic,dynamic> patientMap={};
  String patientName = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.maxFinite.h,
          width: double.maxFinite.w,
          color: Colors.white,
          child: Stack(
            children: [
              Positioned(
                top: 0.h,
                bottom: 900.h,
                right: 0.w,
                left: 0.w,
                child: Container(
                  color: const Color.fromARGB(255, 62, 32, 99),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 50.w,top: 50.h),
                        child: GestureDetector(
                          onTap: (){
                            Get.back();
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: 100.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 50.h),
                      (image!=null) ? Container(
                        height: 700.h,
                        width: 600.w,
                        margin: EdgeInsets.only(left: 240.w,top: 20.h),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          image: DecorationImage(
                            image: FileImage(File(image!.path)),
                            //fit: BoxFit.fill,
                          ),
                        ),
                      ) : 
                      Container(
                        height: 700.h,
                        width: 600.w,
                        margin: EdgeInsets.only(left: 240.w,top: 20.h),
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
                          image: DecorationImage(
                            image: AssetImage('assets/images/prescription.jpg'),
                            //fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 1150.h,
                bottom: 800.h,
                left: 50.w,
                right: 50.w,
                child: InkWell(
                  onTap: (){
                    pickImage();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.all(Radius.circular(100.sp)),
                    ),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(width: 20.w),
                        Icon(
                          Icons.camera_alt,
                          size: 100.sp,
                          color: Colors.white,
                        ),
                        SizedBox(width: 30.w),
                        MyText(text: "Pick Image", size: 60.sp, overflow: false, bold: true, color: Colors.white),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 1160.h,
                bottom: 815.h,
                left: 530.w,
                right: 80.w,
                child: InkWell(
                  onTap: (){
                    setState(() {
                      UploadPrescriptionNurse().uploadPrescription(File(image!.path), widget.email, patientIdforNurse,patientName).whenComplete((){
                        setState(() {
                          
                        });
                      });
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.pink,
                      borderRadius: BorderRadius.all(Radius.circular(100.sp)),
                    ),
                    child: (UploadPrescriptionNurse.isLoading ==false) ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.upload,
                          size: 100.sp,
                          color: Colors.white,
                        ),
                        MyText(text: "Upload", size: 60.sp, overflow: false, bold: true, color: Colors.white),
                      ],
                    ) : const Center(child: CircularProgressIndicator(color: Colors.white)),
                  ),
                ),
              ),
              Positioned(
                top: 1400.h,
                left: 320.w,
                right: 50.w,
                bottom: 0.w,
                child: MyText(text: 'নির্দেশনাবলি', size: 80.sp, overflow: false, bold: true, color: Colors.black),
              ),
              Positioned(
                top: 900.h,
                left: 50.w,
                right: 50.w,
                bottom: 0.w,
                child: Divider(
                  color: Colors.grey,
                  thickness: 5.w,
                )
              ),
              Positioned(
                top: 1550.h,
                left: 50.w,
                right: 50.w,
                bottom: 0.w,
                child: MyText(text: 'প্রথমে পিক ইমেজ বোতামে ক্লিক করুন। তারপর গ্যালারি থেকে আপনার প্রেসক্রিপশন বাছাই করুন। ছবি বাছাই করার পর, আপনি সঠিক ছবি বেছে নিয়েছেন কিনা তা পরীক্ষা করুন। আপনি যদি সঠিক ছবি বাছাই করেন তাহলে আপলোড বোতামে ক্লিক করুন। আপনার প্রেসক্রিপশন আমাদের সিস্টেমে আপলোড করা হবে।', size: 50.sp, overflow: false, bold: false, color: Colors.black),
              ),
              Positioned(
                top: 2020.h,
                left: 50.w,
                right: 50.w,
                bottom: 0.w,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection(widget.email).snapshots(), 
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if(snapshot.hasData){
                      List<dynamic> patientList = snapshot.data!.docs.map((doc) => doc.data()).toList();
                      return ListView.builder(
                        itemCount: patientList.length,
                        itemBuilder: (context, index) {
                          patientMap = patientList[index] as Map<dynamic,dynamic>;
                          patientIdforNurse = patientMap['Patient Id'];
                          patientName = patientMap['Patient Name'];
                          return Container(
                            // height: 100.h,
                            // width: 200.w,
                            // color: Colors.blue,
                            // child: MyText(text: patientId, size: 50.sp, overflow: false, bold: false, color: Colors.white),
                          );
                        },
                      );
                    }
                    else{
                      return Container();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}