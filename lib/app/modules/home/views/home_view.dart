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
              // Aksi yang ingin Anda lakukan ketika ikon ditekan
            },
          ),
        ],
      ),
      body: ListView(
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
            'Halo, Umar Nugraha!',
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
                        child: Column(
                          children: [
                            Text(
                              i == 'Temp'
                                  ? '25 °C'
                                  : i == 'Pressure'
                                      ? '200 KPA'
                                      : i == 'pH'
                                          ? '6,9'
                                          : i == 'Gas'
                                              ? '25'
                                              : "?",
                              style: GoogleFonts.inter(
                                color: const Color(0xff0077C0),
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              '$i',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ));
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          Divider(height: 0.2, color: const Color(0xff0077C0).withOpacity(0.3)),
          const SizedBox(height: 10),
          Text(
            'History',
            style: GoogleFonts.inter(
              fontSize: 24,
              color: const Color(0xff0077C0),
              fontWeight: FontWeight.w600,
            ),
          ),
          const DynamicLineAreaChart(
            title: 'Temperature',
            yAxisTitle: 'Temperature (in °C)',
            chartData: [
              {'day': 'Mon', 'value': 25.0},
              {'day': 'Tue', 'value': 26.0},
              {'day': 'Wed', 'value': 27.0},
              {'day': 'Thu', 'value': 26.5},
              {'day': 'Fri', 'value': 28.0},
              {'day': 'Sat', 'value': 27.5},
              {'day': 'Sun', 'value': 26.0},
            ],
          ),
          const DynamicLineAreaChart(
            title: 'Pressure',
            yAxisTitle: 'Pressure (in KPA)',
            chartData: [
              {'day': 'Mon', 'value': 25.0},
              {'day': 'Tue', 'value': 26.0},
              {'day': 'Wed', 'value': 27.0},
              {'day': 'Thu', 'value': 26.5},
              {'day': 'Fri', 'value': 28.0},
              {'day': 'Sat', 'value': 27.5},
              {'day': 'Sun', 'value': 26.0},
            ],
          ),
          const DynamicLineAreaChart(
            title: 'pH',
            yAxisTitle: 'pH',
            chartData: [
              {'day': 'Mon', 'value': 25.0},
              {'day': 'Tue', 'value': 26.0},
              {'day': 'Wed', 'value': 27.0},
              {'day': 'Thu', 'value': 26.5},
              {'day': 'Fri', 'value': 28.0},
              {'day': 'Sat', 'value': 27.5},
              {'day': 'Sun', 'value': 26.0},
            ],
          ),
          const DynamicLineAreaChart(
            title: 'Gas',
            yAxisTitle: 'Gas',
            chartData: [
              {'day': 'Mon', 'value': 25.0},
              {'day': 'Tue', 'value': 26.0},
              {'day': 'Wed', 'value': 27.0},
              {'day': 'Thu', 'value': 26.5},
              {'day': 'Fri', 'value': 28.0},
              {'day': 'Sat', 'value': 27.5},
              {'day': 'Sun', 'value': 26.0},
            ],
          ),
        ],
      ),
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
          xValueMapper: (Map<String, dynamic> data, _) => data['day']!,
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
          xValueMapper: (Map<String, dynamic> data, _) => data['day']!,
          yValueMapper: (Map<String, dynamic> data, _) => data['value'],
          color: Colors.blue.withOpacity(0.3), // Warna biru dengan opacity 0.3
        ),
      ],
      tooltipBehavior: TooltipBehavior(enable: true, header: title),
    );
  }
}
