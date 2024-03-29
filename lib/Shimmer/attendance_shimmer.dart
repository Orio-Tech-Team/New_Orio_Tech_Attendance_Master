import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_svg/svg.dart';
import '../Utils/Constant/text_context.dart';

class AttendanceShimmer extends StatelessWidget {
  const AttendanceShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      enabled: true,
      baseColor: const Color(0xffA0A4A8),
      highlightColor: const Color(0xFFDCDCDC),
      child: Center(
        child: Column(
          children: [
            Padding(
              padding: kDefaultPadding,
              child: Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                    onPressed: () {
                    },
                    icon: SvgPicture.asset(
                      'assets/icons/calender.svg',
                      color: Colors.grey.shade300,
                    )),
              ),
            ),
            dateTimeShow(),
            const SizedBox(height: 20),
            Container(
              width: 172,
              height: 172,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                shape: BoxShape.circle,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.location_off_outlined,
                    color: Colors.grey.shade100,
                    size: 70,
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: 90,
                    height: 8,
                    color: Colors.grey.shade100,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            inRangeText(),
            const Expanded(child: SizedBox(height: 20)),
            const AttendanceInfo(),
            const SizedBox(height: 70),
          ],
        ),
      ),
    );
  }
}

Widget dateTimeShow() {
  return Column(
    children: [
      Container(
        width: 70,
        height: 20,
        color: Colors.grey.shade100,
      ),
      const SizedBox(
        height: 5,
      ),
      Container(
        width: 100,
        height: 12,
        color: Colors.grey.shade100,
      ),
    ],
  );
}

Widget inRangeText() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SvgPicture.asset('assets/icons/map_pin.svg', color: Colors.grey.shade300),
      const SizedBox(width: 5),
      Container(
        height: 12,
        width: 180,
        color: Colors.grey.shade100,
      ),
    ],
  );
}

class AttendanceInfo extends StatelessWidget {
  const AttendanceInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          checkItem(),
          checkItem(),
          checkItem(),
        ],
      ),
    );
  }
}


Widget checkItem() {
  return SizedBox(
    width: 90,
    child: Column(
      children: [
        SvgPicture.asset(
          'assets/icons/check_in.svg',
          color: Colors.grey.shade300,
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 20,
              height: 8,
              color: Colors.grey.shade100,
            ),
            const Text(
              " : ",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            Container(
              width: 20,
              height: 8,
              color: Colors.grey.shade100,
            ),
          ],
        ),
        Container(
          width: 60,
          height: 8,
          color: Colors.grey.shade100,
        ),
      ],
    ),
  );
}
