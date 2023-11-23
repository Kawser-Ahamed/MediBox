import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medibox/constant/app_color.dart';
import 'package:medibox/pages/homepage.dart';
import 'package:medibox/pages/patient/screens/patient_edit_profile.dart';
import 'package:medibox/pages/patient/screens/patient_nurse.dart';
import 'package:medibox/pages/patient/screens/prescription_upload.dart';
import 'package:medibox/providers/patient_time_schedule.dart';
import 'package:medibox/providers/patients_profile.dart';
import 'package:medibox/providers/view_prescription.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: prefer_typing_uninitialized_variables
var userId,patientName;

class PatientHomePage extends StatefulWidget {
  const PatientHomePage({super.key});

  @override
  State<PatientHomePage> createState() => _PatientHomePageState();
}

class _PatientHomePageState extends State<PatientHomePage> {

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
                height: 300.h,
                width: double.maxFinite.w,
                color: AppColor.mainColor,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 30.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Get.to(const Homepage());
                        },
                        child: Icon(Icons.arrow_back,size: 100.sp,color: Colors.black)),
                      Text("MediBox - Patient Module",
                      style: GoogleFonts.arima(
                        fontSize: 50.sp,
                        fontWeight: FontWeight.bold,
                       ),
                      ),
                      GestureDetector(
                        onTap: () async{
                          SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                          sharedPreferences.remove('patient-email');
                          Get.to(const Homepage());
                        },
                        child: Icon(Icons.logout,size: 100.sp,color: Colors.black)),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 50.h),
              Container(
                height: 1800.h,
                width: double.maxFinite.w,
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 100.h,
                        width: double.maxFinite.w,
                        color: Colors.transparent,
                        margin: EdgeInsets.symmetric(horizontal: 30.w),
                        child: StreamBuilder(
                          stream: FirebaseFirestore.instance.collection(patientEmail).snapshots(), 
                          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if(snapshot.hasData){
                              List<dynamic> patientData = snapshot.data!.docs.map((doc) => doc.data()).toList();
                              return ListView.builder(
                                itemCount: patientData.length,
                                itemBuilder: (context, index) {
                                  Map<dynamic,dynamic> patientdataMap = patientData[index] as Map<dynamic,dynamic>;
                                  userId = patientdataMap['Patient Id'];
                                  patientName = patientdataMap['Patient Name'];
                                  return (patientdataMap.containsKey('Gender')) ? Container(
                                    height: 100.h,
                                    width: double.maxFinite.w,
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.all(Radius.circular(50.sp)),
                                    ),
                                    child: Center(
                                      child: Text('Your profile is 100% updated',
                                        style: GoogleFonts.arima(
                                          fontSize: 60.sp,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ) : Container(
                                    height: 100.h,
                                    width: double.maxFinite.w,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.all(Radius.circular(50.sp)),
                                    ),
                                    child: Center(
                                      child: Text('Please Update your profile',
                                        style: GoogleFonts.arima(
                                          fontSize: 60.sp,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                            else{
                              return Container(height: 100.h,width: double.maxFinite.w,color: Colors.transparent);
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 50.h),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 30.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: (){
                                Get.to(const PatientEditProfile());
                              },
                              child: Container(
                                height: 500.h,
                                width: 480.w,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(50.sp)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      offset: Offset(2.w, 2.h),
                                      blurRadius: 10.sp,
                                      spreadRadius: 5.sp,
                                    )
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(height: 20.h),
                                    Container(
                                      height: 300.h,
                                      width: 480.w,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(50.sp),
                                          topRight: Radius.circular(50.sp),
                                        )
                                      ),
                                      child: Center(child: Image.asset('assets/images/edit_profile.jpg')),
                                    ),
                                    Container(
                                      height: 180.h,
                                      width: 480.w,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(50.sp),
                                          bottomRight: Radius.circular(50.sp),
                                        )
                                      ),
                                      child: Center(
                                        child: Text("Update Your Profile",
                                        style: GoogleFonts.abel(
                                          fontSize: 60.sp,
                                        ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 50.w),
                            InkWell(
                              onTap:(){
                                Get.to(const PatientNurse());
                              },
                              child: Container(
                                height: 500.h,
                                width: 480.w,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(50.sp)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      offset: Offset(2.w, 2.h),
                                      blurRadius: 10.sp,
                                      spreadRadius: 5.sp,
                                    )
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(height: 20.h),
                                    Container(
                                      height: 300.h,
                                      width: 480.w,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(50.sp),
                                          topRight: Radius.circular(50.sp),
                                        )
                                      ),
                                      child: Center(child: Image.asset('assets/images/nurse.png')),
                                    ), 
                                    Container(
                                      height: 180.h,
                                      width: 480.w,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(50.sp),
                                          bottomRight: Radius.circular(50.sp),
                                        )
                                      ),
                                      child: Center(
                                        child: Text("Your Nurse",
                                        style: GoogleFonts.abel(
                                          fontSize: 60.sp,
                                        ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 50.h),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 30.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: (){
                                Get.to(PatientProfile(email: patientEmail, state: "profile"));
                              },
                              child: Container(
                                height: 500.h,
                                width: 480.w,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(50.sp)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      offset: Offset(2.w, 2.h),
                                      blurRadius: 10.sp,
                                      spreadRadius: 5.sp,
                                    )
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(height: 20.h),
                                    Container(
                                      height: 300.h,
                                      width: 480.w,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(50.sp),
                                          topRight: Radius.circular(50.sp),
                                        )
                                      ),
                                      child: Center(child: Image.asset('assets/images/view-profile.jpg')),
                                    ),
                                    Container(
                                      height: 180.h,
                                      width: 480.w,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(50.sp),
                                          bottomRight: Radius.circular(50.sp),
                                        )
                                      ),
                                      child: Center(
                                        child: Text("View Your Profile",
                                        style: GoogleFonts.abel(
                                          fontSize: 60.sp,
                                        ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 50.w),
                            InkWell(
                              onTap:(){
                                Get.to(PatientTimeSchedule(email: patientEmail,id: userId,));
                              },
                              child: Container(
                                height: 500.h,
                                width: 480.w,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(50.sp)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      offset: Offset(2.w, 2.h),
                                      blurRadius: 10.sp,
                                      spreadRadius: 5.sp,
                                    )
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(height: 20.h),
                                    Container(
                                      height: 300.h,
                                      width: 480.w,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(50.sp),
                                          topRight: Radius.circular(50.sp),
                                        )
                                      ),
                                      child: Center(child: Image.asset('assets/images/schedule.jpg')),
                                    ), 
                                    Container(
                                      height: 180.h,
                                      width: 480.w,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(50.sp),
                                          bottomRight: Radius.circular(50.sp),
                                        )
                                      ),
                                      child: Center(
                                        child: Text("Medicine Time Schedule",
                                        style: GoogleFonts.abel(
                                          fontSize: 50.sp,
                                        ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 50.h),
                      GestureDetector(
                        onTap: (){
                          Get.to(const PrescriptionUpload());
                        },
                        child: Container(
                          height: 400.h,
                          width: double.maxFinite.w,
                          margin: EdgeInsets.symmetric(horizontal: 30.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(50.sp)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(2.w, 2.h),
                                blurRadius: 10.sp,
                                spreadRadius: 5.sp,
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: 400.h,
                                width: 500.w,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(50.sp),
                                    bottomLeft: Radius.circular(50.sp),
                                  )
                                ),
                                child: Image.asset('assets/images/prescription_edit.png'),
                              ),
                              Container(
                                height: 400.h,
                                width: 480.w,
                                color: Colors.transparent,
                                child: Center(
                                  child: Text("Upload Your Prescription",
                                    style: GoogleFonts.arimo(
                                      fontSize: 80.sp,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 50.h),
                      GestureDetector(
                        onTap: (){
                          Get.to(ViewPrescription(email: patientEmail,patientName: patientName));
                        },
                        child: Container(
                          height: 400.h,
                          width: double.maxFinite.w,
                          margin: EdgeInsets.symmetric(horizontal: 30.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(50.sp)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(2.w, 2.h),
                                blurRadius: 10.sp,
                                spreadRadius: 5.sp,
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: 400.h,
                                width: 500.w,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(50.sp),
                                    bottomLeft: Radius.circular(50.sp),
                                  )
                                ),
                                child: Image.asset('assets/images/prescription.jpg'),
                              ),
                              Container(
                                height: 400.h,
                                width: 480.w,
                                color: Colors.transparent,
                                child: Center(
                                  child: Text("View Your Prescription",
                                    style: GoogleFonts.arimo(
                                      fontSize: 80.sp,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 50.h),
                    ],
                  ),
                ),
              )
            ],
          )
        ),
      )
    );
  }
}