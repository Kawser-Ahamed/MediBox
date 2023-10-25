import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medibox/constant/app_color.dart';
import 'package:medibox/constant/my_text.dart';
import 'package:medibox/pages/patient/authentication/patient_signup.dart';
import 'package:medibox/services/patient/patient_login_services.dart';
import 'package:medibox/ui/text_field.dart';

class PatientLogin extends StatefulWidget {
  const PatientLogin({super.key});

  @override
  State<PatientLogin> createState() => _PatientLoginState();
}

class _PatientLoginState extends State<PatientLogin> {

TextEditingController email = TextEditingController();
TextEditingController password = TextEditingController();

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
              image: AssetImage('assets/images/patient_login.jpg'),
              fit: BoxFit.fill,
            ),
          ),
          child: Container(
            color: Colors.transparent,
            margin: EdgeInsets.only(left: 100.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50.h),
                InkWell(
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
                          spreadRadius: 2.sp,
                        )
                      ],
                    ),
                    child: Center(
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                        size: 80.sp,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50.h),
                Text("MediBox",
                  style: GoogleFonts.aBeeZee(
                    fontSize: 80.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 50.h),
                Text("Patient Login",
                  style: GoogleFonts.arima(
                    fontSize: 100.sp,
                    color: AppColor.mainColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 50.h),
                Container(
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
                    children: [
                      MyTextField(width: 800, text: "Email", icon: Icons.email, controller: email, check: false),
                    ],
                  )
                ),
                SizedBox(height: 80.h),
                Container(
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
                       MyTextField(width: 800, text: "Password", icon: Icons.password, controller: password, check: true),
                    ],
                  )
                ),
                SizedBox(height: 100.h),
                TextButton(
                  onPressed: (){

                  },
                  child: MyText(text: "Fotgot Password?", size: 50.sp, overflow: false, bold: true, color: Colors.grey),
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: (){
                        setState(() {
                           PatientLoginService.patientLogin(email.text, password.text).whenComplete((){
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
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 30.h,horizontal: 50.w),
                        child: (PatientLoginService.isLoading) ? const Center(child:CircularProgressIndicator(color: Colors.white)) : MyText(text: "Login Now", size: 60.sp, overflow: false, bold: true, color: Colors.white),
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
                SizedBox(height: 20.h),
                Row(
                  children: [
                    MyText(text: "New User? ", size: 50.sp, overflow: false, bold: true, color: Colors.grey),
                    TextButton(
                      onPressed: (){
                        Get.to(const PatientSignUP());
                      },
                      child: MyText(text: "Signup", size: 50.sp, overflow: false, bold: true, color: AppColor.mainColor),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}