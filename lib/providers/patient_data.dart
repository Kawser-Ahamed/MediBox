import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medibox/constant/app_color.dart';
import 'package:medibox/constant/my_text.dart';

class PatientData extends StatefulWidget {
  final String email;
  final String patientId;
  const PatientData({super.key, required this.email, required this.patientId});

  @override
  State<PatientData> createState() => _PatientDataState();
}

class _PatientDataState extends State<PatientData> {
  int totalDays = 0;
  int totalDose = 0;
  int missedDose = 0;
  DateTime time = DateTime.now();

  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      totalDays = 0;
      totalDose = 0;
      missedDose = 0;
      setState(() {
        
      });
     });
    super.initState();
  }

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
              height: 400.h,
              width: double.maxFinite.w,
              decoration: BoxDecoration(
                color: AppColor.mainColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(100.sp),
                ),
              ),
              child: Container(
                margin: EdgeInsets.only(left: 50.w),
                child: Row(
                  children: [
                    Container(
                      height: 300.h,
                      width: 300.w,
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                        image: DecorationImage(
                            image: AssetImage('assets/images/statics.png')),
                      ),
                    ),
                    SizedBox(width: 50.w),
                    Container(
                      height: 200.h,
                      width: 500.h,
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MyText(
                              text: "MediBox",
                              size: 80.sp,
                              overflow: false,
                              bold: false,
                              color: Colors.white),
                          MyText(
                              text:
                                'Date: ${time.day.toString()}-${time.month.toString()}-${time.year.toString()}',
                              size: 50.sp,
                              overflow: false,
                              bold: false,
                              color: Colors.white),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                              height: 500.h,
                              width: double.maxFinite.w,
                              color: Colors.white,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(height: 50.h),
                                  MyText(
                                      text: "Instruction",
                                      size: 80.sp,
                                      overflow: false,
                                      bold: true,
                                      color: Colors.black),
                                  SizedBox(height: 50.h),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.check,
                                        size: 100.sp,
                                        color: Colors.green,
                                      ),
                                      SizedBox(width: 20.w),
                                      MyText(
                                          text:"It indicates patient took medicines.",
                                          size: 50.sp,
                                          overflow: false,
                                          bold: false,
                                          color: Colors.black),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.clear,
                                        size: 100.sp,
                                        color: Colors.red,
                                      ),
                                      SizedBox(width: 20.w),
                                      MyText(
                                          text:"It indicates patient does not took medicines.",
                                          size: 45.sp,
                                          overflow: false,
                                          bold: false,
                                          color: Colors.black),
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Icon(
                        Icons.insert_chart,
                        size: 120.sp,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 100.h),
            Container(
              height: 1650.h,
              width: double.maxFinite.w,
              color: Colors.white,
              child: StreamBuilder(
                stream: FirebaseDatabase.instance.ref(widget.patientId).onValue,
                builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                  if(snapshot.hasError){
                    return const Text('error');
                  }
                  else if(snapshot.data == null){
                    return const Center(child:CircularProgressIndicator());
                  }
                  else if (snapshot.hasData && snapshot.data!.snapshot.exists) {
                    Map<dynamic, dynamic> patientData = snapshot.data!.snapshot.value as dynamic;
                    return Container(
                      height: 1650.h,
                      width: double.maxFinite.w,
                      color: Colors.transparent,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              height: 300.h,
                              width: double.maxFinite.w,
                              margin: EdgeInsets.symmetric(horizontal: 30.w),
                              decoration: BoxDecoration(
                                color: Colors.pink,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50.sp)),
                                image: const DecorationImage(
                                  image: AssetImage(
                                      'assets/images/background-small.jpg'),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 50.w, vertical: 30.h),
                                child: Row(
                                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment:MainAxisAlignment.center,
                                      children: [
                                        MyText(
                                            text: 'Total Days ',
                                            size: 50.sp,
                                            overflow: false,
                                            bold: true,
                                            color: Colors.white),
                                        SizedBox(height: 30.h),
                                        MyText(
                                            text: totalDays.toString(),
                                            size: 50.sp,
                                            overflow: false,
                                            bold: true,
                                            color: Colors.white),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:MainAxisAlignment.center,
                                      children: [
                                        MyText(
                                            text: 'Total Dose',
                                            size: 50.sp,
                                            overflow: false,
                                            bold: true,
                                            color: Colors.white),
                                        SizedBox(height: 30.h),
                                        MyText(
                                            text: totalDose.toString(),
                                            size: 50.sp,
                                            overflow: false,
                                            bold: true,
                                            color: Colors.white),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:MainAxisAlignment.center,
                                      children: [
                                        MyText(
                                            text: 'Missed Dose',
                                            size: 50.sp,
                                            overflow: false,
                                            bold: true,
                                            color: Colors.white),
                                        SizedBox(height: 30.h),
                                        MyText(
                                            text: missedDose.toString(),
                                            size: 50.sp,
                                            overflow: false,
                                            bold: true,
                                            color: Colors.white),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height: 1350.h,
                              width: double.maxFinite.w,
                              color: Colors.transparent,
                              child: ListView.builder(
                                itemCount: patientData.length,
                                itemBuilder: (context, index) {
                                  List<dynamic> patientList = patientData.values.toList();
                                  totalDays = patientData.length;
                                  num value = 0;
                                  for (var m in patientList) {
                                    value += m.length;
                                  }
                                  totalDose = value.toInt();
                                  if (patientList[index]["Morning Before"].toString() =="false") {
                                    missedDose++;
                                  }
                                  if (patientList[index]["Morning After"].toString() =="false") {
                                    missedDose++;
                                  }
                                  if (patientList[index]["Afternoon Before"].toString() =="false") {
                                    missedDose++;
                                  }
                                  if (patientList[index]["Afternoon After"].toString() =="false") {
                                    missedDose++;
                                  }
                                  if (patientList[index]["Night Before"].toString() =="false") {
                                    missedDose++;
                                  }
                                  if (patientList[index]["Night After"].toString() =="false") {
                                    missedDose++;
                                  }
                                  return Container(
                                      height: 300.h,
                                      width: 500.w,
                                      margin: EdgeInsets.symmetric(horizontal: 30.sp, vertical: 30.h),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(Radius.circular(50.sp)),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey,
                                              spreadRadius: 5.sp,
                                              blurRadius: 5.sp)
                                        ],
                                      ),
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: [
                                            SizedBox(width: 50.w),
                                            MyText(
                                                text: patientData.keys.elementAt(index).toString(),
                                                size: 50.sp,
                                                overflow: false,
                                                bold: true,
                                                color: Colors.black),
                                            SizedBox(width: 50.w),
                                            if (patientList[index]['Morning Before'] !=null)
                                              Column(
                                                mainAxisAlignment:MainAxisAlignment.center,
                                                children: [
                                                  MyText(
                                                      text: "Morning Before",
                                                      size: 50.sp,
                                                      overflow: false,
                                                      bold: true,
                                                      color: Colors.black),
                                                  (patientList[index]['Morning Before'].toString() =="true")
                                                      ? _customIconCorrect()
                                                      : _customIconWrong(),
                                                ],
                                              ),
                                            SizedBox(width: 50.w),
                                            if (patientList[index]['Morning After'] !=null)
                                              Column(
                                                mainAxisAlignment:MainAxisAlignment.center,
                                                children: [
                                                  MyText(
                                                      text: "Morning After",
                                                      size: 50.sp,
                                                      overflow: false,
                                                      bold: true,
                                                      color: Colors.black),
                                                  (patientList[index]['Morning After'].toString() =="true")
                                                      ? _customIconCorrect()
                                                      : _customIconWrong(),
                                                ],
                                              ),
                                            SizedBox(width: 50.w),
                                            if (patientList[index]['Afternoon Before'] !=null)
                                              Column(
                                                mainAxisAlignment:MainAxisAlignment.center,
                                                children: [
                                                  MyText(
                                                      text: "Afternoon Before",
                                                      size: 50.sp,
                                                      overflow: false,
                                                      bold: true,
                                                      color: Colors.black),
                                                  (patientList[index]['Afternoon Before'].toString() =="true")
                                                      ? _customIconCorrect()
                                                      : _customIconWrong(),
                                                ],
                                              ),
                                            SizedBox(width: 50.w),
                                            if (patientList[index]['Afternoon After'] !=null)
                                              Column(
                                                mainAxisAlignment:MainAxisAlignment.center,
                                                children: [
                                                  MyText(
                                                      text: "Afternoon After",
                                                      size: 50.sp,
                                                      overflow: false,
                                                      bold: true,
                                                      color: Colors.black),
                                                  (patientList[index]['Afternoon After'].toString() =="true")
                                                      ? _customIconCorrect()
                                                      : _customIconWrong(),
                                                ],
                                              ),
                                            SizedBox(width: 50.w),
                                            if (patientList[index]['Night Before'] !=null)
                                              Column(
                                                mainAxisAlignment:MainAxisAlignment.center,
                                                children: [
                                                  MyText(
                                                      text: "Night Before",
                                                      size: 50.sp,
                                                      overflow: false,
                                                      bold: true,
                                                      color: Colors.black),
                                                  (patientList[index]['Night Before'].toString() =="true")
                                                      ? _customIconCorrect()
                                                      : _customIconWrong(),
                                                ],
                                              ),
                                            SizedBox(width: 50.w),
                                            if (patientList[index] ['Night After'] !=null)
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  MyText(
                                                      text: "Night After",
                                                      size: 50.sp,
                                                      overflow: false,
                                                      bold: true,
                                                      color: Colors.black),
                                                  (patientList[index]['Night After'].toString() =="true")
                                                      ? _customIconCorrect()
                                                      : _customIconWrong(),
                                                ],
                                              ),
                                            SizedBox(width: 50.w),
                                          ],
                                        ),
                                      ));
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Center(child: Text('No Data Here',style: TextStyle(fontSize: 70.sp)));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }

  _customIconCorrect() {
    return Icon(
      Icons.check,
      color: Colors.green,
      size: 120.sp,
    );
  }

  _customIconWrong() {
    return Icon(
      Icons.clear,
      color: Colors.red,
      size: 120.sp,
    );
  }
}
