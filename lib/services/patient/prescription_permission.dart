import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medibox/pages/homepage.dart';
import 'package:medibox/pages/patient/screens/prescription_upload.dart';

class PrescriptionPermission{
  Future<void> prescriptionPermission(bool permission)async{
    FirebaseFirestore.instance.collection(patientEmail).doc(patientId).update({
      'Prescription Permission' : permission.toString(), 
    });
  }
}