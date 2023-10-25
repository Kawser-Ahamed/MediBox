import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medibox/constant/my_text.dart';
import 'package:medibox/pages/homepage.dart';
import 'package:medibox/pages/patient/screens/patient_homepage.dart';

class PatientNurse extends StatefulWidget {
  const PatientNurse({super.key});

  @override
  State<PatientNurse> createState() => _PatientNurseState();
}

class _PatientNurseState extends State<PatientNurse> {
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
                bottom: 1100.h,
                left: 0.w,
                right: 0.w,
                child: Container(
                  color: const Color.fromRGBO(110, 237, 201, 1),
                  child: const Image(
                    image: AssetImage('assets/images/nurse3.png'),
                  ),
                ),
              ),
              Positioned(
                top: 50.h,
                bottom: 1940.h,
                left: 30.w,
                right: 870.w,
                child: GestureDetector(
                  onTap: ()=> Get.to(const PatientHomePage()),
                  child: Container(
                    alignment: Alignment.center,
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
                    child: Icon(Icons.arrow_back,size: 90.sp),
                  ),
                ),
              ),
              Positioned(
                top:  950.h,
                bottom: 0.h,
                left: 0.w,
                right: 0.w,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60.sp),
                      topRight: Radius.circular(60.sp),
                    ),
                  ),
                  child: Container(
                    margin: EdgeInsets.only(left: 50.w,top: 50.h,right: 50.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Your Nurse.",
                                  style: GoogleFonts.arima(
                                    fontSize: 60.sp,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                Text("Anytime.",
                                  style: GoogleFonts.arima(
                                    fontSize: 60.sp,
                                    color: const Color.fromARGB(255, 70, 189, 143),
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                Text("Anywhere.",
                                  style: GoogleFonts.arima(
                                    fontSize: 60.sp,
                                    color: const Color.fromARGB(255, 229, 200, 56),
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: 180.h,
                              width: 180.w,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.all(Radius.circular(30.sp)),
                              ),
                              child: Icon(Icons.local_hospital,
                                size: 100.sp,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 30.h),
                        Container(
                          height: 150.h,
                          width: double.maxFinite.w,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.all(Radius.circular(30.sp)),
                            border: Border.all(
                              color: Colors.grey,
                              width: 3.sp,
                            )
                          ),
                          alignment: Alignment.center,
                          child: Text("MediBox",
                            style: GoogleFonts.arima(
                              fontSize: 80.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        SizedBox(height: 30.h),
                        MyText(text: "About", size: 60.sp, overflow: false, bold: true, color: Colors.black),
                        SizedBox(height: 30.h),
                        Container(
                          height: 520.h,
                          width: double.maxFinite.w,
                          color: Colors.transparent,
                          child: StreamBuilder(
                            stream: FirebaseFirestore.instance.collection('$patientEmail-Nurse').snapshots(), 
                            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                              if(snapshot.hasData){
                                List<dynamic> nurseList = snapshot.data!.docs.map((doc) => doc.data()).toList();
                                return ListView.builder(
                                  itemCount: nurseList.length,
                                  itemBuilder: (context, index) {
                                    Map<dynamic,dynamic> nurseMap = nurseList[index] as Map<dynamic,dynamic>;
                                    return Container(
                                      height: 520.h,
                                      width: double.maxFinite.w,
                                      color: Colors.transparent,
                                      child: StreamBuilder(
                                        stream: FirebaseFirestore.instance.collection(nurseMap['Nurse Email']).snapshots(), 
                                        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                          if(snapshot.hasData){
                                            List<dynamic> nurseDetails = snapshot.data!.docs.map((doc) => doc.data()).toList();
                                            return ListView.builder(
                                              itemCount: nurseDetails.length,
                                              itemBuilder: (context, index) {
                                                Map<dynamic,dynamic> nurseMap2 = nurseDetails[index] as Map<dynamic,dynamic>;
                                                return Container(
                                                  height: 520.h,
                                                  width: double.maxFinite.w,
                                                  color: Colors.transparent,
                                                  child: SingleChildScrollView(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Divider(color: Colors.grey,thickness: 3.sp),
                                                        SizedBox(height: 30.h),
                                                        MyText(text: 'Nurse Email: ${nurseMap['Nurse Email']}', size: 50.sp, overflow: false, bold: false, color: Colors.black),
                                                        SizedBox(height: 20.h),
                                                        MyText(text: 'Hospital Name: ${nurseMap2['Hospital Name']}', size: 50.sp, overflow: false, bold: false, color: Colors.black),
                                                        SizedBox(height: 20.h),
                                                        MyText(text: 'Hospital Name: ${nurseMap2['Mobile Number']}', size: 50.sp, overflow: false, bold: false, color: Colors.black),
                                                        SizedBox(height: 30.h),
                                                        Divider(color: Colors.grey,thickness: 3.sp),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          }
                                          else{
                                            return const Center(child: CircularProgressIndicator());
                                          }
                                        },
                                      ),
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
                )
              ),
            ],
          ),
        ),
      )
    );
  }
}