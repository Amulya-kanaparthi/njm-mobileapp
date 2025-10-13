import 'package:flutter/material.dart';

class TabsScreen extends StatefulWidget{
  const TabsScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        items: [
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