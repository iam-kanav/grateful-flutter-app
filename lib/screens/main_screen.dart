import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:grateful_app/providers/gratitude_provider.dart';
import 'package:grateful_app/providers/settings_provider.dart'; // Import SettingsProvider
import 'package:grateful_app/screens/journal_screen.dart';
import 'package:grateful_app/screens/motivation_screen.dart';
import 'package:grateful_app/screens/settings_screen.dart'; // Import the new SettingsScreen

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late PageController _pageController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // --- MODIFIED: Added SettingsScreen to the list ---
  static const List<Widget> _screens = <Widget>[
    JournalScreen(),
    MotivationScreen(),
    SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    // Prevent re-animating to the same page
    if (_selectedIndex == index) return;

    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });

          // Logic to run when switching TO a specific tab
          if (index == 1) { // Motivation Tab
            context.read<GratitudeProvider>().getNewMotivation();
          } else if (index == 2) { // Settings Tab
            // Refresh settings from storage when user visits the tab
            context.read<SettingsProvider>().loadSettings();
          }
        },
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        // --- MODIFIED: Added the BottomNavigationBarItem for Settings ---
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_outline),
            activeIcon: Icon(Icons.bookmark),
            label: 'Journal',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb_outline),
            activeIcon: Icon(Icons.lightbulb),
            label: 'Motivation',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}