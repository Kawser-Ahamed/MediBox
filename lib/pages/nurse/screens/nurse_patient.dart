import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:medibox/constant/app_color.dart';
import 'package:medibox/constant/my_text.dart';
import 'package:medibox/pages/homepage.dart';
import 'package:medibox/pages/nurse/screens/individual_patient.dart';

class NursePatient extends StatefulWidget {
  const NursePatient({super.key});

  @override
  State<NursePatient> createState() => _NursePatientState();
}

class _NursePatientState extends State<NursePatient> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.maxFinite.h,
          width: double.maxFinite.w,
          decoration: const BoxDecoration(
            color: Colors.white,
            // image: DecorationImage(
            //   image: AssetImage('assets/images/homepage.jpg'),
            //   fit: BoxFit.fill,
            // ),
          ),
          child: Container(
            margin: EdgeInsets.only(left: 40.w,top: 50.h,right: 40.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: (){
                    Get.back();
                  },
                  child: Container(
                    height: 150.h,
                    width: 150.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 5.sp,
                          spreadRadius: 5.sp,
                        )
                      ]
                    ),
                    child: Icon(
                      Icons.arrow_back,
                      size: 80.sp,
                    ),
                  ),
                ),
                SizedBox(height: 100.h),
                MyText(text: "Your Patients", size: 80.sp, overflow: false, bold: true, color: Colors.black),
                SizedBox(height: 50.h),
                SizedBox(height: 100.h),
                Container(
                  height: 1600.h,
                  width: double.maxFinite.w,
                  color: Colors.transparent,
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance.collection('$nurseEmail-Patients').snapshots(), 
                    builder: (context, snapshot) {
                      if(snapshot.hasData){
                        List<dynamic> patientList = snapshot.data!.docs.map((doc) => doc.data()).toList();
                        return ListView.builder(
                          itemCount: patientList.length,
                          itemBuilder: (context, index) {
                            Map<dynamic,dynamic> pateintMap = patientList[index] as Map<dynamic,dynamic>;
                            return Container(
                              height: 300.h,
                              width: double.maxFinite.w,
                              margin: EdgeInsets.only(bottom: 30.h,left: 10.w,right: 10.w,top: 30.h),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(30.sp)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 5.sp,
                                    spreadRadius: 5.sp,
                                  ),
                                ]
                              ),
                              child: Container(
                                margin: EdgeInsets.only(left: 30.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [ 
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            MyText(text: pateintMap['Patient Name'], size: 50.sp, overflow: false, bold: true, color: Colors.black),
                                            MyText(text: "Age: ${pateintMap['Age']}", size: 50.sp, overflow: false, bold: false, color: Colors.black),
                                            MyText(text: "Address: ${pateintMap['Address']}", size: 50.sp, overflow: false, bold: false, color: Colors.black),
                                          ],
                                        ),
                                        GestureDetector(
                                          onTap: (){
                                            Get.to(IndividualPateint(email: pateintMap['Patient Email']));
                                          },
                                          child: Container(
                                            height: 100.h,
                                            width: 100.w,
                                            margin: EdgeInsets.only(right: 30.w),
                                            decoration: BoxDecoration(
                                              color: AppColor.mainColor,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Icon(
                                              Icons.arrow_forward_ios,
                                              size: 60.sp,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          height: 80.h,
                                          width: 550.w,
                                          color: Colors.transparent,
                                          child: MyText(text: "Hsopital: ${pateintMap['Hospital Name']}", size: 50.sp, overflow: true, bold: false, color: Colors.black)),
                                        SizedBox(width: 50.w),
                                        Container(
                                          height: 80.h,
                                          width: 350.w,
                                          color: Colors.transparent,
                                          child: MyText(text: "Ward No: ${pateintMap['Ward No']}", size: 50.sp, overflow: true, bold: false, color: Colors.black)),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            );
                          },
                        );
                      }
                      else{
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}