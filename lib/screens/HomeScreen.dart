import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rhc/screens/AddBalance.dart';
import 'package:rhc/screens/BankTransfer.dart';
import 'package:rhc/screens/DriveOffer.dart';
import 'package:rhc/screens/History.dart';
import 'package:rhc/screens/PayBill.dart';
import 'package:rhc/screens/Profile.dart';
import 'package:rhc/screens/RechargeScreen.dart';

import '../widgets/TopBar.dart';
import '../widgets/homeWidgets.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DateTime? lastPressed;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final now = DateTime.now();
        final maxDuration = Duration(seconds: 2);
        final isWarning =
            lastPressed == null || now.difference(lastPressed!) > maxDuration;
        if (isWarning) {
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: SafeArea(
          child: Column(
            children: [
              TopBar(),
              Container(
                child: Column(
                  children: [
                    Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Column(
                          children: [
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DriveOffer(),
                                        ),
                                      );
                                    },
                                    child: HomeWidgets(
                                      ImagePath: 'assets/images/discount.png',
                                      title: 'Drive Offers',
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  BankTransfer(
                                                    phoneNumber: '',
                                                    ammount: '',
                                                    OfferName: '',
                                                    OfferOriginalPrice: '',
                                                    OfferPrice: '',
                                                    duration: '',
                                                  )));
                                    },
                                    child: HomeWidgets(
                                      ImagePath: 'assets/images/transfer.png',
                                      title: 'Send Money',
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Recharge()));
                                    },
                                    child: HomeWidgets(
                                      ImagePath: 'assets/images/recharge.png',
                                      title: 'Recharge',
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HistoryTracker()));
                                    },
                                    child: HomeWidgets(
                                      ImagePath: 'assets/images/history.png',
                                      title: 'History',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => PayBill()));
                                    },
                                    child: HomeWidgets(
                                      ImagePath: 'assets/images/billPay.png',
                                      title: 'Pay Bills',
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AddBalance()));
                                    },
                                    child: HomeWidgets(
                                      ImagePath:
                                          'assets/images/moneyTransfer.png',
                                      title: 'Add Balance',
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.snackbar('Option Unavailable',
                                          'Contact With Administrator or call on HelpLine',
                                          snackPosition: SnackPosition.BOTTOM);
                                    },
                                    child: HomeWidgets(
                                      ImagePath:
                                          'assets/images/resellerColor.png',
                                      title: 'Reseller',
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Profile()));
                                    },
                                    child: HomeWidgets(
                                      ImagePath: 'assets/images/profile.png',
                                      title: 'Profile',
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
