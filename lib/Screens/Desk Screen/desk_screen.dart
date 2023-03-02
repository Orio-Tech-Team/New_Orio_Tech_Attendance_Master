import 'package:flutter/material.dart';
import '../../Utils/Layout/layout_screen.dart';

import 'desk_body_screen.dart';

class DeskScreen extends StatelessWidget {
  static const String routeName = '/desk-screen';
  const DeskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  const Layout(
      currentTab: 2,
      body: SingleChildScrollView(
        child: DeskBodyScreen(),
      ),
    );
  }
}
