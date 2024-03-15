import 'package:biogas_umar/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/sign_in_controller.dart';

class SignInView extends GetView<SignInController> {
  const SignInView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const SizedBox(height: 50),
            SizedBox(
              height: Get.height * 0.15,
              child: Image.asset(
                'assets/logo/logobiogas.png',
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Welcome to\nBio Smart Monitoring",
              style: GoogleFonts.inter(
                fontSize: 28,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 50),
            TextField(
              style: GoogleFonts.inter(fontSize: 20),
              controller: controller.emailSigninC,
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
            Obx(
              () => TextField(
                style: GoogleFonts.inter(fontSize: 20),
                controller: controller.passSigninC,
                obscureText: controller.isPassHidden.value,
                decoration: InputDecoration(
                  label: Text(
                    "Password",
                    style: GoogleFonts.inter(
                      color: const Color(0xff0077C0),
                      fontSize: 18,
                    ),
                  ),
                  fillColor: const Color(0xffF6F7FA),
                  filled: true,
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                    icon: Icon(
                      controller.isPassHidden.value
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: const Color(0xff0077C0),
                    ),
                    onPressed: () {
                      controller.isPassHidden.value =
                          !controller.isPassHidden.value;
                    },
                  ),
                ),
              ),
            ),
            // const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Get.defaultDialog(
                      title: "Forgot Password",
                      titleStyle: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      contentPadding: const EdgeInsets.all(16),
                      content: Column(
                        children: [
                          Text(
                            'Enter your email then check your email box',
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: const Color(0xff0077C0),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            style: GoogleFonts.inter(fontSize: 14),
                            controller: controller.emailSigninC,
                            cursorColor: const Color(0xff0077C0),
                            decoration: InputDecoration(
                              label: Text(
                                "Email",
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  color: const Color(0xff0077C0),
                                ),
                              ),
                              fillColor: const Color(0xffF6F7FA),
                              filled: true,
                              border: InputBorder.none,
                            ),
                          ),
                        ],
                      ),
                      actions: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0077C0),
                            padding: const EdgeInsets.symmetric(
                                vertical: 14, horizontal: 20),
                          ),
                          onPressed: () {
                            controller.resetPassword();
                            Get.back(); // Menutup dialog setelah selesai
                          },
                          child: Text(
                            "Change Password",
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.back(); // Tombol untuk menutup dialog
                          },
                          child: Text(
                            "Cancel",
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xff0077C0),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                  child: Text(
                    "Forgot Your Password?",
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Obx(() {
              return SizedBox(
                width: Get.width,
                child: ElevatedButton(
                  onPressed: () {
                    if (controller.isLoading.isFalse) {
                      controller.login();
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
                          "Sign In",
                          style: GoogleFonts.inter(
                            fontSize: 20,
                            color: const Color(0xffFAFAFA),
                          ),
                        ),
                ),
              );
            }),
            const SizedBox(height: 75),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don’t have an account yet?",
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Get.toNamed(Routes.SIGN_UP);
                  },
                  child: Text(
                    "Create an Account",
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
      ),
    );
  }
}
