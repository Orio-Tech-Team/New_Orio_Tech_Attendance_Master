import 'package:get/get.dart';
import 'package:orio_tech_attendance_app/Screens/Home%20Screen/home_screen.dart';
import 'package:orio_tech_attendance_app/Screens/Login%20Screen/login_screen.dart';
import 'package:get_storage/get_storage.dart';
import 'package:orio_tech_attendance_app/Utils/Constant/text_context.dart';
import 'package:orio_tech_attendance_app/Utils/Routes/navigate.dart';

import '../../Screens/Bottom Navigation Screen/bottom_navigation_screen.dart';

class SplashController extends GetxController{
  final box = GetStorage();
  String? isVerified;
  @override
  void onInit() {
    isVerified = box.read('user_verify');
    showSplashDuration();
    super.onInit();

  }

  void showSplashDuration() async {
    Future.delayed(const Duration(seconds: 3), () {
      if(isVerified != null){
        //Navigate.to(context, route)
        Get.offAllNamed(HomeScreen.routeName);
      }else{
        Get.offAllNamed(LoginScreen.routeName);
      }
    });
  }
}