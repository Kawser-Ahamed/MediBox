import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medibox/constant/app_color.dart';

class ViewPrescription extends StatefulWidget {
  final String email;
  const ViewPrescription({super.key, required this.email});

  @override
  State<ViewPrescription> createState() => _ViewPrescriptionState();
}

class _ViewPrescriptionState extends State<ViewPrescription> {
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
              SizedBox(height: 50.h),
              Text("Patient Prescription",
                style: GoogleFonts.arima(
                  fontSize: 80.sp,
                  color: AppColor.mainColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 50.h),
              Container(
                height: 1500.h,
                width: double.maxFinite.w,
                margin: EdgeInsets.symmetric(horizontal: 50.w),
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection(widget.email).snapshots(), 
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if(snapshot.hasData){
                      List<dynamic> patientList = snapshot.data!.docs.map((doc) => doc.data()).toList();
                      return ListView.builder(
                        itemCount: patientList.length,
                        itemBuilder: (context, index) {
                          Map<dynamic,dynamic> patientMap = patientList[index] as Map<dynamic,dynamic>;
                          return Container(
                            height: 1500.h,
                            width: double.maxFinite.w,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              image: DecorationImage(
                                image: (patientMap.containsKey('Prescription Url')) ? NetworkImage(patientMap['Prescription Url']) : const NetworkImage('https://static.vecteezy.com/system/resources/previews/016/133/194/original/prescription-icon-in-comic-style-rx-document-cartoon-illustration-on-white-isolated-background-paper-splash-effect-business-concept-vector.jpg'),
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
              ),
              SizedBox(height: 50.h),
              ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(AppColor.mainColor),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.sp),
                    ),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 350.w,vertical: 20.h),
                  child: Text('Back',
                    style: GoogleFonts.arima(
                      fontSize: 70.sp,
                      color: Colors.black
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}