
import 'package:bottom_bar_matu/bottom_bar_matu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui/screens/profile.dart';

import '../utils/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController controller = PageController();
  int _selectedIndex = 0;

  final List<Widget> _pages = <Widget>[
    HomeScreen(),
    SearchScreen(),
    PaymentsScreen(),
    NotificationScreen(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    Future.microtask(() {
      setState(() {
        _selectedIndex = index;
        controller.jumpToPage(index);
      });
    });
  }

  void _onPageChanged(int index) {
    Future.microtask(() {
      if (mounted) {
        setState(() {
          _selectedIndex = index;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: PageView(
        controller: controller,
        children: _pages,
        onPageChanged: _onPageChanged,
      ),
      bottomNavigationBar: BottomBarBubble(
        items: [
          BottomBarItem(
            iconBuilder: (color) => Image.asset('assets/icon/home.png',
                color: color, height: 30, width: 30),
          ),
          BottomBarItem(
            iconBuilder: (color) => Image.asset('assets/icon/search.png',
                color: color, height: 30, width: 30),
          ),
          BottomBarItem(
            iconBuilder: (color) => Image.asset('assets/icon/heart.png',
                color: color, height: 30, width: 30),
          ),
          BottomBarItem(
            iconBuilder: (color) => Image.asset('assets/icon/notification.png',
                color: color, height: 30, width: 30),
          ),
          BottomBarItem(
            iconBuilder: (color) => Image.asset('assets/icon/user.png',
                color: color, height: 30, width: 30),
          ),
        ],
        selectedIndex: _selectedIndex,
        onSelect: _onItemTapped,
        backgroundColor: Colors.black,
        color: Colors.blueAccent,
        height: 50,
      ),
    );
  }
}

class PaymentsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Payments Screen'),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Home Screen'),
      ),
    );
  }
}

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Search Screen'),
      ),
    );
  }
}

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Notification Screen'),
      ),
    );
  }
}


