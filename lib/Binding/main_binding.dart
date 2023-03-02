import 'package:get/get.dart';
import '../Network Manager/network_manager.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager(), permanent: true);
    /*Get.put(AuthService(), permanent: true);
    Get.put(AuthController(), permanent: true);*/
  }
}
