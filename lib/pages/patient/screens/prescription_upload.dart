import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medibox/constant/my_text.dart';
import 'package:medibox/pages/homepage.dart';
import 'package:medibox/services/patient/prescription_permission.dart';
import 'package:medibox/services/patient/upload_prescription.dart';

// ignore: prefer_typing_uninitialized_variables
var patientId;

class PrescriptionUpload extends StatefulWidget {
  const PrescriptionUpload({super.key});

  @override
  State<PrescriptionUpload> createState() => _PrescriptionUploadState();
}

class _PrescriptionUploadState extends State<PrescriptionUpload> {

  final imagePicker = ImagePicker(); 
  XFile? image;
  bool permission =false;

  Future<void> pickImage() async{
    final gallaryImage = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      image = gallaryImage;
    });
  }

  String patientName = '';

  @override
  void initState() {
    Timer(const Duration(seconds: 1), () {
      setState(() {
        (patientMap.containsKey('Prescription Permission') && patientMap['Prescription Permission']=='true') ? permission = true : null;
      });
     });
    super.initState();
  }
  Map<dynamic,dynamic> patientMap={};

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
                      SizedBox(height: 50.h,),
                      Container(
                        height: 200.h,
                        width: double.maxFinite.w,
                        margin: EdgeInsets.symmetric(horizontal: 10.w),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.all(Radius.circular(50.sp)),
                          border: Border.all(
                            width: 3.w,
                            color: Colors.grey,
                          )
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: 25.w),
                            Container(
                              height: 200.h,
                              width: 600.w,
                              color: Colors.transparent,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  MyText(text: 'আপনার নার্সকে প্রেসক্রিপশন আপলোড করার অনুমতি দিন ', size: 50.sp, overflow: false, bold: false, color: Colors.white),
                                ],
                              ),
                            ),
                            SizedBox(width: 20.w,),
                            Container(
                              height: 150.h,
                              width: 380.w,
                              decoration: BoxDecoration(
                                color: (permission == false) ? Colors.grey.withOpacity(0.9) : Colors.orange,
                                borderRadius: BorderRadius.all(Radius.circular(100.sp)),
                                border: Border.all(
                                  color: Colors.blue,
                                  width: 5.w,
                                )
                              ),
                              child: Stack(
                                children: [
                                  AnimatedPositioned(
                                    duration: const Duration(milliseconds: 700),
                                    top: 15.h,
                                    bottom: 15.h,
                                    left: (permission==false)?0.w:200.w,
                                    right: (permission==false)?200.w:0.w,
                                    child: GestureDetector(
                                      onTap:(){
                                        permission = !permission;
                                        PrescriptionPermission().prescriptionPermission(permission);
                                        setState(() {
                                          
                                        });
                                      },
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
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
                      Upload().uploadPrescription(File(image!.path),patientName).whenComplete((){
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
                    child:(Upload.isLoading == false) ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.upload,
                          size: 100.sp,
                          color: Colors.white,
                        ),
                        MyText(text: "Upload", size: 60.sp, overflow: false, bold: true, color: Colors.white),
                      ],
                    ) : const Center(child: CircularProgressIndicator(color: Colors.white,)),
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
                  stream: FirebaseFirestore.instance.collection(patientEmail).snapshots(), 
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if(snapshot.hasData){
                      List<dynamic> patientList = snapshot.data!.docs.map((doc) => doc.data()).toList();
                      return ListView.builder(
                        itemCount: patientList.length,
                        itemBuilder: (context, index) {
                          patientMap = patientList[index] as Map<dynamic,dynamic>;
                          patientId = patientMap['Patient Id'];
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