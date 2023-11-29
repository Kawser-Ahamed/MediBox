import 'package:firebase_database/firebase_database.dart';
import 'package:medibox/pages/patient/screens/patient_homepage.dart';

class BuzzerSettingService{
  static Future<void> buzzerSettingsfunctionalities(String buzzerState) async{
    FirebaseDatabase database = FirebaseDatabase.instance;
    database.ref('Patient-Time-Scheduling').child(userId).update(
      {
        'buzzer' : buzzerState,
      }
    );
  }
  static Future<void> ledSettingsfunctionalities(String ledState) async{
    FirebaseDatabase database = FirebaseDatabase.instance;
    database.ref('Patient-Time-Scheduling').child(userId).update(
      {
        'led' : ledState,
      }
    );
  }
}