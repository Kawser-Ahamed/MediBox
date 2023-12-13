import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medibox/constant/app_color.dart';
import 'package:medibox/constant/my_text.dart';
import 'package:medibox/services/nurse/nurse_signup_service.dart';
import 'package:medibox/ui/text_field.dart';

class NurseSignup extends StatefulWidget {
  const NurseSignup({super.key});

  @override
  State<NurseSignup> createState() => _NurseSignupState();
}

class _NurseSignupState extends State<NurseSignup> {

 TextEditingController email = TextEditingController();
 TextEditingController password = TextEditingController();
 TextEditingController confirmPassword = TextEditingController();
 TextEditingController phone = TextEditingController();
 TextEditingController hospital = TextEditingController();
 TextEditingController nurseName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          height: double.maxFinite.h,
          width: double.maxFinite.w,
          decoration: BoxDecoration(
            color: AppColor.backgroundColor,
            image: const DecorationImage(
              image: AssetImage('assets/images/nurse-signup.jpg'),
              fit: BoxFit.fill,
            ),
          ),
          child: Container(
            margin: EdgeInsets.only(left: 50.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap:(){
                        Get.back();
                      },
                      child: Container(
                        height: 150.h,
                        width: 150.w,
                        margin: EdgeInsets.only(top: 80.h),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 20.sp,
                              spreadRadius: 5.sp,
                            )
                          ],
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.arrow_back,
                            size: 90.sp,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 300.w),
                    Container(
                      margin: EdgeInsets.only(top: 80.h),
                      child: Text("MediBox",
                        style: GoogleFonts.arima(
                          fontSize: 100.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 200.h),
                Text("Nurse Registration",
                  style: GoogleFonts.arima(
                    fontSize: 80.sp,
                    color: AppColor.mainColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  height: 1100.h,
                  width: double.maxFinite.w,
                  color: Colors.transparent,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 100.h),
                        customContainer("Email", email, Icons.email, false),
                        SizedBox(height: 30.h),
                        customContainer("Password", password, Icons.password, true),
                        SizedBox(height: 30.h),
                        customContainer("Confirm Password", confirmPassword, Icons.password, true),
                        SizedBox(height: 30.h),
                        customContainer("Nurse Name", nurseName, Icons.person, false),
                        SizedBox(height: 30.h),
                        customContainer("Mobile Number", phone, Icons.phone, false),
                        SizedBox(height: 30.h),
                        customContainer("Hospital Name", hospital, Icons.local_hospital, false),
                        SizedBox(height: 350.h),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 50.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: (){
                        setState(() {
                          NurseSignupService.nurseSignUp(email.text, password.text, confirmPassword.text, hospital.text, phone.text,nurseName.text).whenComplete((){
                            setState(() {
                              
                            });
                          });
                        });
                      }, 
                      style: ButtonStyle(
                        backgroundColor: const MaterialStatePropertyAll(Color.fromARGB(255, 92, 215, 163)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100.sp),
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 30.h,horizontal: 50.w),
                        child:(NurseSignupService.isLoading) ? const Center(child: CircularProgressIndicator(color: Colors.white)) : MyText(text: "Registration", size: 60.sp, overflow: false, bold: true, color: Colors.white),
                      ),
                    ),
                    // Row(
                    //   children: [
                    //     Icon(
                    //       Icons.facebook,
                    //       size: 120.sp,
                    //       color: Colors.blue,
                    //     ),
                    //     SizedBox(width: 30.w),
                    //     Image(
                    //       image: const AssetImage("assets/images/google.png"),
                    //       height: 120.h,
                    //       width: 120.w,
                    //     ),
                    //     SizedBox(width: 30.w),
                    //   ],
                    // ),
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
      margin: EdgeInsets.only(left:40.w,right: 80.w),
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
          MyTextField(width: 900, text: text, icon: data, controller: controller, check: obsecure),
        ],
      )
    );
  }
}