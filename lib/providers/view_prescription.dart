import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medibox/constant/app_color.dart';
import 'package:medibox/providers/my_secret_key.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ViewPrescription extends StatefulWidget {
  final String email;
  final String patientName;
  const ViewPrescription({super.key, required this.email, required this.patientName});

  @override
  State<ViewPrescription> createState() => _ViewPrescriptionState();
}

class _ViewPrescriptionState extends State<ViewPrescription> {

var encryptedName = '';
String path = '';
List<String> prescriptionUrls = [];

Future<void> getEncryptedName() async{
  String secretKey = MySecretKey.secretKey;
  final encrypt.Key key = encrypt.Key.fromUtf8(secretKey);
  final encrypt.IV iv = encrypt.IV.fromLength(16);
  final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc));
  final encrypted = encrypter.encrypt(widget.patientName, iv: iv);
  encryptedName = encrypted.base64;
  path = encryptedName.toString();
}

Future<void> loadPrescriptionUrls() async{
  try{
    firebase_storage.ListResult  result = await firebase_storage.FirebaseStorage.instance.ref(path).listAll();
    List<firebase_storage.Reference> allFiles = result.items;
    for(var file in allFiles){
      String downloadLink = await file.getDownloadURL();
      setState(() {
        prescriptionUrls.add(downloadLink);
      });
    }
  }
  catch(error){
    // ignore: avoid_print
    print('error occur on prescription load $error');
  }
}


@override
  void initState() {
    getEncryptedName();
    loadPrescriptionUrls();
    super.initState();
  }
  
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
                color: Colors.transparent,
                child: (prescriptionUrls.isNotEmpty) ? ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: prescriptionUrls.length,
                    itemBuilder: (context, index) {
                      String url = prescriptionUrls[index];
                      return Container(
                        height: 1500.h,
                        width: 980.w,
                        color: Colors.transparent,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 100.h,
                              width: 850.w,
                              color: Colors.transparent,
                              child: Center(
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: prescriptionUrls.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      height: 20.h,
                                      width: 20.w,
                                      margin: EdgeInsets.only(right: 20.w),
                                      decoration: const BoxDecoration(
                                        color: Colors.black,
                                        shape: BoxShape.circle,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: 50.h),
                            Container(
                              height: 1300.h,
                              width: 980.w,
                              margin: EdgeInsets.symmetric(horizontal: 50.w),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                image: DecorationImage(
                                  image: NetworkImage(url),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                      
                          ],
                        ),
                      );
                    },
                ) : Container(
                  height: 1500.h,
                  width: double.maxFinite.w,
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                    image: DecorationImage(
                      image: AssetImage('assets/images/prescription.jpg'),
                    ),
                  ),
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