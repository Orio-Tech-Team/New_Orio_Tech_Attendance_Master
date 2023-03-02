import 'package:flutter/material.dart';
import 'package:orio_tech_attendance_app/Screens/Desk%20Screen/desk_screen.dart';
import 'package:orio_tech_attendance_app/Screens/Notification%20Screen/notification_screen.dart';
import 'package:orio_tech_attendance_app/Screens/Profile%20Screen/profile_screen.dart';
import 'package:orio_tech_attendance_app/Utils/Colors/color_resource.dart';

import '../../Widgets/AppBar/app_bar.dart';
import '../Home Screen/home_screen.dart';

class BottomNavigationScreen extends StatefulWidget {
  static const String routeName = '/bottom-navigation-screen';
  const BottomNavigationScreen({super.key});

  @override
  _BottomNavigationScreenState createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  int _currentIndex = 2;
  final List<Widget> _pages = <Widget>[];

  @override
  void initState() {
    _pages.add( HomeScreen());
    _pages.add(const DeskScreen());
    _pages.add( HomeScreen());
    _pages.add(const NotificationScreen());
    _pages.add(const ProfileScreen());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BuildAppBar(),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 4.0,
        clipBehavior: Clip.hardEdge,
        child: SizedBox(
          height: kBottomNavigationBarHeight,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  color: Colors.white,
                  width: 0.5,
                ),
              ),
            ),
            child: BottomNavigationBar(
              elevation: 6,
              type: BottomNavigationBarType.shifting,
              iconSize: 24,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                selectedFontSize: 12,
                unselectedFontSize: 12,
                currentIndex: _currentIndex,
                unselectedItemColor: Colors.blueGrey,
                selectedItemColor: ColorResources.PRIMARY_COLOR,
                onTap: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                items: const [
                  BottomNavigationBarItem(icon:ImageIcon(
                    AssetImage("assets/icons/home.png"),
                    size: 20,
                  ),
                      label: ''),
                  BottomNavigationBarItem(icon: ImageIcon(
                    AssetImage("assets/icons/desk.png"),
                    size: 20,
                  ), label: ''),
                 BottomNavigationBarItem(icon: Icon(Icons.add,color: Colors.white,), label: ''),
                  BottomNavigationBarItem(icon: Icon(Icons.notifications_active_outlined), label: ''),
                  BottomNavigationBarItem(icon: Icon(Icons.perm_identity), label: ''),
                ]),
          ),
        ),
      ),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(2.0),
        child: FloatingActionButton(
          backgroundColor: _currentIndex == 2 ? ColorResources.PRIMARY_COLOR : Colors.blueGrey,
          child: const Icon(Icons.add),
          onPressed: () => setState(() {
            _currentIndex = 2;
          }),
        ),
      ),
    );
  }
}

