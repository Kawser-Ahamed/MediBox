import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medibox/constant/my_text.dart';

class PatientTimeSchedule extends StatefulWidget {
  final String email;
  final String id;
  const PatientTimeSchedule({super.key, required this.email, required this.id});

  @override
  State<PatientTimeSchedule> createState() => _PatientTimeScheduleState();
}

class _PatientTimeScheduleState extends State<PatientTimeSchedule> {

  DateTime currentTime = DateTime.now();

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
                height: 500.h,
                width: double.maxFinite.w,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    image: AssetImage('assets/images/header.png'),
                    fit: BoxFit.fill
                  ),
                ),
                child: Container(
                  margin: EdgeInsets.only(left: 50.w,top: 50.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Get.back();
                        },
                        child: Icon(CupertinoIcons.back,size: 100.sp,color: Colors.white)),
                      Container(
                        margin: EdgeInsets.only(left: 700.w),
                        child: Text('MediBox',
                          style: GoogleFonts.arima(
                            color: Colors.white,
                            fontSize: 60.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 700.w),
                        child: Text('${currentTime.day}-${currentTime.month}-${currentTime.year}',
                          style: GoogleFonts.arima(
                            color: Colors.white,
                            fontSize: 60.sp,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: 1650.h,
                width: double.maxFinite.w,
                color: Colors.white,
                margin: EdgeInsets.symmetric(horizontal: 50.w),
                child: StreamBuilder(
                  stream: FirebaseDatabase.instance.ref('Patient-Time-Scheduling').child(widget.id).onValue, 
                  builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                    if(snapshot.hasData){
                      try{
                        Map<dynamic,dynamic> patinetMap = snapshot.data!.snapshot.value as dynamic;
                        return ListView.builder(
                          itemCount: patinetMap.length,
                          itemBuilder: (context, index) {
                            List<dynamic> patientData = patinetMap.values.toList();
                            return Container(
                              margin: EdgeInsets.only(bottom: 10.h),
                              child: Card(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 20.sp),
                                  child: ListTile(
                                    title: MyText(text: patinetMap.keys.elementAt(index), size: 50.sp, overflow: false, bold: true, color: Colors.black),
                                    subtitle: MyText(text: 'Medibox will automatically open on this time.', size: 40.sp, overflow: false, bold: false, color: Colors.black),
                                    trailing: MyText(text: patientData[index], size: 50.sp, overflow: false, bold: true, color: Colors.black),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                      catch(error){
                        return const Center(child: Text("No Time Scheduling set yet"));
                      }
                    }
                    else{
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}