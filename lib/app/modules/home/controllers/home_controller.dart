import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeController extends GetxController {
  var suhuSensor = 0.0.obs;
  var gasSensor = 0.0.obs;
  var tekananSensor = 0.0.obs;
  var phSensor = 0.0.obs;

  var suhuHistory = [].obs;
  var gasHistory = [].obs;
  var tekananHistory = [].obs;
  var phHistory = [].obs;

  var isTemperatureChartVisible = false.obs;
  var isPressureChartVisible = false.obs;
  var isPhChartVisible = false.obs;
  var isGasChartVisible = false.obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  String thisDay = DateFormat('dd MM yyyy').format(DateTime.now());

  DatabaseReference sensorData = FirebaseDatabase.instance.ref("/Biogas_IoT");
  DatabaseReference historyData = FirebaseDatabase.instance.ref("/History");

  @override
  void onInit() {
    super.onInit();
    fetchSensorData();
    fetchHistoryData();
  }

  void fetchSensorData() {
    sensorData.onValue.listen((event) {
      var data = event.snapshot.value as Map<dynamic, dynamic>?;
      if (data != null) {
        updateObservable(gasSensor, data['Gas_Metana']);
        updateObservable(phSensor, data['PH']);
        updateObservable(suhuSensor, data['Suhu']);
        updateObservable(tekananSensor, data['Tekanan']);
      }
    });
  }

  void fetchHistoryData() {
    historyData.onValue.listen((event) {
      var data = event.snapshot.value as Map<dynamic, dynamic>?;
      if (data != null) {
        // Bersihkan observables sebelum menambahkan data baru
        suhuHistory.clear();
        tekananHistory.clear();
        phHistory.clear();
        gasHistory.clear();

        data.forEach((key, value) {
          if (key.contains(thisDay)) {
            String jamDanMenit =
                key.substring(key.indexOf("at ") + 3, key.lastIndexOf(":"));

            // Menambahkan data suhu
            double suhu = double.parse(value['Suhu'].toString());
            String roundedSuhu = suhu.toStringAsFixed(1);
            suhuHistory.add({
              'hour': jamDanMenit,
              'Suhu': double.parse(roundedSuhu),
            });

            // Menambahkan data tekanan
            double tekanan = double.parse(value['Tekanan'].toString());
            String roundedTekanan = tekanan.toStringAsFixed(1);
            tekananHistory.add({
              'hour': jamDanMenit,
              'Tekanan': double.parse(roundedTekanan),
            });

            // Menambahkan data pH
            double ph = double.parse(value['PH'].toString());
            String roundedPh = ph.toStringAsFixed(1);
            phHistory.add({
              'hour': jamDanMenit,
              'PH': double.parse(roundedPh),
            });

            // Menambahkan data gas metana
            double gas = double.parse(value['Gas_Metana'].toString());
            String roundedGas = gas.toStringAsFixed(1);
            gasHistory.add({
              'hour': jamDanMenit,
              'Gas_Metana': double.parse(roundedGas),
            });
          }
        });

        // Mengurutkan observables berdasarkan hour (jam dan menit)
        suhuHistory.sort((a, b) => a['hour'].compareTo(b['hour']));
        tekananHistory.sort((a, b) => a['hour'].compareTo(b['hour']));
        phHistory.sort((a, b) => a['hour'].compareTo(b['hour']));
        gasHistory.sort((a, b) => a['hour'].compareTo(b['hour']));

        // print("suhuHistory: $suhuHistory");
        // print("tekananHistory: $tekananHistory");
        // print("phHistory: $phHistory");
        // print("gasHistory: $gasHistory");
      }
    });
  }

  void updateObservable(RxDouble observable, dynamic value) {
    if (value != null) {
      if (value is int) {
        observable.value = value.toDouble();
      } else if (value is double) {
        observable.value = value;
      } else {
        // Handle the case where the value is neither int nor double
        print("Invalid value type: ${value.runtimeType}");
      }
    }
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamUser() async* {
    String uid = auth.currentUser!.uid;

    yield* firestore.collection("users").doc(uid).snapshots();
  }
}
