import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import '../pages/global_users_page.dart';
import '../pages/user_profile_page.dart';

class BottomBar extends StatefulWidget {
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _currentIndex = 0;
  final List<Widget> _children = [GlobalUsersPage(),UserProfilePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          height: MediaQuery.of(context).size.height / 13,
          buttonBackgroundColor: Colors.orange[200],
          color: Colors.orange,
          backgroundColor: Colors.white,
          items: <Widget>[
            Icon(
              Icons.home,
              size: 30,
              color: Colors.white,
            ),
            Icon(
              Icons.calendar_today,
              size: 30,
              color: Colors.white,
            ),
            Icon(
              Icons.people,
              size: 30,
              color: Colors.white,
            ),
          ],
          onTap: (index) {
            onTabTabbed(index);
          },
        ),
        body: _children[_currentIndex]);
  }

  void onTabTabbed(int index) {
    setState(() {
      _currentIndex = index;
    });
    print(index);
  }
}
