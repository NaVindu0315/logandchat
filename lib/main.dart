import 'package:flutter/material.dart';
import 'package:registerandlogin/userdetails.dart';
import 'package:registerandlogin/userqr.dart';
import 'login.dart';
import 'signup.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(mainscreen());
}

class mainscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: lgin(),
      initialRoute: gemifysign.id,
      routes: {
        lgin.id: (context) => lgin(),
        gemifysign.id: (context) => gemifysign(),
        userdetails.id: (context) => userdetails(),
        //DownloadQRExample.id: (context) => DownloadQRExample(),
      },
    );
  }
}
