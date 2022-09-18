
part of "../main.dart";



void myFirebaseInit() async{
  await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyAanlRaqhygGoWmWP2pPQfv_88bPjedIwo',
        appId: '1:922883262952:android:2f1fdff5cd1764acf5bc5d',
        messagingSenderId: '922883262952',
        projectId: 'eprise4-124de',
        // databaseURL: 'https://react-native-firebase-testing.firebaseio.com',
        // storageBucket: 'react-native-firebase-testing.appspot.com',
      )
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
}

notificationInit(){
  AwesomeNotifications().initialize(
    'resource://mipmap/tm',
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic Notifications',
        // defaultColor: Colors.teal,
        importance: NotificationImportance.High,
        channelShowBadge: true, channelDescription: '',
      ),
    ], debug: true
);

}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // await Firebase.initializeApp(
  //   options:DefaultFirebaseOptions.currentPlatform
  // );
  await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyAanlRaqhygGoWmWP2pPQfv_88bPjedIwo',
        appId: '1:922883262952:android:2f1fdff5cd1764acf5bc5d',
        messagingSenderId: '922883262952',
        projectId: 'eprise4-124de',
        // databaseURL: 'https://react-native-firebase-testing.firebaseio.com',
        // storageBucket: 'react-native-firebase-testing.appspot.com',
      )
  );
}

/// Create a [AndroidNotificationChannel] for heads up notifications
// late AndroidNotificationChannel channel;

/// Initialize the [FlutterLocalNotificationsPlugin] package.
// late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
