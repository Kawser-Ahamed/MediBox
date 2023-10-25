import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medibox/constant/app_color.dart';
import 'package:medibox/pages/nurse/authentication/nurse_login.dart';
import 'package:medibox/pages/nurse/screens/nurse_homepage.dart';
import 'package:medibox/pages/patient/authentication/patient_login.dart';
import 'package:medibox/pages/patient/screens/patient_homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: prefer_typing_uninitialized_variables
var patientEmail,nurseEmail;

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  void patientValidation() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var email = sharedPreferences.getString('patient-email');
    patientEmail = sharedPreferences.getString('patient-email');
    if(email==null){
      Get.to(const PatientLogin());
    }
    else{
      Get.to(const PatientHomePage());
    }
  }

  void nurseValidation() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var email = sharedPreferences.getString('nurse-email');
    if(email==null){
      Get.to(const NurseLogin());
    }
    else{
      nurseEmail = sharedPreferences.getString('nurse-email');
      Get.to(const NurseHomePage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          decoration: const BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image: AssetImage('assets/images/homepage.jpg'),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap:(){
                  nurseValidation();
                },
                child: Container(
                  height: 800.h,
                  width: 700.w,
                  decoration: BoxDecoration(
                    color: AppColor.mainColor,
                    borderRadius: BorderRadius.all(Radius.circular(40.sp)),
                    // image: const DecorationImage(
                    //   image: AssetImage("assets/images/background.jpg"),
                    //   fit: BoxFit.cover,
                    // ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: const AssetImage("assets/images/nurse.png"),
                        height: 550.h,
                        width: 550.w,
                      ),
                      Text(
                        "Nurse",
                        style: GoogleFonts.robotoCondensed(
                          fontSize: 100.sp,
                        ),
                      )
                    ]
                  ),
                ),
              ),
              SizedBox(height: 100.h),
              GestureDetector(
                onTap: (){
                  patientValidation();
                },
                child: Container(
                  height: 800.h,
                  width: 700.w,
                  decoration: BoxDecoration(
                    color: AppColor.mainColor,
                    borderRadius: BorderRadius.all(Radius.circular(40.sp)),
                    // image: const DecorationImage(
                    //   image: AssetImage("assets/images/2.jpg"),
                    //   fit: BoxFit.fill,
                    // ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: const AssetImage("assets/images/patient.png"),
                        height: 600.h,
                        width: 600.w,
                      ),
                      Text(
                        "Patient",
                        style: GoogleFonts.robotoCondensed(
                          fontSize: 100.sp,
                        ),
                      )
                    ]
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}