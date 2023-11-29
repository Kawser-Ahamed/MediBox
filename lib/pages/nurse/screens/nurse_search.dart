import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:medibox/constant/app_color.dart';
import 'package:medibox/constant/my_text.dart';
import 'package:medibox/providers/patients_profile.dart';

class NurseSearch extends StatefulWidget {
  const NurseSearch({super.key});

  @override
  State<NurseSearch> createState() => _NurseSearchState();
}

class _NurseSearchState extends State<NurseSearch> {

  final _search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          height: double.maxFinite.h,
          width: double.maxFinite.w,
          color: Colors.white,
          child: Container(
            margin: EdgeInsets.only(left: 50.w,top: 50.h,right: 50.h),
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
                MyText(text: "MediBox Patients", size: 80.sp, overflow: false, bold: true, color: AppColor.mainColor),
                SizedBox(height: 50.h),
                Container(
                  height: 120.h,
                  width: 980.w,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.all(Radius.circular(100.sp)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 50.w),
                      Icon(Icons.search,size: 80.sp),
                      SizedBox(width: 30.w),
                      Container(
                        height: 120.h,
                        width: 800.w,
                        color: Colors.transparent,
                        child: TextFormField(
                          controller: _search,
                          decoration: const InputDecoration(
                            hintText: 'Search patient name here',
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                          ),
                          onChanged: (value){
                            setState(() {

                            });
                          },
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 100.h),
                Container(
                  height: 1485.h,
                  width: double.maxFinite.w,
                  color: Colors.white,
                  child: FirebaseAnimatedList(
                    query: FirebaseDatabase.instance.ref('patient'), 
                    itemBuilder: (context, snapshot, animation, index) {
                      if(snapshot.value != null){
                        String patientName = snapshot.child('Patient Name').value.toString();
                        String age = snapshot.child('Age').value.toString();
                        String email = snapshot.child('Patient Email').value.toString();
                        String hospitalName = snapshot.child('Hospital Name').value.toString();
                        String wardNo = snapshot.child('Ward No').value.toString();
                        String address = snapshot.child('Address').value.toString();
                        if(_search.text.isEmpty){
                          return Container(
                            height: 300.h,
                            width: double.maxFinite.w,
                            margin: EdgeInsets.only(bottom: 50.h),
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
                                          MyText(text: patientName, size: 50.sp, overflow: false, bold: true, color: Colors.black),
                                          MyText(text: "Age: $age", size: 50.sp, overflow: false, bold: false, color: Colors.black),
                                          MyText(text: "Address: $address", size: 50.sp, overflow: false, bold: false, color: Colors.black),
                                        ],
                                      ),
                                      GestureDetector(
                                        onTap: (){
                                          Get.to(PatientProfile(email: email,state: "search",));
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
                                        child: MyText(text: "Hsopital: $hospitalName", size: 50.sp, overflow: true, bold: false, color: Colors.black)),
                                      SizedBox(width: 50.w),
                                      Container(
                                        height: 80.h,
                                        width: 350.w,
                                        color: Colors.transparent,
                                        child: MyText(text: "Ward No: $wardNo", size: 50.sp, overflow: true, bold: false, color: Colors.black)),
                                    ],
                                  )
                                ],
                              ),
                            )
                          );
                        }
                        else if(patientName.toLowerCase().contains(_search.text.toLowerCase())){
                          return Container(
                            height: 300.h,
                            width: double.maxFinite.w,
                            margin: EdgeInsets.only(bottom: 50.h),
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
                                          MyText(text: patientName, size: 50.sp, overflow: false, bold: true, color: Colors.black),
                                          MyText(text: "Age: $age", size: 50.sp, overflow: false, bold: false, color: Colors.black),
                                          MyText(text: "Address: $address", size: 50.sp, overflow: false, bold: false, color: Colors.black),
                                        ],
                                      ),
                                      GestureDetector(
                                        onTap: (){
                                          Get.to(PatientProfile(email: email,state: "search"));
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
                                        child: MyText(text: "Hsopital: $hospitalName", size: 50.sp, overflow: true, bold: false, color: Colors.black)),
                                      SizedBox(width: 50.w),
                                      Container(
                                        height: 80.h,
                                        width: 350.w,
                                        color: Colors.transparent,
                                        child: MyText(text: "Ward No: $wardNo", size: 50.sp, overflow: true, bold: false, color: Colors.black)),
                                    ],
                                  )
                                ],
                              ),
                            )
                          );
                        }
                        else {
                          return Container();
                        }
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