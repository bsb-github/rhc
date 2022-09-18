import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:provider/provider.dart';
import 'package:rhc/models/UserModel.dart';
import 'package:rhc/provider/locale_provider.dart';
import 'package:rhc/screens/MyAccount.dart';
import 'package:rhc/widgets/TopBar.dart';
import 'package:url_launcher/url_launcher.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool english = true;
  bool bangali = false;

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            TopBar(),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              alignment: Alignment.bottomRight,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (english) {
                        setState(() {
                          bangali = true;
                          english = false;
                        });
                      } else {
                        setState(() {
                          bangali = false;
                          english = true;
                        });
                      }
                      LocaleProvider p = LocaleProvider();
                      p.setLocale(const Locale('en'));
                    },
                    child: Container(
                      width: 100,
                      child: Center(
                        child: Text(
                          'English',
                          style: TextStyle(
                              color: english ? Colors.white : Colors.green),
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: english ? Colors.green : Colors.white,
                          border: Border.all(color: Colors.green, width: 2),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (bangali) {
                        setState(() {
                          bangali = false;
                          english = true;
                        });
                      } else {
                        setState(() {
                          bangali = true;
                          english = false;
                        });
                      }
                      final p =
                          Provider.of<LocaleProvider>(context, listen: false);
                      p.setLocale(const Locale('bn'));
                    },
                    child: Container(
                      width: 100,
                      child: Center(
                        child: Text(
                          'বাঙালি',
                          style: TextStyle(
                              color: bangali ? Colors.black : Colors.yellow),
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: bangali ? Colors.yellow : Colors.white,
                          border: Border.all(color: Colors.yellow, width: 2),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyAccount()));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: ListTile(
                    leading: UserList.user.first.imageUrl.isNotEmpty
                        ? CircleAvatar(
                            radius: 25,
                            backgroundImage:
                                NetworkImage(UserList.user.first.imageUrl),
                          )
                        : Image.asset(
                            'assets/images/myAccount.png',
                            fit: BoxFit.cover,
                          ),
                    title: Text(
                      UserList.user.first.username,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Get.snackbar(
                    'Coming Soon', 'This option will be available soon',
                    snackPosition: SnackPosition.BOTTOM);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: ListTile(
                    leading: Image.asset(
                      'assets/images/reseller.png',
                      fit: BoxFit.cover,
                    ),
                    title: const Text(
                      'Reseller',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Get.snackbar(
                    'Coming Soon', 'This option will be available soon',
                    snackPosition: SnackPosition.BOTTOM);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: ListTile(
                    leading: Image.asset(
                      'assets/images/refund.png',
                      fit: BoxFit.cover,
                    ),
                    title: const Text(
                      'Request a Refund',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                if (Platform.isAndroid) {
                  SystemNavigator.pop();
                } else {
                  exit(0);
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: ListTile(
                    leading: Image.asset(
                      'assets/images/logout.png',
                      fit: BoxFit.cover,
                    ),
                    title: const Text(
                      'Logout',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                var data = await FirebaseDatabase.instance
                    .ref()
                    .child('AdminPhoneNumber')
                    .get();

                if (data.value != null) {
                  Uri myUri = Uri.parse(
                      "https://wa.me/${data.value}?text=I%20Need%20Help");
                  await launchUrl(myUri);
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: ListTile(
                    leading: Image.asset(
                      'assets/images/help.png',
                      fit: BoxFit.cover,
                    ),
                    title: const Text(
                      'Contact Help Service',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
