import 'package:flutter/material.dart';
import 'package:orio_tech_attendance_app/Utils/Colors/color_resource.dart';
import 'package:flutter_svg/svg.dart';
class HomeCard extends StatelessWidget {
  final String img, title, route;
  final VoidCallback onPressed;

  final bool isDisabled;

  const HomeCard({
    super.key,
    required this.img,
    required this.title,
    required this.route,
    required this.onPressed,
    required this.isDisabled,
  });

  @override
  Widget build(BuildContext context) {
    onTap() {
      if (isDisabled) return;
      if (onPressed != null) {
        onPressed;
        /*print(route);
        Navigator.push(
            context,
            routeTo ?? ''
                MaterialPageRoute(builder: (context) =>
        const HomeScreen())
        );*/
        return;
      } else {
        //Navigate.to(context, route);
      }
    }

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        margin: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: isDisabled ? ColorResources.DISABLE_COLOR.withOpacity(0.5) : ColorResources.DISABLE_COLOR.withOpacity(0.06),
          borderRadius: BorderRadius.circular(10),
        ),
        width: 100,
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Opacity(
              opacity: isDisabled ? 0.5 : 0.5,
              child: SvgPicture.asset(
                img,
                color: ColorResources.PRIMARY_COLOR,
                width: 60.0,
                height: 60.0,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: isDisabled ?  TextStyle(color: ColorResources.PRIMARY_COLOR) : TextStyle(color: ColorResources.PRIMARY_COLOR),
            ),
          ],
        ),
      ),
    );
  }
}
