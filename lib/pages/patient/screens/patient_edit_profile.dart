
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medibox/constant/app_color.dart';
import 'package:medibox/constant/my_text.dart';
import 'package:medibox/pages/patient/screens/patient_homepage.dart';
import 'package:medibox/services/patient/patient_update_profile.dart';
import 'package:medibox/ui/text_field.dart';

class PatientEditProfile extends StatefulWidget {
  const PatientEditProfile({super.key});

  @override
  State<PatientEditProfile> createState() => _PatientEditProfileState();
}

class _PatientEditProfileState extends State<PatientEditProfile> {

  TextEditingController doctor = TextEditingController();
  TextEditingController history = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController phone = TextEditingController();

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
                SizedBox(height: 30.h),
                GestureDetector(
                  onTap: (){
                    Get.to(const PatientHomePage());
                  },
                  child: Container(
                    height: 150.h,
                    width: 150.w,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.arrow_back,
                        size: 80.sp,
                        color: Colors.black,
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
                Text("Edit Profile",
                  style: GoogleFonts.arima(
                    fontSize: 100.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 50.h),
                Container(
                  height: 1000.h,
                  width: double.maxFinite.w,
                  color: Colors.transparent,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [  
                        SizedBox(height: 50.w),
                        customContainer("Doctor Name", doctor, Icons.person, false),
                        SizedBox(height: 50.w),
                        customContainer("Medical History", history, Icons.history, false),
                        SizedBox(height: 50.w),
                        customContainer("Gender", gender, Icons.male, false),
                        SizedBox(height: 50.w),
                        customContainer("Mobile Number",phone,Icons.phone,false),
                        SizedBox(height: 250.h),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 200.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: (){
                        PatientEditProfileServicees.update(phone.text, doctor.text, history.text, gender.text);
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
                        child: MyText(text: "Update", size: 60.sp, overflow: false, bold: true, color: Colors.white),
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