import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medibox/constant/app_color.dart';
import 'package:medibox/pages/nurse/screens/edit_prescription.dart';
import 'package:medibox/providers/patient_data.dart';
import 'package:medibox/providers/patient_time_schedule.dart';
import 'package:medibox/providers/patients_profile.dart';
import 'package:medibox/pages/nurse/screens/time_scheduling.dart';
import 'package:medibox/providers/view_prescription.dart';

class IndividualPateint extends StatefulWidget {
  final String email;
  const IndividualPateint({super.key, required this.email});

  @override
  State<IndividualPateint> createState() => _IndividualPateintState();
}

class _IndividualPateintState extends State<IndividualPateint> {

  bool check = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.maxFinite.h,
          width: double.maxFinite.w,
          color: Colors.white,
          child: Column(
            children: [
              Container(
                height: 250.h,
                width: double.maxFinite.w,
                color: AppColor.mainColor,
                child: Row(
                  children: [
                    SizedBox(width: 50.w),
                    GestureDetector(
                      onTap: (){
                        Get.back();
                      },
                      child: Icon(Icons.arrow_back,color: Colors.white,size: 120.sp)
                    ),
                    SizedBox(width: 250.w),
                    Text("MediBox",
                      style: GoogleFonts.arima(
                        color: Colors.white,
                        fontSize: 70.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50.h),
              Container(
                height: 500.h,
                width: double.maxFinite.w,
                margin: EdgeInsets.symmetric(horizontal: 30.w),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    image: AssetImage('assets/images/app-header-fig.jpg'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(height: 50.h),
              Container(
                height: 1300.h,
                width: double.maxFinite.w,
                color: Colors.white,
                margin: EdgeInsets.symmetric(horizontal: 50.w),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 500.h,
                        width: double.maxFinite.w,
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap:(){
                                Get.to(TimeScheduling(email: widget.email));
                              },
                              child: _customContainer("assets/images/schedule.jpg","Time Scheduling"),
                            ),
                            GestureDetector(
                              onTap: (){
                                Get.to(PatientProfile(email: widget.email,state: "profile-nurse",));
                              },
                              child: _customContainer("assets/images/view-profile.jpg","Patient Profile"),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 500.h,
                        width: double.maxFinite.w,
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                           GestureDetector(
                            onTap: (){
                              Get.to(ViewPrescription(email: widget.email,));
                            },
                            child:  _customContainer("assets/images/prescription.jpg","View Prescription"),
                           ),
                            GestureDetector(
                              onTap:(){
                                setState(() {
                                  
                                });
                                (check==true) ? Get.to(EditPrescription(email: widget.email))
                                : Get.snackbar('MediBox', 'You Have No Permission to edit',
                                    //backgroundColor: AppColor.mainColor,
                                    colorText: Colors.black,
                                    duration: const Duration(seconds: 2),
                                );
                              },
                              child: _customContainer("assets/images/prescription_edit.png","Edit Prescription"),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 500.h,
                        width: double.maxFinite.w,
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                           GestureDetector(
                            onTap: (){
                              Get.to(PatientTimeSchedule(email: widget.email, id: patientIdforNurse));
                            },
                            child:  _customContainer("assets/images/view-time.png","View Time"),
                           ),
                            GestureDetector(
                              onTap:(){
                                Get.to(PatientData(email: widget.email, patientId: patientIdforNurse));
                              },
                              child: _customContainer("assets/images/patient-data.png","Patient Data"),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 0.h,
                        width: double.maxFinite.w,
                        color: Colors.transparent,
                        child: StreamBuilder(
                          stream: FirebaseFirestore.instance.collection(widget.email).snapshots(), 
                          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if(snapshot.hasData){
                              List<dynamic> patientList = snapshot.data!.docs.map((doc) => doc.data()).toList();
                              return ListView.builder(
                                itemCount: patientList.length,
                                itemBuilder: (context, index) {
                                  Map<dynamic,dynamic> patientMap = patientList[index] as Map<dynamic,dynamic>;
                                  patientIdforNurse = patientMap['Patient Id'];
                                  (patientMap.containsKey('Prescription Permission')  && patientMap['Prescription Permission']=='true') ? check = true : check = false;
                                  return Container();     
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
            ],
          )
        ),
      )
    );
  }
  _customContainer(String url,String text){
    return Container(
      height: 400.h,
      width: 400.w,
      margin: EdgeInsets.symmetric(horizontal: 10.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(30.sp)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5.sp,
            spreadRadius: 5.sp,
          )
        ]
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 250.h,
            width: 350.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(30.sp)),
              image: DecorationImage(
                image: AssetImage(url),
              ),
            ),
          ),
          Text(text,
            style: GoogleFonts.arima(
              color: Colors.black,
              fontSize: 50.sp,
            ),
          )
        ],
      ),
    );
  }
}