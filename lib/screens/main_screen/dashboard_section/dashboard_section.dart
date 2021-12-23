import 'package:clover_flutter/screens/main_screen/dashboard_section/home_screen.dart';
import 'package:clover_flutter/screens/main_screen/dashboard_section/my_space_screen.dart';
import 'package:clover_flutter/screens/main_screen/dashboard_section/trending_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DashboardSection extends StatefulWidget {
  const DashboardSection({Key? key}) : super(key: key);

  @override
  State<DashboardSection> createState() => _DashboardSectionState();
}

class _DashboardSectionState extends State<DashboardSection> {
  int _bottomNavigationCurrentIndex = 0;

  _getBottomNavigationView(index) {
    switch (index) {
      case (0):
        return const HomeScreen();
      case (1):
        return const TrendingScreen();
      case (2):
        return const MySpaceScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: SafeArea(
        child: _getBottomNavigationView(_bottomNavigationCurrentIndex),
      ),
    );
  }
}
