import 'package:biogas_umar/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Profile',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: controller.streamUser(),
          builder: (context, snap) {
            if (snap.hasData) {
              Map<String, dynamic> user = snap.data!.data()!;

              return ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  const SizedBox(height: 20),
                  Center(
                    child: Column(children: [
                      const SizedBox(height: 10),
                      Text(
                        '${user['nama'].toString()}',
                        style: GoogleFonts.inter(
                          fontSize: 24,
                          color: const Color(0xff0077C0),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '${user['email'].toString()}',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: const Color(0xff0077C0),
                        ),
                      ),
                      Text(
                        '${user['telepon'].toString()}',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: const Color(0xff0077C0),
                        ),
                      ),
                    ]),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 150),
                    child: ElevatedButton(
                      onPressed: () {
                        Get.defaultDialog(
                          title: "Log Out",
                          titleStyle: GoogleFonts.inter(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                          content: Column(
                            children: [
                              Text(
                                'Do you want to Log Out?',
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          actions: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0XFF0077C0)),
                              onPressed: () async {
                                await FirebaseAuth.instance.signOut();
                                Get.offAllNamed(Routes.SIGN_IN);
                                Get.snackbar(
                                    "Success", "You have been log out");
                              },
                              child: Text(
                                "Yes",
                                style: GoogleFonts.inter(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: Text(
                                "No",
                                style: GoogleFonts.inter(
                                  color: const Color(0XFF0077C0),
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size.fromWidth(Get.width / 3),
                        backgroundColor: const Color(0XFF0077C0),
                        padding: const EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal:
                              0, // Menambahkan padding horizontal jika diperlukan
                        ),
                      ),
                      child: Text(
                        "Log Out",
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: const Color(0xffFAFAFA),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Divider(
                    height: 0.2,
                    color: const Color(0xff0077C0).withOpacity(0.3),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'All About\nBioGas Monitoring',
                    style: GoogleFonts.inter(
                      fontSize: 22,
                      color: const Color(0xff0077C0),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 50, // Menentukan lebar Container
                        height: 50, // Menentukan tinggi Container
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/picts/termometer.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(
                          width:
                              15), // Memberi jarak antara Container dan Column
                      Expanded(
                        // Menambahkan Expanded agar teks tidak terpotong
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment
                              .start, // Menjaga teks di awal kolom
                          children: [
                            Text(
                              'Suhu',
                              style: GoogleFonts.inter(
                                fontSize: 18,
                                color: const Color(0xff0077C0),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'Pemantauan suhu dalam reaktor biogas krusial untuk menjaga proses anaerobik yang efisien. Suhu yang optimal diperlukan agar aktivitas mikroba tetap berjalan dengan baik. Suhu terlalu rendah dapat menghambat mikroba, sementara suhu yang terlalu tinggi bisa membahayakan kelangsungan pengguna.',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 50, // Menentukan lebar Container
                        height: 50, // Menentukan tinggi Container
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/picts/pH.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        // Menambahkan Expanded agar teks tidak terpotong
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment
                              .start, // Menjaga teks di awal kolom
                          children: [
                            Text(
                              'pH',
                              style: GoogleFonts.inter(
                                fontSize: 18,
                                color: const Color(0xff0077C0),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'Sensor pH memiliki peran penting dalam sistem biogas untuk mengukur tingkat keasaman atau kebasaan (pH) dalam lingkungan reaktor biogas.Sensor pH membantu dalam menjaga lingkungan reaktor biogas tetap seimbang dan sesuai dengan kondisi yang dibutuhkan untuk proses anaerobik.',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 50, // Menentukan lebar Container
                        height: 50, // Menentukan tinggi Container
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/picts/gauge.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        // Menambahkan Expanded agar teks tidak terpotong
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment
                              .start, // Menjaga teks di awal kolom
                          children: [
                            Text(
                              'Pressure',
                              style: GoogleFonts.inter(
                                fontSize: 18,
                                color: const Color(0xff0077C0),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'Sensor tekanan gas memantau tekanan di dalam sistem biogas. Fungsi utamanya adalah untuk mendeteksi deviasi atau fluktuasi tekanan yang dapat menandakan adanya masalah atau potensi bahaya. Hal ini membantu menjaga keamanan operasional sistem dan mencegah kebocoran gas yang berbahaya.',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 50, // Menentukan lebar Container
                        height: 50, // Menentukan tinggi Container
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/picts/gas.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        // Menambahkan Expanded agar teks tidak terpotong
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment
                              .start, // Menjaga teks di awal kolom
                          children: [
                            Text(
                              'Gas',
                              style: GoogleFonts.inter(
                                fontSize: 18,
                                color: const Color(0xff0077C0),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '??????????????????????????',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
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
