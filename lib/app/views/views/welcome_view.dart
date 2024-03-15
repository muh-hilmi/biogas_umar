import 'package:biogas_umar/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeView extends GetView {
  const WelcomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFAFAFA),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const SizedBox(height: 20),
              Text(
                "Bio Smart Monitoring",
                style: GoogleFonts.inter(
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 75),
              Image.asset(
                'assets/logo/logobiogas.png',
                height: 300,
              ),
              const SizedBox(height: 100),
              Text(
                "Aplikasi monitoring dengan sensor yang dapat membantu anda!",
                style: GoogleFonts.inter(
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: Get.width,
                child: ElevatedButton(
                  onPressed: () {
                    Get.toNamed(Routes.SIGN_IN);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0XFF0077C0),
                    padding: const EdgeInsets.symmetric(
                      vertical: 18,
                    ),
                  ),
                  child: Text(
                    "Masuk ke Aplikasi",
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      color: const Color(0xffFAFAFA),
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
