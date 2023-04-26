import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orio_tech_attendance_app/Controller/SplashController/splash_controller.dart';
import 'package:orio_tech_attendance_app/Screens/Login%20Screen/login_screen.dart';
import 'package:orio_tech_attendance_app/Utils/Colors/color_resource.dart';
import '../../Utils/Constant/text_context.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

import '../Button/button.dart';
import '../Button/outline_button.dart';

class BuildAppBar extends StatelessWidget with PreferredSizeWidget {
  const BuildAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    void onLogout() async {
      await GetStorage.init();
      await GetStorage().erase();
      positionStreamSubscription.cancel();
      Get.offAllNamed(LoginScreen.routeName);
    }

    return Container(
      padding: kDefaultPadding,
      child: SafeArea(
        child: SizedBox(
          height: 200,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset('assets/logos/appbar_logo.svg', height: 28),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  width: 150,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: ColorResources.APP_BAR_COLOR,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/icons/search.svg'),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: TextField(
                          enabled: false,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () => showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: SizedBox(
                        height: 280,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 245, 99, 9)
                                    .withOpacity(0.3),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.question_mark,
                                size: 60,
                                color: Colors.red,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'Alert',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 25.0,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              'Are you sure you want to Logout?',
                              style: TextStyle(
                                color: Color(0xFF6E6E6E),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: OutlineButton(
                                      child: const Text("cancel"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      }),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Button(
                                      onPressed: onLogout,
                                      child: const Text("Logout")),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
                child: SvgPicture.asset(
                  'assets/icons/logout.svg',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
