import 'dart:async';

import 'package:clover_flutter/bloc/streams/user_bloc.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late StreamSubscription _signedInStreamSubscription;

  @override
  initState() {
    // handle authentication initialization
    _signedInStreamSubscription =
        userBloc.isSignedInStream.listen((bool isSignedIn) {
      if (isSignedIn) {
        Navigator.of(context).pushReplacementNamed('/dashboard');
      } else {
        Navigator.of(context).pushReplacementNamed('/intro');
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    // cancel the stream when disposing the widget
    _signedInStreamSubscription.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image(
            image: Image.asset(
          'assets/images/logo.png',
          scale: 1.25,
        ).image),
      ),
    );
  }
}
