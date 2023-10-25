import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medibox/constant/app_color.dart';
import 'package:medibox/constant/my_text.dart';
import 'package:medibox/services/nurse/time_schedule_service.dart';

class TimeScheduling extends StatefulWidget {
  final String email;
  const TimeScheduling({super.key, required this.email});

  @override
  State<TimeScheduling> createState() => _TimeSchedulingState();
}

class _TimeSchedulingState extends State<TimeScheduling> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          height: double.maxFinite.h,
          width: double.maxFinite.w,
          color: Colors.white,
          child: Column(
            children: [
              Container(
                height: 280.h,
                width: double.maxFinite.w,
                color: AppColor.mainColor,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 50.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // SizedBox(width: 50.w),
                      GestureDetector( 
                        onTap:(){
                          Get.back();
                        },
                        child: Icon(Icons.arrow_back,size: 100.sp,color: Colors.white)),
                      Text("MediBox",
                        style: GoogleFonts.arima(
                          fontSize: 80.sp,
                          color: Colors.white,
                        ),
                      ),
                     SizedBox(width: 30.w),
                    ],
                  ),
                ),
              ),
              Container(
                height: 1800.h,
                width: double.maxFinite.w,
                color: Colors.white,
                margin: EdgeInsets.only(top: 70.h,left: 50.w,right: 50.w),
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection(widget.email).snapshots(), 
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      List<dynamic> patientList = snapshot.data!.docs.map((doc) => doc.data()).toList();
                      return ListView.builder(
                        itemCount: patientList.length,
                        itemBuilder: (context, index) {
                          Map<dynamic,dynamic> patientMap = patientList[index] as Map<dynamic,dynamic>;
                          return Container(
                            height: 1800.h,
                            width: double.maxFinite.w,
                            color: Colors.white,
                            child: Column(
                              children: [
                                MyText(text: 'Patient Name: ${patientMap['Patient Name']}', size: 60.sp, overflow: false, bold: false, color: Colors.black),
                                SizedBox(height: 100.h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: (){
                                        TimeScheduleProvider().setTime(context,"Morning Before",patientMap['Patient Id']);
                                      },
                                      child: _customContainer("Morning Before","assets/images/morning.png"),
                                    ),
                                    GestureDetector(
                                      onTap: (){
                                        TimeScheduleProvider().setTime(context,"Morning After",patientMap['Patient Id']);
                                      },
                                      child: _customContainer("Morning After","assets/images/morning.png"),
                                    )
                                  ],
                                ),
                                SizedBox(height: 100.h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: (){
                                        TimeScheduleProvider().setTime(context,"Afternoon Before",patientMap['Patient Id']);
                                      },
                                      child: _customContainer("Afternoon Before","assets/images/afternoon.png"),
                                    ),
                                    GestureDetector(
                                      onTap: (){
                                        TimeScheduleProvider().setTime(context,"Afternoon After",patientMap['Patient Id']);
                                      },
                                      child: _customContainer("Afternoon After","assets/images/afternoon.png"),
                                    )
                                  ],
                                ),
                                SizedBox(height: 100.h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: (){
                                        TimeScheduleProvider().setTime(context,"Night Before",patientMap['Patient Id']);
                                      },
                                      child: _customContainer("Night Before","assets/images/night.png"),
                                    ),
                                    GestureDetector(
                                      onTap: (){
                                        TimeScheduleProvider().setTime(context,"Night After",patientMap['Patient Id']);
                                      },
                                      child: _customContainer("Night After","assets/images/night.png"),
                                    )
                                  ],
                                ),
                              ],
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
    );
  }

  _customContainer(String title,String url){
    return Container(
      height: 400.h,
      width: 450.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(50.sp)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 2.sp,
            blurRadius: 20.sp,
          ),
        ]
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 200.h,
            width: double.maxFinite.w,
            decoration:  BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50.sp),
                topRight: Radius.circular(50.sp),
              ),
              image: DecorationImage(
                image: AssetImage(url),
                //fit: BoxFit.fitWidth,
                filterQuality: FilterQuality.high,
              ),
            ),
          ),
          SizedBox(height: 50.h),
          Container( 
            margin: EdgeInsets.only(left: 30.w,right: 5.w),
            child: MyText(text: title, size: 60.sp, overflow: false, bold: false, color: Colors.black)),
        ],
      ),
    );
  }
}