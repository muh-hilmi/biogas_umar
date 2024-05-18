import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  var suhu = 0.0.obs;
  var gas = 0.0.obs;
  var tekanan = 0.0.obs;
  var pH = 0.0.obs;

  DatabaseReference sensorData = FirebaseDatabase.instance.ref("/Sensor");

  @override
  void onInit() {
    super.onInit();

    sensorData.onValue.listen((event) {
      var data = event.snapshot.value as Map<dynamic, dynamic>?;

      if (data != null) {
        if (data['Suhu'] != null) {
          suhu.value = data['Suhu'];
          print(data['Suhu']);
        }
        if (data['Gas_Metana'] != null) {
          gas.value = data['Gas_Metana'];
        }
        if (data['Tekanan'] != null) {
          tekanan.value = data['Tekanan'];
        }
        if (data['PH'] != null) {
          pH.value = data['PH'];
        }
      }
    });
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamUser() async* {
    String uid = await auth.currentUser!.uid;

    yield* firestore.collection("users").doc(uid).snapshots();
  }
}
