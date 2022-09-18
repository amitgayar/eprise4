
import 'dart:async';
import 'dart:convert';
// import 'package:alice/alice.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:eprise4/app_constants/constants.dart';
import 'package:eprise4/utils/package_implementation/my_awesome_notifications.dart';
import 'package:eprise4/utils/package_implementation/my_webview.dart';
import 'package:eprise4/pages/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'message.dart';
import 'message_list.dart';
import 'permissions.dart';
import 'token_monitor.dart';
import 'package:logger/logger.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // navigatorKey: alice.getNavigatorKey(),
      title: 'Messaging Example App',
      theme: ThemeData.dark(),
      routes: {
        '/': (context) => Application(),
        '/message': (context) => MessageView(),
      },
    );
  }
}

/// Renders the example application.
class Application extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Application();
}

class _Application extends State<Application> {
  String? _token;

  @override
  void initState() {
    super.initState();
    ///webview
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
    ///firebase messaging
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      logPrint.w("FirebaseMessaging.instance.getInitialMessage : $message ");
      if (message != null) {
        // Navigator.pushNamed(
        //   context,
        //   '/message',
        //   arguments: MessageArguments(message, true),
        // );
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      logPrint.w("FirebaseMessaging.onMessage.listen : ${message.data} ");

      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(notification?.body??'', textAlign: TextAlign.center,style: TextStyle(color: Colors.white),),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.black87,
              duration: Duration(seconds: 15),
              margin: EdgeInsets.fromLTRB(20,0,20,500),
              elevation: 20.0,
              dismissDirection:DismissDirection.horizontal
          ));
      createPlantFoodNotification();
      // createWaterReminderNotification(message);
      if (notification != null && android != null && !kIsWeb) {
        // flutterLocalNotificationsPlugin.show(
        //   notification.hashCode,
        //   notification.title,
        //   notification.body,
        //   NotificationDetails(
        //     android: AndroidNotificationDetails(
        //       channel.id,
        //       channel.name,
        //       // TODO add a proper drawable resource to android, for now using
        //       //      one that already exists in example app.
        //       icon: 'launch_background',
        //     ),
        //   ),
        // );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      logPrint.w("A new onMessageOpenedApp event was published\nFirebaseMessaging.onMessage.listen : ${message.notification?.body} ");

      // Navigator.pushNamed(
      //   context,
      //   '/message',
      //   arguments: MessageArguments(message, true),
      // );
    });
  }


  Future myAPIHit() async{
    Response res = await http.get(Uri.parse("https://coolboxapi.indicold.in/masterData/getColourCodeList"));
    logPrint.w('my api hit : res : ${res.body}');
    // alice.onHttpResponse(res);
  }


  Future<void> onActionSelected(String value) async {
    switch (value) {
      case 'subscribe':
        {
          logPrint.w("FlutterFire Messaging Example: Subscribing to topic fcm_test");
          await FirebaseMessaging.instance.subscribeToTopic('fcm_test');
          logPrint.w("FlutterFire Messaging Example: Subscribing to topic fcm_test successful. ");
        }
        break;
      case 'unsubscribe':
        {
          logPrint.w(
            'FlutterFire Messaging Example: Unsubscribing from topic "fcm_test".',
          );
          await FirebaseMessaging.instance.unsubscribeFromTopic('fcm_test');
          logPrint.w(
            'FlutterFire Messaging Example: Unsubscribing from topic "fcm_test" successful.',
          );
        }
        break;
      case 'get_apns_token':
        {
          if (defaultTargetPlatform == TargetPlatform.iOS ||
              defaultTargetPlatform == TargetPlatform.macOS) {
            logPrint.w('FlutterFire Messaging Example: Getting APNs token...');
            String? token = await FirebaseMessaging.instance.getAPNSToken();
            logPrint.w('FlutterFire Messaging Example: Got APNs token: $token');
          } else {
            logPrint.w(
              'FlutterFire Messaging Example: Getting an APNs token is only supported on iOS and macOS platforms.',
            );
          }
        }
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cloud Messaging'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: onActionSelected,
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(
                  value: 'subscribe',
                  child: Text('Subscribe to topic'),
                ),
                const PopupMenuItem(
                  value: 'unsubscribe',
                  child: Text('Unsubscribe to topic'),
                ),
                const PopupMenuItem(
                  value: 'get_apns_token',
                  child: Text('Get APNs token (Apple only)'),
                ),
              ];
            },
          ),
        ],
      ),
      floatingActionButton: Builder(
        builder: (context) => const FloatingActionButton(
          onPressed: createPlantFoodNotification,
          backgroundColor: Colors.white,
          child: Icon(Icons.send),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            MetaCard('Permissions', Permissions()),
            MetaCard(
              'FCM Token',
              TokenMonitor((token) {
                logPrint.w("FCM token : $token");
                _token = token;
                return token == null
                    ? const CircularProgressIndicator()
                    : Text(token, style: const TextStyle(fontSize: 12));
              }),
            ),
            MetaCard('Message Stream', MessageList()),
            ElevatedButton(onPressed: (){
              // ScaffoldMessenger.of(context).showSnackBar(
              //     SnackBar(
              //         content: Column(
              //           mainAxisSize: MainAxisSize.min,
              //           children: const [
              //             Text(
              //               'My Custom message must be here!!!',
              //               textAlign: TextAlign.center,
              //               // style: TextStyle(color: Colors.white),
              //             )
              //           ],
              //         ),
              //         behavior: SnackBarBehavior.floating,
              //         // backgroundColor: Colors.black87,
              //         duration: Duration(seconds: 45),
              //         // margin: EdgeInsets.fromLTRB(20,0,20,650),
              //         elevation: 20.0,
              //         dismissDirection:DismissDirection.horizontal
              //     ));
              Navigator.push(context, PageRouteBuilder(pageBuilder: (a,s,f)=>
              // WebViewExample()
              ExpandableWebView("https://track.roam.ai/user/62fde32845e78a11f3a010cc")
              ));
            }, child: const Text(
              'Show SnackBar',
              // 'Show WebView',
            )),
          ],
        ),
      ),
    );
  }
}

/// UI Widget for displaying metadata.
class MetaCard extends StatelessWidget {
  final String _title;
  final Widget _children;

  // ignore: public_member_api_docs
  MetaCard(this._title, this._children);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(left: 8, right: 8, top: 8),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                child: Text(_title, style: const TextStyle(fontSize: 18)),
              ),
              _children,
            ],
          ),
        ),
      ),
    );
  }
}