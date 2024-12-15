import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/home_page.dart';
import 'package:flutter_application_1/pages/library_page.dart';
import 'package:flutter_application_1/pages/discover_page.dart';
import 'package:flutter_application_1/pages/community_page.dart';
import 'package:flutter_application_1/pages/profile_page.dart';

void main() {
  runApp(const BasePage());
}

class BasePage extends StatelessWidget {
  const BasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const BottomNavBar(),
    );
  }
}

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    HomePage(),
    LibraryPage(),
    DiscoverPage(),
    CommunityPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              _selectedIndex == 0 ? Icons.home : Icons.home_outlined,
              color: _selectedIndex == 0 ? Colors.orange : Colors.grey,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _selectedIndex == 1
                  ? Icons.library_music
                  : Icons.library_music_outlined,
              color: _selectedIndex == 1 ? Colors.orange : Colors.grey,
            ),
            label: 'Library',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _selectedIndex == 2 ? Icons.explore : Icons.explore_outlined,
              color: _selectedIndex == 2 ? Colors.orange : Colors.grey,
            ),
            label: 'Discover',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _selectedIndex == 3 ? Icons.group : Icons.group_outlined,
              color: _selectedIndex == 3 ? Colors.orange : Colors.grey,
            ),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _selectedIndex == 4 ? Icons.person : Icons.person_outline,
              color: _selectedIndex == 4 ? Colors.orange : Colors.grey,
            ),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.orange,
        onTap: _onItemTapped,
      ),
    );
  }
}
