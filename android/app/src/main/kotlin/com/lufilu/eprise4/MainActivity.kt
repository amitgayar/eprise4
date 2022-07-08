package com.lufilu.eprise4

import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
}

//// [START ask_post_notifications]
//// Declare the launcher at the top of your Activity/Fragment:
//private val requestPermissionLauncher = registerForActivityResult(
//    ActivityResultContracts.RequestPermission()
//) { isGranted: Boolean ->
//    if (isGranted) {
//        // FCM SDK (and your app) can post notifications.
//    } else {
//        // TODO: Inform user that that your app will not show notifications.
//    }
//}
//
//// [START_EXCLUDE]
//@RequiresApi(33)
//// [END_EXCLUDE]
//private fun askNotificationPermission() {
//    if (ContextCompat.checkSelfPermission(this, Manifest.permission.POST_NOTIFICATIONS) ==
//        PackageManager.PERMISSION_GRANTED
//    ) {
//        // FCM SDK (and your app) can post notifications.
//    } else if (shouldShowRequestPermissionRationale(Manifest.permission.POST_NOTIFICATIONS)) {
//        // TODO: display an educational UI explaining to the user the features that will be enabled
//        //       by them granting the POST_NOTIFICATION permission. This UI should provide the user
//        //       "OK" and "No thanks" buttons. If the user selects "OK," directly request the permission.
//        //       If the user selects "No thanks," allow the user to continue without notifications.
//    } else {
//        // Directly ask for the permission
//        requestPermissionLauncher.launch(Manifest.permission.POST_NOTIFICATIONS)
//    }
//}
//// [END ask_post_notifications]
