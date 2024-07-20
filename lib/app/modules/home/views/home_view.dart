import 'package:biogas_umar/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../controllers/home_controller.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.amber,
      appBar: AppBar(
        title: Text(
          'Home',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.person_outlined,
              color: Color(0xff0077C0),
            ),
            onPressed: () {
              Get.toNamed(Routes.PROFILE);
            },
          ),
        ],
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: controller.streamUser(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Map<String, dynamic> user = snapshot.data!.data()!;

              return ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  Text(
                    'BioGas \nMonitoring',
                    style: GoogleFonts.inter(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 75),
                  Text(
                    'Halo, ${user['nama'].toString()}!',
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      color: const Color(0xff0077C0),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 30),
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 100,
                      viewportFraction: 0.33,
                      autoPlay: true,
                    ),
                    items: ['Temp', 'Pressure', 'pH', 'Gas'].map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                              width: Get.width,
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                  color: const Color(0xffC7EEFF),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Container(
                                margin: const EdgeInsets.all(16),
                                child: Obx(() {
                                  return Column(
                                    children: [
                                      Text(
                                        i == 'Temp'
                                            ? '${controller.suhuSensor.toStringAsFixed(1)} °C'
                                            : i == 'Pressure'
                                                ? '${controller.tekananSensor.toStringAsFixed(2)} KPA'
                                                : i == 'pH'
                                                    ? controller.phSensor
                                                        .toStringAsFixed(2)
                                                    : i == 'Gas'
                                                        ? controller.gasSensor
                                                            .toStringAsFixed(2)
                                                        : "?",
                                        style: GoogleFonts.inter(
                                          color: const Color(0xff0077C0),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        i,
                                        style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                              ));
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  Divider(
                      height: 0.2,
                      color: const Color(0xff0077C0).withOpacity(0.3)),
                  const SizedBox(height: 10),
                  Text(
                    'History on this day',
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      color: const Color(0xff0077C0),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Obx(() {
                    // Gunakan Obx untuk mendengarkan perubahan pada suhuHistory
                    var suhuHistory = controller.suhuHistory;
                    return suhuHistory.isEmpty
                        ? CircularProgressIndicator() // Tampilkan loading jika data masih kosong
                        : DynamicLineAreaChart(
                            title: 'Temperature',
                            yAxisTitle: 'Temperature (in °C)',
                            chartData: suhuHistory.map((data) {
                              // Konversi data ke format yang dibutuhkan oleh DynamicLineAreaChart
                              return {
                                'hour': data['hour'],
                                'value': data['Suhu']
                              };
                            }).toList(),
                          );
                  }),
                  Obx(() {
                    // Gunakan Obx untuk mendengarkan perubahan pada suhuHistory
                    var tekananHistory = controller.tekananHistory;
                    return tekananHistory.isEmpty
                        ? CircularProgressIndicator() // Tampilkan loading jika data masih kosong
                        : DynamicLineAreaChart(
                            title: 'Pressure',
                            yAxisTitle: 'Pressure (in KPA)',
                            chartData: tekananHistory.map((data) {
                              // Konversi data ke format yang dibutuhkan oleh DynamicLineAreaChart
                              return {
                                'hour': data['hour'],
                                'value': data['Tekanan']
                              };
                            }).toList(),
                          );
                  }),
                  Obx(() {
                    // Gunakan Obx untuk mendengarkan perubahan pada suhuHistory
                    var phHistory = controller.phHistory;
                    return phHistory.isEmpty
                        ? CircularProgressIndicator() // Tampilkan loading jika data masih kosong
                        : DynamicLineAreaChart(
                            title: 'pH',
                            yAxisTitle: 'pH',
                            chartData: phHistory.map((data) {
                              // Konversi data ke format yang dibutuhkan oleh DynamicLineAreaChart
                              return {
                                'hour': data['hour'],
                                'value': data['PH']
                              };
                            }).toList(),
                          );
                  }),
                  Obx(() {
                    // Gunakan Obx untuk mendengarkan perubahan pada suhuHistory
                    var gasHistory = controller.gasHistory;
                    return gasHistory.isEmpty
                        ? CircularProgressIndicator() // Tampilkan loading jika data masih kosong
                        : DynamicLineAreaChart(
                            title: 'Gas',
                            yAxisTitle: 'Gas',
                            chartData: gasHistory.map((data) {
                              // Konversi data ke format yang dibutuhkan oleh DynamicLineAreaChart
                              return {
                                'hour': data['hour'],
                                'value': data['Gas_Metana']
                              };
                            }).toList(),
                          );
                  }),
                ],
              );
            } else {
              return const Center(
                child: Text("Tidak dapat memuat data"),
              );
            }
          }),
    );
  }
}

class DynamicLineAreaChart extends StatelessWidget {
  final String title;
  final String yAxisTitle;
  final List<Map<String, dynamic>> chartData;

  const DynamicLineAreaChart({
    super.key,
    required this.title,
    required this.yAxisTitle,
    required this.chartData,
  });

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      title: ChartTitle(
        text: title,
        textStyle: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
      primaryXAxis: CategoryAxis(
        labelStyle: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        labelPlacement: LabelPlacement.onTicks,
      ),
      primaryYAxis: NumericAxis(
        title: AxisTitle(
          text: yAxisTitle,
          textStyle: GoogleFonts.inter(
            fontSize: 12,
          ),
        ),
        interval: 1,
        labelStyle: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ), // Mengatur interval sumbu Y menjadi 1
      ),
      series: <CartesianSeries<Map<String, dynamic>, String>>[
        LineSeries<Map<String, dynamic>, String>(
          dataSource: chartData,
          xValueMapper: (Map<String, dynamic> data, _) => data['hour']!,
          yValueMapper: (Map<String, dynamic> data, _) => data['value'],
          markerSettings: const MarkerSettings(
            isVisible: true, // Menampilkan marker
          ),
          dataLabelSettings: DataLabelSettings(
            isVisible: true, // Menampilkan label data
            // Mengatur format dan styling label data
            textStyle: GoogleFonts.inter(),
            labelAlignment: ChartDataLabelAlignment.auto,
          ),
        ),
        AreaSeries<Map<String, dynamic>, String>(
          dataSource: chartData,
          xValueMapper: (Map<String, dynamic> data, _) => data['hour']!,
          yValueMapper: (Map<String, dynamic> data, _) => data['value'],
          color: Colors.blue.withOpacity(0.3), // Warna biru dengan opacity 0.3
        ),
      ],
      tooltipBehavior: TooltipBehavior(enable: true, header: title),
    );
  }
}
