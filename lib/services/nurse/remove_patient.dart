import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medibox/pages/homepage.dart';
import 'package:medibox/pages/nurse/screens/edit_prescription.dart';
import 'package:medibox/pages/nurse/screens/individual_patient.dart';

class RemovePatient{
  static void removePatientInformation()async{
    try{
      final CollectionReference collectionReference =FirebaseFirestore.instance.collection('$patientEmailForNurse-Nurse');
      final QuerySnapshot querySnapshot = await collectionReference.get();

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        await doc.reference.delete();
      }
      //await collectionReference.parent!.delete();
    }
    catch(error){
      // ignore: avoid_print
      print(error);
    }
  }
  static void removeNurseInformation() async{
      final firestore = FirebaseFirestore.instance.collection(patientEmailForNurse);
      firestore.doc(patientIdforNurse).update({
        'Nurse' : "false",
      });
    
      final CollectionReference deleteDocument = FirebaseFirestore.instance.collection('$nurseEmail-Patients');

      final DocumentReference documentReference = deleteDocument.doc(patientEmailForNurse);

      await documentReference.delete();
  }

}