import 'package:flutter/material.dart';

class DashboardSection extends StatefulWidget {
  const DashboardSection({Key? key}) : super(key: key);

  @override
  State<DashboardSection> createState() => _DashboardSectionState();
}

class _DashboardSectionState extends State<DashboardSection> {
  int _bottomNavigationCurrentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomNavigationCurrentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up),
            label: "Trending",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inbox),
            label: "My Space",
          ),
        ],
        onTap: (index) {
          setState(() {
            _bottomNavigationCurrentIndex = index;
          });
        },
      ),
    );
  }
}
