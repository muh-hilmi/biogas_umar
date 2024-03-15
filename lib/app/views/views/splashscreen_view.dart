import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashscreenView extends GetView {
  const SplashscreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xffFAFAFA),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                // color: Colors.amber,
                child: Image.asset(
                  'assets/logo/logobiogas.png',
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
              Text(
                "Bio Smart Monitoring",
                style: GoogleFonts.inter(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 80),
              const CircularProgressIndicator(color: Color(0xff0077C0)),
            ],
          ),
        ),
      ),
    );
  }
}
