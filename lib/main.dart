import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // we need this for the vibrations
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Demo',
      theme:  ThemeData(),
        home:  const MyHomePage(),
        // home: VibrateHomepage(),

    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late Timer timer;
  int counter = 0;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 5), (Timer t) => addValue());
  }

  void addValue() {
    setState(() {
      counter++;
    });
    // patternVibrate();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: MaterialButton(
          child: const Icon(Icons.add),
          onPressed: () {
          showModalBottomSheet(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.0),
              ),
              isScrollControlled : true,
              enableDrag: false,
              isDismissible: true,
              builder: (BuildContext context) {
            return const SizedBox(
              width: 300,
              height: 150,
              child: Center(
                  child: Text(
                      "Flutter",
                      style: TextStyle(fontSize: 50)
                  )
              ),
            );
          }, context: context);
        },),
        // backgroundColor: Colors.brown[300],
        body:

        const SizedBox(
          width: 300,
          height: 150,
          child: Center(
              child: Text(
                  "Flutter",
                  style: TextStyle(fontSize: 50)
              )
          ),
        ),
      ),
    );
  }
}

patternVibrate() async {
  // HapticFeedback.mediumImpact();
  // HapticFeedback.heavyImpact();
  HapticFeedback.vibrate();
  // HapticFeedback.lightImpact();
  // HapticFeedback.selectionClick();

  //
  // sleep(
  //   const Duration(milliseconds: 200),
  // );
  //
  // HapticFeedback.mediumImpact();
  //
  // sleep(
  //   const Duration(milliseconds: 500),
  // );
  //
  // HapticFeedback.mediumImpact();
  //
  // sleep(
  //   const Duration(milliseconds: 200),
  // );
  // HapticFeedback.mediumImpact();
}