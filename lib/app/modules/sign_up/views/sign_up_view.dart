import 'package:biogas_umar/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/sign_up_controller.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign Up',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SizedBox(
            height: Get.height * 0.15,
            child: Image.asset(
              'assets/logo/logobiogas.png',
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Please fill in the form below",
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            style: GoogleFonts.inter(fontSize: 20),
            controller: controller.namaSignupC,
            cursorColor: const Color(0xff0077C0),
            decoration: InputDecoration(
              label: Text(
                "Full name",
                style: GoogleFonts.inter(
                  color: const Color(0xff0077C0),
                  fontSize: 18,
                ),
              ),
              fillColor: const Color(0xffF6F7FA),
              filled: true,
              border: InputBorder.none,
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            style: GoogleFonts.inter(fontSize: 20),
            controller: controller.emailSignupC,
            cursorColor: const Color(0xff0077C0),
            decoration: InputDecoration(
              label: Text(
                "Email",
                style: GoogleFonts.inter(
                  color: const Color(0xff0077C0),
                  fontSize: 18,
                ),
              ),
              fillColor: const Color(0xffF6F7FA),
              filled: true,
              border: InputBorder.none,
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            style: GoogleFonts.inter(fontSize: 20),
            controller: controller.telponSignupC,
            cursorColor: const Color(0xff0077C0),
            decoration: InputDecoration(
              label: Text(
                "Enter your phone",
                style: GoogleFonts.inter(
                  color: const Color(0xff0077C0),
                  fontSize: 18,
                ),
              ),
              fillColor: const Color(0xffF6F7FA),
              filled: true,
              border: InputBorder.none,
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            style: GoogleFonts.inter(fontSize: 20),
            controller: controller.passSignupC,
            cursorColor: const Color(0xff0077C0),
            decoration: InputDecoration(
              label: Text(
                "Enter your password",
                style: GoogleFonts.inter(
                  color: const Color(0xff0077C0),
                  fontSize: 18,
                ),
              ),
              fillColor: const Color(0xffF6F7FA),
              filled: true,
              border: InputBorder.none,
            ),
          ),
          const SizedBox(height: 20),
          Obx(() {
            return SizedBox(
              width: Get.width,
              child: ElevatedButton(
                onPressed: () {
                  if (controller.isLoading.isFalse) {
                    controller.signup();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0XFF0077C0),
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                  ),
                ),
                child: controller.isLoading.isTrue
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : Text(
                        "Sign Up",
                        style: GoogleFonts.inter(
                          fontSize: 20,
                          color: const Color(0xffFAFAFA),
                        ),
                      ),
              ),
            );
          }),
          const SizedBox(height: 100),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already have an account?",
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  Get.toNamed(Routes.SIGN_IN);
                },
                child: Text(
                  "Login",
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xff0077C0),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
