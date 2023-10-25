import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medibox/constant/app_color.dart';
import 'package:medibox/constant/my_text.dart';
import 'package:medibox/services/nurse/patient_add_services.dart';
import 'package:url_launcher/url_launcher.dart';

class PatientProfile extends StatefulWidget {
  final String email;
  final String state;
  const PatientProfile({super.key, required this.email, required this.state});

  @override
  State<PatientProfile> createState() => _PatientProfileState();
}

class _PatientProfileState extends State<PatientProfile> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.maxFinite.h,
          width: double.maxFinite.w,
          color: Colors.white,
          child: Stack(
            children: [
              Positioned(
                top: 0.h,
                left: 0.w,
                right: 0.w,
                bottom: 1550.h,
                child: const Image(image: AssetImage('assets/images/patient-profile.jpg'),fit: BoxFit.cover)
              ),
              Positioned(
              top: 20.h,
              bottom: 1920.h,
              left: 50.h,
              right: 900.w,
                child: GestureDetector(
                  onTap: (){
                    Get.back();
                  },
                  child: Container(
                    height: 300.h,
                    width: double.maxFinite.w,
                    margin: EdgeInsets.only(bottom: 50.h),
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
                    child: Icon(Icons.arrow_back,size: 80.sp,),
                  ),
                ),
              ),
              Positioned(
                top: 540.h,
                left: 0.w,
                right: 0.w,
                bottom: 0.h,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(80.sp),
                      topRight: Radius.circular(80.sp),
                    )
                  ),
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance.collection(widget.email).snapshots(), 
                    builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
                      if(snapshot.hasData){
                        List<dynamic> patientList = snapshot.data!.docs.map((doc) => doc.data()).toList();
                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            Map<dynamic,dynamic> patientMap = patientList[index] as Map<dynamic,dynamic>;
                            return Container(
                              height: 1520.h,
                              width: double.maxFinite.w,
                              color: Colors.white,
                              margin: EdgeInsets.only(top: 100.h,left: 50.w,right: 50.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 600.w,
                                        color: Colors.transparent,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                              _customText(snapshot.data!.docs[index]['Patient Name'], 'Open Sans', 60.sp, true,Colors.black),
                                              _customText('Age : ${snapshot.data!.docs[index]['Age']}', 'Open Sans', 55.sp, false,Colors.black),
                                              _customText('Address : ${snapshot.data!.docs[index]['Address']}', 'Open Sans', 55.sp, false,Colors.black),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 50.w),
                                      (widget.state=="profile-nurse")?InkWell(
                                        onTap: () async{
                                           try{
                                              if((patientMap.containsKey('Mobile Number'))){
                                                final Uri callUrl = Uri(
                                                  scheme: 'tel',
                                                  path: patientMap['Mobile Number'],
                                                );
                                              if(await canLaunchUrl(callUrl)){
                                                await launchUrl(callUrl);
                                              }
                                            } 
                                           }
                                           catch(e){
                                            // ignore: avoid_print
                                            print(e);
                                           }
                                        },
                                        child: Container(
                                          height: 150.h,
                                          width: 150.w,
                                          decoration: BoxDecoration(
                                            color: const Color.fromARGB(255, 247, 181, 82),
                                            borderRadius: BorderRadius.all(Radius.circular(20.sp)),
                                          ),
                                          child: const Center(
                                            child: Icon(Icons.phone,color: Colors.white),
                                          ),
                                        ),
                                      ):Container(),
                                      SizedBox(width: 20.w),
                                      (widget.state=="profile-nurse")?InkWell(
                                        onTap: () async{

                                        },
                                        child: Container(
                                          height: 150.h,
                                          width: 150.w,
                                          decoration: BoxDecoration(
                                            color: const Color.fromARGB(255, 101, 227, 187),
                                            borderRadius: BorderRadius.all(Radius.circular(20.sp)),
                                          ),
                                          child: const Center(
                                            child: Icon(Icons.email,color: Colors.white),
                                          ),
                                        ),
                                      ):Container(),
                                    ],
                                  ),
                                  SizedBox(height:20.h),
                                  Divider(thickness: 3.sp,color: Colors.grey),
                                  SizedBox(height: 20.h),
                                  _customText('About Patient', 'Open Sans', 70.sp, true,AppColor.mainColor),
                                  SizedBox(height: 50.h),
                                  _customText('Hospital Name: ${snapshot.data!.docs[index]['Hospital Name']}', 'Open Sans', 50.sp, false,Colors.black),
                                  SizedBox(height: 20.h),
                                  _customText('Ward No: ${snapshot.data!.docs[index]['Ward No']}', 'Open Sans', 50.sp, false,Colors.black),
                                  SizedBox(height: 20.h),
                                  _customText((patientMap.containsKey('Doctor Name')) ? 'Doctor Name: ${patientMap['Doctor Name']}' : ('Doctor Name: (Not Set Yet)'), 'Open Sans', 50.sp, false,Colors.black),
                                  SizedBox(height: 20.h),
                                  _customText((patientMap.containsKey('Medical History')) ? 'Medical History: ${patientMap['Medical History']}' : ('Medical History: (Not Set Yet)'), 'Open Sans', 50.sp, false,Colors.black),
                                  SizedBox(height: 20.h),
                                  _customText((patientMap.containsKey('Gender')) ? 'Gender: ${patientMap['Gender']}' : ('Gender: (Not Set Yet)'), 'Open Sans', 50.sp, false,Colors.black),
                                  SizedBox(height: 20.h),
                                  _customText((patientMap.containsKey('Mobile Number')) ? 'Mobile Number: ${patientMap['Mobile Number']}' : ('Mobile Number: (Not Set Yet)'), 'Open Sans', 50.sp, false,Colors.black),
                                  SizedBox(height: 20.h),
                                  _customText('Email: ${snapshot.data!.docs[index]['Patient Email']}', 'Open Sans', 50.sp, false,Colors.black),
                                  SizedBox(height: 50.h),
                                  Divider(thickness: 3.sp,color: Colors.grey),
                                  SizedBox(height: 50.h),
                                  (patientMap['Nurse']=='true' && widget.state=="search") ? Container(
                                    margin: EdgeInsets.only(left: 140.w),
                                    child: Text("Unable to add this patient",style: GoogleFonts.arima(fontSize: 60.sp,color: Colors.red)))
                                  : (widget.state=="profile"||widget.state=="profile-nurse") ? Container(
                                  ) : Container(
                                    margin: EdgeInsets.only(left: 220.w),
                                    child: ElevatedButton(
                                      onPressed: (){
                                        PatientAddByNurse.patientAdd(patientMap['Patient Id'],patientMap['Patient Name'], patientMap['Patient Email'], patientMap['Age'], patientMap['Address'], patientMap['Hospital Name'], patientMap['Ward No'], (patientMap.containsKey('Doctor Name')? patientMap['Doctor Name'] : "Not Set Yet"), (patientMap.containsKey('Medical History')? patientMap['Medical History'] : "Not Set Yet"), (patientMap.containsKey('Gender')? patientMap['Gender'] : "Not Set Yet"), (patientMap.containsKey('Mobile Number')? patientMap['Mobile Number'] : "Not Set Yet"));
                                      }, 
                                      style: ButtonStyle(
                                        backgroundColor: const MaterialStatePropertyAll(Color.fromARGB(255, 101, 227, 187)),
                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(100.sp),
                                          ),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(vertical: 30.h,horizontal: 50.w),
                                        child: MyText(text: "Add  Patient", size: 60.sp, overflow: false, bold: true, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
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
              ),
            ],
          ),
        ),
      )
    );
  }
  _customText(String text, String fonts, double size,bool bold,Color color){
    return Text(text,
      style: GoogleFonts.getFont(
        fonts,
        fontSize: size,
        fontWeight: (bold) ? FontWeight.bold : FontWeight.normal,
        color: color,
      ),
      overflow: TextOverflow.ellipsis,
    );
  }
}