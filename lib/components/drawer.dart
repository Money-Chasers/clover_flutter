import 'package:clover_flutter/bloc/streams/drawer_bloc.dart';
import 'package:clover_flutter/bloc/streams/user_bloc.dart';
import 'package:clover_flutter/bloc/streams/attempt_paper_bloc.dart';
import 'package:clover_flutter/utils/dev_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  void _navigateScreen(int screenId) {
    drawerBloc.attemptPaperEventSink
        .add({'type': drawerActions.changeIndex, 'payload': screenId});

    switch (screenId) {
      case (0):
        Navigator.of(context).pushReplacementNamed('/dashboard');
        break;
      case (1):
        Navigator.of(context).pushReplacementNamed('/paperDetails');
        break;
      case (2):
        attemptPaperBloc.attemptPaperEventSink.add({
          'type': attemptPaperActions.assignFullPaperModel,
          'payload': getFakePaperModel()
        });
        Navigator.of(context).pushReplacementNamed('/demoAttemptPaper');
        break;
      case (3):
        Navigator.of(context).pushReplacementNamed('/mySpace');
        break;
      default:
        Navigator.of(context).pushReplacementNamed('/dashboard');
    }
  }

  Widget _buildNavigationDrawerTile(
      String text, IconData icon, int myScreenId, int currentScreenId) {
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: myScreenId == currentScreenId
              ? Theme.of(context).primaryColorLight
              : Colors.transparent,
        ),
        child: Row(
          children: [
            Icon(icon, size: 40),
            const SizedBox(width: 10),
            Text(text, style: Theme.of(context).textTheme.subtitle1)
          ],
        ),
      ),
      onTap: () {
        _navigateScreen(myScreenId);
      },
    );
  }

  _buildDrawerButton(icon, callbackFunction) {
    return GestureDetector(
        child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColorLight,
                borderRadius: BorderRadius.circular(5)),
            child: Icon(icon, size: 30)),
        onTap: () {
          Navigator.pop(context);
          callbackFunction();
        });
  }

  Widget _buildMainWidget(int currentIndex) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: 1, color: Color(0xffd4d4d4)))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColorLight,
                        borderRadius: BorderRadius.circular(4)),
                    child: Image(
                        image: Image.asset('assets/images/logo.png', scale: 5)
                            .image),
                  ),
                  _buildDrawerButton(Icons.arrow_back, () {})
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildNavigationDrawerTile(
                        AppLocalizations.of(context)!.dashboard,
                        Icons.dashboard,
                        0,
                        currentIndex),
                    _buildNavigationDrawerTile(
                        AppLocalizations.of(context)!.submitQuestions,
                        Icons.question_answer,
                        1,
                        currentIndex),
                    _buildNavigationDrawerTile(
                        'Demo attempt paper', Icons.receipt, 2, currentIndex),
                    _buildNavigationDrawerTile(
                        'My space', Icons.inbox, 3, currentIndex),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              decoration: const BoxDecoration(
                  border: Border(
                      top: BorderSide(width: 1, color: Color(0xffd4d4d4)))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildDrawerButton(Icons.settings, () {}),
                  _buildDrawerButton(
                    Icons.power_settings_new,
                    () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Text(
                                AppLocalizations.of(context)!.logoutConfirm,
                                style: Theme.of(context).textTheme.subtitle1),
                            actions: [
                              TextButton(
                                child: Text(AppLocalizations.of(context)!.no,
                                    style:
                                        Theme.of(context).textTheme.subtitle1),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              TextButton(
                                child: Text(AppLocalizations.of(context)!.yes,
                                    style:
                                        Theme.of(context).textTheme.subtitle1),
                                onPressed: () {
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      '/intro', (route) => false);
                                  userBloc.eventSink
                                      .add({'type': userActions.signOut});
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: drawerBloc.currentIndexStream,
        initialData: drawerBloc.currentIndex,
        builder: (BuildContext context, AsyncSnapshot currentIndexSnap) {
          return _buildMainWidget(currentIndexSnap.data);
        });
  }
}
