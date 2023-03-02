import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:orio_tech_attendance_app/Screens/Splash%20Screen/splash_screen.dart';
import 'package:orio_tech_attendance_app/Utils/theme/theme_data.dart';
import 'Binding/main_binding.dart';
import 'Utils/Routes/routes.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Orio Attendance App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.themeData(),
      initialBinding: MainBinding(),
      // initialRoute: AuthScreen.routeName,
      initialRoute: SplashScreen.routeName,
      routes: Routes.routes,
      getPages: routes,
    );
  }
}