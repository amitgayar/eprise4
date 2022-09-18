import 'dart:async';
// import 'package:alice/alice.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:eprise4/pages/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';


part 'app_constants/main_level_init.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  notificationInit();
  myFirebaseInit();
  runApp(MyApp());
}


