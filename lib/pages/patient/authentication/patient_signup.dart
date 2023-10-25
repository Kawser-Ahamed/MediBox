import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medibox/constant/app_color.dart';
import 'package:medibox/constant/my_text.dart';
import 'package:medibox/services/patient/patient_signup_services.dart';
import 'package:medibox/ui/text_field.dart';

class PatientSignUP extends StatefulWidget {
  const PatientSignUP({super.key});

  @override
  State<PatientSignUP> createState() => _PatientSignUPState();
}

class _PatientSignUPState extends State<PatientSignUP> {

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController hospital = TextEditingController();
  TextEditingController wardNo = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController address = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          height: double.maxFinite.h,
          width: double.maxFinite.w,
          decoration: const BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image: AssetImage("assets/images/patient_signup.jpg"),
              fit: BoxFit.fitHeight,
            ),
          ),
          child: Container(
            margin: EdgeInsets.only(left: 100.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 100.h),
                Text("MediBox",
                  style: GoogleFonts.aBeeZee(
                    fontSize: 80.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 50.h),
                Text("Patient Signup",
                  style: GoogleFonts.arima(
                    fontSize: 100.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 100.h),
                Container(
                  height: 1150.w,
                  width: double.maxFinite.w,
                  color: Colors.transparent,
                  margin: EdgeInsets.only(bottom: 50.h),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        customContainer("Email",email,Icons.email,false),
                        SizedBox(height: 50.h),
                        customContainer("Password",password,Icons.key,true),
                        SizedBox(height: 50.h),
                        customContainer("Confirm Password",confirmPassword,Icons.key,true),
                        SizedBox(height: 50.h),
                        customContainer("Patient Name",name,CupertinoIcons.profile_circled,false),
                        SizedBox(height: 50.h),
                        customContainer("Hospital Name", hospital, Icons.local_hospital, false),
                        SizedBox(height: 50.h),
                        customContainer("Ward No", wardNo, Icons.cabin, false),
                        SizedBox(height: 50.h),
                        customContainer("Age", age, Icons.time_to_leave_outlined, false),
                        SizedBox(height: 50.h),
                        customContainer("Permanent Address", address, CupertinoIcons.location_solid, false),
                        SizedBox(height: 400.h),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: (){
                        setState(() {
                          PatientSignupService.patientSignUp(email.text, password.text, confirmPassword.text, name.text, age.text,address.text,hospital.text,wardNo.text).whenComplete((){
                            setState(() {
                              
                            });
                          });
                        });
                      }, 
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(AppColor.mainColor),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100.sp),
                          ),
                        ),
                      ),
                      child: (PatientSignupService.isLoading) ? const Center(child: CircularProgressIndicator(color: Colors.white),)
                      :Padding(
                        padding: EdgeInsets.symmetric(vertical: 30.h,horizontal: 50.w),
                        child: MyText(text: "Signup", size: 60.sp, overflow: false, bold: true, color: Colors.white),
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.facebook,
                          size: 120.sp,
                          color: Colors.blue,
                        ),
                        SizedBox(width: 30.w),
                        Image(
                          image: const AssetImage("assets/images/google.png"),
                          height: 100.h,
                          width: 100.w,
                        ),
                        SizedBox(width: 100.w),
                      ],
                    ), 
                  ],
                ),
                SizedBox(height: 100.h),
                Row(
                  children: [
                    SizedBox(width: 20.w),
                    MyText(text: "Already have an account? ", size: 50.sp, overflow: false, bold: true, color: Colors.black),
                    TextButton(
                      onPressed: (){
                        Get.back();
                      },
                      child: MyText(text: "Login", size: 60.sp, overflow: false, bold: true, color: AppColor.mainColor),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      )
    );
  }

  customContainer(String text,TextEditingController controller, IconData data,bool obsecure){
    return Container(
      height: 170.h,
      width: 900.w,
      margin: EdgeInsets.only(right: 100.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(100.sp)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: const Offset(2,2),
            blurRadius: 10.sp,
            spreadRadius: 2.sp,
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyTextField(width: 800, text: text, icon: data, controller: controller, check: obsecure),
        ],
      )
    );
  }
}