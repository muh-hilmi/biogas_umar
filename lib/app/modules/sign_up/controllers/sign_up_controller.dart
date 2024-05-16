import 'package:biogas_umar/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController namaSignupC = TextEditingController();
  TextEditingController telponSignupC = TextEditingController();
  TextEditingController emailSignupC = TextEditingController();
  TextEditingController passSignupC = TextEditingController();
  var isPassHidden = true.obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  void signup() async {
    if (namaSignupC.text.isNotEmpty &&
        telponSignupC.text.isNotEmpty &&
        emailSignupC.text.isNotEmpty &&
        passSignupC.text.isNotEmpty) {
      isLoading.value = true;
      try {
        UserCredential userCredential =
            await auth.createUserWithEmailAndPassword(
          email: emailSignupC.text,
          password: passSignupC.text,
        );
        if (userCredential.user != null) {
          String uid = userCredential.user!.uid;
          firestore.collection("users").doc(uid).set({
            "nama": namaSignupC.text,
            "email": emailSignupC.text,
            "telepon": telponSignupC.text,
            "uid": uid,
            "createdAt": Timestamp.fromDate(DateTime.now()),
          });
          // await userCredential.user!.sendEmailVerification();
          Get.offAllNamed(Routes.SIGN_IN);
          Get.snackbar("Berhasil", "Akun Anda berhasil dibuat");
        }

        // print(userCredential);
      } on FirebaseAuthException catch (e) {
        // print(e.code);
        if (e.code == "weak-password") {
          isLoading.value = false;
          Get.snackbar(
              "Terjadi Kesalahan", "Anda menggunakan Password yang lemah");
        } else if (e.code == 'email-already-in-use') {
          isLoading.value = false;
          Get.snackbar("Terjadi Kesalahan", "Email Anda sudah digunakan");
        } else if (e.code == 'invalid-email') {
          isLoading.value = false;
          Get.snackbar("Terjadi Kesalahan", "Email Anda tidak benar");
        }
      } catch (e) {
        isLoading.value = false;
        Get.snackbar("Terjadi Kesalahan", "Tidak dapat mendaftarkan.");
      }
    } else {
      isLoading.value = false;
      Get.snackbar("Terjadi Kesalahan", "Harap mengisi, tidak boleh kosong");
    }
  }
}
