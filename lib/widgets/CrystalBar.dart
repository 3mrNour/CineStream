import 'package:flutter/cupertino.dart';
import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:flutter/material.dart';

class CrystalBottomBar extends StatefulWidget {
  const CrystalBottomBar({super.key});

  @override
  State<CrystalBottomBar> createState() => _CrystalBottomBarState();
}

enum _SelectedTab { home, favorite, add, search, person }

class _CrystalBottomBarState extends State<CrystalBottomBar> {
  var _selectedTab = _SelectedTab.home;
  void _handleIndexChanged(int i) {
    setState(() {
      _selectedTab = _SelectedTab.values[i];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: CrystalNavigationBar(
        borderRadius: 40,
        paddingR: .all(5),
        currentIndex: _SelectedTab.values.indexOf(_selectedTab),
        indicatorColor: Colors.amber,
        unselectedItemColor: Color(0x99FFFFFF),
        backgroundColor: Colors.black.withOpacity(0.1),
        // outlineBorderColor: Colors.black.withOpacity(0.1),
        borderWidth: 1.5,
        outlineBorderColor: Colors.amber,
        onTap: _handleIndexChanged,
        items: [
          /// Home
          CrystalNavigationBarItem(
            icon: Icons.home,
            unselectedIcon: Icons.home_outlined,
            selectedColor: Colors.amber,
          ),

          /// Favourite
          CrystalNavigationBarItem(
            icon: Icons.favorite,
            unselectedIcon: Icons.favorite_border,
            selectedColor: Colors.red,
          ),

          /// Profile
          CrystalNavigationBarItem(
            icon: Icons.person,
            unselectedIcon: Icons.person_outline,
            selectedColor: Colors.amber,
          ),
        ],
      ),
    );
  }
}
