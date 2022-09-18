import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rhc/firebase_options.dart';
import 'package:rhc/getData/GetOffersData.dart';
import 'package:rhc/provider/locale_provider.dart';
import 'package:rhc/screens/LoginScreen.dart';
import 'package:rhc/screens/SplashScreen.dart';

import 'package:rhc/screens/paymentConfirmation.dart';
import 'models/UserModel.dart';
import 'screens/HomeScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  void initState() {
    super.initState();
    // getData();
    grameenOffers();
    banglaLinkOffers();
    airtelOffers();
    robiOffers();
    skittoOffers();
    teleOffers();
    setState(() {});
  }

  void getData() async {
    DatabaseReference referenceData = FirebaseDatabase.instance
        .ref()
        .child('users/${FirebaseAuth.instance.currentUser!.uid}');
    UserList.user.clear();
    Future.delayed(const Duration(seconds: 5));
    await referenceData.get().then((value) {
      var data = value.children;
      var list = data.map((e) => e.value.toString()).toList();
      // UserList.user = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => LocaleProvider(),
        builder: (context, child) {
          final provider = Provider.of<LocaleProvider>(context);
          return GetMaterialApp(
            theme: ThemeData(
              primarySwatch: Colors.green,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            debugShowCheckedModeBanner: false,
            home: SplashScreen(),
            routes: {
              '/login': (context) => LoginScreen(),
              '/home': (context) => Home(),
            },
          );
        });
  }
}
