import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controller/HomeController/home_controller.dart';
import '../../Utils/Colors/color_resource.dart';
import '../../Utils/Constant/text_context.dart';
import '../Attendance Screen/attendance_screen.dart';
import 'package:flutter_svg/svg.dart';
import 'package:connectivity_widget/connectivity_widget.dart';

HomeController homeController = Get.put(HomeController());
class HomeBodyScreen extends StatelessWidget {
  const HomeBodyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConnectivityWidget(
        showOfflineBanner: false,
        builder: (context, isOnline) {
          return isOnline?
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _greetings(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Image.asset('assets/images/banner.png'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: _homeCard(),
              ),
            ],
          ):SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.wifi_off,size: 120,color: kPrimaryColor,),
                    SizedBox(height: 5,),
                    Text("No Internet Connection Found!"),
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}

Widget _homeBody(){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _greetings(),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Image.asset('assets/images/banner.png'),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: _homeCard(),
      ),
    ],
  );
}
Widget _greetings(){

  return Container(
    padding: kDefaultPadding,
    margin: const EdgeInsets.symmetric(vertical: 10),
    child: Row(
      children: [
        const CircleAvatar(
          radius: 30,
          backgroundColor: ColorResources.PRIMARY_COLOR,
          child: Icon(
            Icons.account_circle,
            size: 40,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children:  [
                const Text(
                  'Hi, ',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20.0,
                  ),
                ),
                Text(
                  homeController.userName.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2F2F7E),
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Obx(() =>
                Text(
                  homeController.greeting.toString(),
                  style: const TextStyle(
                    color: Color(0xFF6E6E6E),
                  ),
                ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _homeCard(){
  return GestureDetector(
    onTap: (){
      //homeController.start();
      Get.toNamed(AttendanceScreen.routeName);
    },
    child: Container(
      width: Get.size.width * 0.45,
      height: 160,
      decoration: const BoxDecoration(
        color: Color(0xFFEEEFF1),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset('assets/icons/attendance.svg'),
          const SizedBox(height: 10),
          const Text('Attendance'),
        ],
      ),
    ),
  );
}