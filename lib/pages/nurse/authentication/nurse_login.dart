import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medibox/constant/app_color.dart';
import 'package:medibox/constant/my_text.dart';
import 'package:medibox/pages/nurse/authentication/nurse_signup.dart';
import 'package:medibox/services/nurse/nurse_login_service.dart';
import 'package:medibox/ui/text_field.dart';

class NurseLogin extends StatefulWidget {
  const NurseLogin({super.key});

  @override
  State<NurseLogin> createState() => _NurseLoginState();
}

class _NurseLoginState extends State<NurseLogin> {

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
          decoration: BoxDecoration(
            color: AppColor.backgroundColor,
            image: const DecorationImage(
              image: AssetImage("assets/images/nurse-login.jpg"),
              fit : BoxFit.cover,
            ),
          ),
          child: Container(
            margin: EdgeInsets.only(left: 80.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap:(){
                    Get.back();
                  },
                  child: Container(
                    height: 150.h,
                    width: 150.w,
                    margin: EdgeInsets.only(top: 50.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 20.sp,
                          spreadRadius: 2.sp,
                        )
                      ]
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
                Container(
                  margin: EdgeInsets.only(left: 360.w,top: 100.h),
                  child: Text("Login",
                    style: GoogleFonts.arima(
                      fontSize: 80.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 200.h),
                customContainer("Email",email,Icons.email,false),
                SizedBox(height: 50.h),
                customContainer("Password",password,Icons.password,true),
                SizedBox(height: 50.h),
                Row(
                  children: [
                    Text("Accept our",
                      style: GoogleFonts.sanchez(
                        fontSize: 50.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text("  Terms and Condition",
                      style: GoogleFonts.aBeeZee(
                        fontSize: 50.sp,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 100.h),
                Container(
                  height: 150.h,
                  width: 900.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(100.sp)),
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 40.w),
                      TextButton(
                        onPressed: (){
                         Get.to(const NurseSignup());
                        }, 
                        child: Text("New User? Signup",
                          style: GoogleFonts.aBeeZee(
                            fontSize: 45.sp,
                            color: AppColor.mainColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(width: 20.w),
                      InkWell(
                        onTap: (){
                          setState(() {
                            NurseLoginService.nurseLogin(email.text, password.text).whenComplete((){
                              setState(() {
                                
                              });
                            });
                          });
                        },
                        child: Container(
                          height: 120.h,
                          width: 380.w,
                          decoration: BoxDecoration(
                            color: Colors.pink,
                            borderRadius: BorderRadius.all(Radius.circular(100.sp)),
                          ),
                          child: (NurseLoginService.isLoading) ?const Center(child: CircularProgressIndicator(color: Colors.white),)
                          :Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Login",
                                style: GoogleFonts.aBeeZee(
                                  fontSize: 45.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 50.w),
                              Icon(
                                Icons.arrow_forward,
                                size: 80.sp,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 100.h),
                Row(
                  children: [
                    SizedBox(width: 150.w),
                    MyText(text: "Follow us on", size: 60.sp, overflow: false, bold: true, color: Colors.white),
                    SizedBox(width: 50.w),
                    Icon(
                      Icons.facebook,
                      size: 100.sp,
                      color: Colors.blue,
                    ),
                    SizedBox(width: 50.w),
                    Image(
                      image: const AssetImage('assets/images/google.png'),
                      height: 100.h,
                      width: 100.w,
                    ),
                  ],
                )
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
          MyTextField(width: 900, text: text, icon: data, controller: controller, check: obsecure),
        ],
      )
    );
  }
}