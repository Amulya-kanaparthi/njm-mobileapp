import 'package:flutter/material.dart';
import 'package:njm_mobileapp/constants/string_constants.dart';
import 'package:njm_mobileapp/screens/tab_screens/bible_screen.dart';
import 'package:njm_mobileapp/screens/tab_screens/home_screen.dart';
import 'package:njm_mobileapp/screens/tab_screens/profile_screen.dart';

class TabsScreen extends StatefulWidget{
  const TabsScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen>{
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    BibleScreen(),
    HomeScreen(),
    ProfileScreen(),
  ]; 

  void _onTabSelected(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedIndex == 0 ? StringConstants.bible : StringConstants.profile),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
        surfaceTintColor: Colors.transparent,
        elevation: 1,
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onTabSelected,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.music_video_rounded),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_rounded),
            label: '',
          ),
        ],
      ),
    );
  }
}