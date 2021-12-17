import 'package:clover_flutter/screens/main_screen/dashboard_section/dashboard_section.dart';
import 'package:clover_flutter/screens/main_screen/profile_section.dart';
import 'package:clover_flutter/screens/main_screen/submit_question_section.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _screenId = 0;

  void _setScreenId(newId) {
    setState(() {
      _screenId = newId;
    });
  }

  ListTile _buildNavigationDrawerTile(text, screenId) {
    return ListTile(
      title: Text(text),
      onTap: () {
        _setScreenId(screenId);
        Navigator.pop(context);
      },
    );
  }

  Widget? _getSection(screenId) {
    switch (screenId) {
      case (0):
        {
          return const DashboardSection();
        }
      case (1):
        {
          return const ProfileSection();
        }
      case (2):
        {
          return const SubmitQuestionSection();
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: ListView(
            children: [
              _buildNavigationDrawerTile("Dashboard", 0),
              _buildNavigationDrawerTile("My Profile", 1),
              _buildNavigationDrawerTile("Submit Question", 2),
            ],
          ),
        ),
        appBar: AppBar(
          title: const Text("Clover"),
        ),
        body: Container(
          child: _getSection(_screenId),
        ));
  }
}
