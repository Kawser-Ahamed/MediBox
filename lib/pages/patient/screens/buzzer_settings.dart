import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:medibox/constant/app_color.dart';
import 'package:medibox/constant/my_text.dart';
import 'package:medibox/pages/patient/screens/patient_homepage.dart';
import 'package:medibox/services/patient/buzzer_setting_service.dart';

class BuzzerSettings extends StatefulWidget {
  const BuzzerSettings({super.key});

  @override
  State<BuzzerSettings> createState() => _BuzzerSettingsState();
}

class _BuzzerSettingsState extends State<BuzzerSettings> {

  String buzzerState = buzzer.toString();
  String ledState = led.toString();
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
                height: 250.h,
                width: double.maxFinite.w,
                color: AppColor.mainColor,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 50.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: (){
                          Get.back();
                        },
                        child: Icon(
                          Icons.arrow_back,
                          size: 100.sp,
                        ),
                      ),
                      MyText(text: "MediBox", size: 60.sp, overflow: false, bold: true, color: Colors.black),
                      Icon(
                        Icons.settings,
                        size: 100.sp,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 200.h),
              Row(
                children: [
                  SizedBox(width: 30.w),
                  MyText(text: "Turn on/off the buzzer", size: 60.sp, overflow: false, bold: true, color: Colors.black),
                  SizedBox(width: 50.w),
                  Container(
                    height: 120.h,
                    width: 320.w,
                    decoration: BoxDecoration(
                      color: (buzzerState=="on")?Colors.green : Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(100.sp)),
                    ),
                    child: Stack(
                      children: [
                        AnimatedPositioned(
                          duration: const Duration(milliseconds: 700),
                          top: 15.h,
                          bottom: 15.w,
                          left: (buzzerState=="on") ? 200.w : 0.w,
                          right: (buzzerState=="on") ? 0.w : 200.w,
                          child: GestureDetector(
                            onTap: (){
                              (buzzerState=="on") ? buzzerState = "off" : buzzerState = "on";
                              BuzzerSettingService.buzzerSettingsfunctionalities(buzzerState);
                              setState(() {
                                
                              });
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: MyText(text: buzzerState, size: 40.sp, overflow: false, bold: false, color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50.h),
              Row(
                children: [
                  SizedBox(width: 30.w),
                  MyText(text: "Turn on/off the led", size: 60.sp, overflow: false, bold: true, color: Colors.black),
                  SizedBox(width: 150.w),
                  Container(
                    height: 120.h,
                    width: 320.w,
                    decoration: BoxDecoration(
                      color: (ledState=="on")?Colors.green : Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(100.sp)),
                    ),
                    child: Stack(
                      children: [
                        AnimatedPositioned(
                          duration: const Duration(milliseconds: 700),
                          top: 15.h,
                          bottom: 15.w,
                          left: (ledState=="on") ? 200.w : 0.w,
                          right: (ledState=="on") ? 0.w : 200.w,
                          child: GestureDetector(
                            onTap: (){
                              (ledState=="on") ? ledState = "off" : ledState = "on";
                              BuzzerSettingService.ledSettingsfunctionalities(ledState);
                              setState(() {
                                
                              });
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: MyText(text: ledState, size: 40.sp, overflow: false, bold: false, color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      )
    );
  }
}