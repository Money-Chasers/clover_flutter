import 'package:clover_flutter/components/drawer.dart';
import 'package:clover_flutter/screens/main_application/my_space_screen/sections/bookmarks_section.dart';
import 'package:clover_flutter/screens/main_application/my_space_screen/sections/history_section.dart';
import 'package:flutter/material.dart';

class MySpaceScreen extends StatefulWidget {
  const MySpaceScreen({Key? key}) : super(key: key);

  @override
  _MySpaceScreenState createState() => _MySpaceScreenState();
}

class _MySpaceScreenState extends State<MySpaceScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My space'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.bookmark), text: 'Bookmarks'),
              Tab(icon: Icon(Icons.history), text: 'History'),
            ],
          ),
        ),
        drawer: const MyDrawer(),
        body: const TabBarView(
          children: [
            BookmarksSection(),
            HistorySection(),
          ],
        ),
      ),
    );
  }
}
