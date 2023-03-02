import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orio_tech_attendance_app/Screens/Login%20Screen/login_screen.dart';
import 'package:orio_tech_attendance_app/Utils/Colors/color_resource.dart';
import '../../Utils/Constant/text_context.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
class BuildAppBar extends StatelessWidget with PreferredSizeWidget {
  const BuildAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();

    void onLogout() async {
      box.remove('user_name');
      box.remove('user_phone');
      box.remove('user_token');
      box.remove('user_otp');
      box.remove('user_verify');
      box.remove('user_id');
      box.remove('station_latitude');
      box.remove('station_longitude');
      box.remove('station_radius');
      box.erase();
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
                onTap: onLogout,
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
