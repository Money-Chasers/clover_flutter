import 'package:clover_flutter/components/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'sections/home_screen.dart';
import 'sections/trending_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _bottomNavigationCurrentIndex = 0;

  _getBottomNavigationView(index) {
    switch (index) {
      case (0):
        return const HomeScreen();
      case (1):
        return const TrendingScreen();
      default:
        return const HomeScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.dashboard),
      ),
      drawer: const MyDrawer(),
      body: _getBottomNavigationView(_bottomNavigationCurrentIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomNavigationCurrentIndex,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: AppLocalizations.of(context)!.home,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.trending_up),
            label: AppLocalizations.of(context)!.trending,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.inbox),
            label: AppLocalizations.of(context)!.mySpace,
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
