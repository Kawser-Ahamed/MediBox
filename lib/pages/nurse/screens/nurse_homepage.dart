import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medibox/constant/app_color.dart';
import 'package:medibox/constant/my_text.dart';
import 'package:medibox/pages/homepage.dart';
import 'package:medibox/pages/nurse/screens/nurse_patient.dart';
import 'package:medibox/pages/nurse/screens/nurse_search.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NurseHomePage extends StatefulWidget {
  const NurseHomePage({super.key});

  @override
  State<NurseHomePage> createState() => _NurseHomePageState();
}

class _NurseHomePageState extends State<NurseHomePage> {
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
                        child: Icon(Icons.arrow_back,size: 100.sp,color: Colors.black)
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("MediBox - Nurse Module",
                          style: GoogleFonts.arima(
                            fontSize: 50.sp,
                            fontWeight: FontWeight.bold,
                          ),
                         ),
                         SizedBox(height: 30.h),
                         GestureDetector(
                          onTap: (){
                            Get.to(const NurseSearch());
                          },
                           child: Container(
                            height: 100.h,
                            width: 700.w,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(50.sp)),
                            ),
                            child: Row(
                              children: [
                                SizedBox(width: 50.w),
                                const Icon(Icons.search),
                                SizedBox(width: 20.w),
                                MyText(text: 'Search Patient Here', size: 50.sp, overflow: false, bold: false, color: Colors.black),
                              ],
                            ),
                           ),
                         ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () async{
                          SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                          sharedPreferences.remove('nurse-email');
                          Get.to(const Homepage());
                        },
                        child: Icon(Icons.logout,size: 100.sp,color: Colors.black)),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 100.h),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: (){
                        Get.to(const NurseSearch());
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
                                child: Center(child: Image.asset('assets/images/search.jpg')),
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
                                child: Text("Find Patients",
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
                    GestureDetector(
                      onTap: (){
                        Get.to(const NursePatient());
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
                              child: Center(child: Image.asset('assets/images/nurse-patient.jpg')),
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
                                child: Text("My Patients",
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
            ],
          )
        ),
      )
    );
  }
}