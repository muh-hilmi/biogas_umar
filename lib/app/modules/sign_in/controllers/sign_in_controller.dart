import 'package:biogas_umar/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController emailSigninC = TextEditingController();
  TextEditingController passSigninC = TextEditingController();
  TextEditingController newPassC = TextEditingController();

  var isPassHidden = true.obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  void resetPassword() async {
    try {
      if (emailSigninC.text.isNotEmpty) {
        await auth.sendPasswordResetEmail(email: emailSigninC.text);
        Get.back();
        Get.snackbar(
          "Berhasil",
          "Email Anda sudah dikirim. Mohon periksa kotak email Anda",
        );
      } else {
        Get.snackbar("Error", "Harap mengisi, tidak boleh kosong");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        Get.snackbar("Terjadi Kesalahan", "Email tidak terdaftar");
      }
    } catch (e) {
      Get.snackbar(
          "Terjadi Kesalahan", "Tidak dapat mengirim email reset password.");
    }
  }

  Future<void> login() async {
    if (emailSigninC.text.isNotEmpty && passSigninC.text.isNotEmpty) {
      isLoading.value = true;
      try {
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: emailSigninC.text,
          password: passSigninC.text,
        );
        // print(userCredential);

        if (userCredential.user != null) {
          Get.offAllNamed(Routes.HOME);
        }
      } on FirebaseAuthException catch (e) {
        // print(e.code);
        if (e.code == 'invalid-credential') {
          isLoading.value = false;
          Get.snackbar(
              "Terjadi Kesalahan", "Email atau Paswoord Anda tidak benar");
        }
      } catch (e) {
        isLoading.value = false;
        Get.snackbar("Terjadi Kesalahan", "Tidak dapat login.");
      }
    } else {
      isLoading.value = false;
      Get.snackbar("Terjadi Kesalahan", "Harap mengisi, tidak boleh kosong");
    }
  }
}
