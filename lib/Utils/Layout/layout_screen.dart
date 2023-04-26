import 'package:flutter/material.dart';

import '../../Widgets/AppBar/app_bar.dart';
import '../../Widgets/Layout/layout_bottom_bar.dart';
import '../../Widgets/Layout/layout_fab.dart';
import 'package:flutter_svg/svg.dart';
import 'package:connectivity_widget/connectivity_widget.dart';

class Layout extends StatelessWidget {
  final Widget body;
  final int currentTab;

  const Layout({super.key, required this.body, this.currentTab = 0});

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpened = MediaQuery.of(context).viewInsets.bottom != 0.0;

    return ConnectivityWidget(
        showOfflineBanner: false,
        builder: (context, isOnline) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: const BuildAppBar(),
            body: body,
            floatingActionButton: keyboardIsOpened
                ? null
                : isOnline
                    ? LayoutFAB()
                    : FloatingActionButton(
                        onPressed:
                            () {}, //Navigate.to(context, AttendanceScreen.id),
                        child: SvgPicture.asset('assets/icons/time.svg'),
                      ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: LayoutBottomBar(
              currentTab: currentTab,
            ),
          );
        });
  }
}
