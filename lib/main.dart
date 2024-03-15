import 'package:biogas_umar/app/views/views/splashscreen_view.dart';
import 'package:biogas_umar/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // FirebaseDatabase.instance.setPersistenceEnabled(true);
  // await NotificationService.initializeNotif();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  // final pageindex = Get.put(PageIndexController());
  // final home = Get.put(HomeView());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(const Duration(seconds: 2)),
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return SplashscreenView();
        } else {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: "BioSmart Monitoring",
            initialRoute: FirebaseAuth.instance.currentUser != null
                ? FirebaseAuth.instance.currentUser!.emailVerified == true
                    ? Routes.HOME
                    : Routes.SIGN_IN
                : Routes.WELCOME,
            getPages: AppPages.routes,
          );
        }
      },
    );
  }
}
