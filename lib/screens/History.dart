import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rhc/models/UserModel.dart';
import 'package:rhc/widgets/AddBalanceHistoryCard.dart';
import 'package:rhc/widgets/BankTransferHistoryCart.dart';
import 'package:rhc/widgets/HistoryCard.dart';
import 'package:rhc/widgets/RechargeHistoryCard.dart';
import 'package:rhc/widgets/TopBar.dart';

import '../widgets/BillHistoryCard.dart';

class HistoryTracker extends StatefulWidget {
  HistoryTracker({Key? key}) : super(key: key);

  @override
  State<HistoryTracker> createState() => _HistoryTrackerState();
}

class _HistoryTrackerState extends State<HistoryTracker> {
  bool isDaily = true;
  bool isMonthly = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Column(
          children: [
            TopBar(),
            const SizedBox(
              height: 20,
            ),
            FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('AdminHistory')
                  .orderBy('time', descending: true)
                  .get(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Image.asset(
                      'assets/images/oops.png',
                      height: 200,
                      width: 200,
                    ),
                  );
                } else {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.75 - 10,
                    child: ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        var data = snapshot.data.docs[index].data();
                        if (data['type'] == 'Offer Activation') {
                          return HistoryCard(
                            dateTime: data['time'].toDate().toString(),
                            transactionType: data['type'],
                            recieverPhone: data['phoneNumber'],
                            offerName: data['offerName'],
                            offerPrice: data['offerPrice'],
                            offerOriginalPrice: data['offerOriginalPrice'],
                            status: data['status'],
                          );
                        } else if (data['type'] == 'Recharge') {
                          return RechargeHistoryCard(
                            transactionType: data['type'],
                            amount: data['amount'],
                            recieverPhone: data['phoneNumber'],
                            status: data['status'],
                            dateTime: data['time'],
                            simType: data['simType'],
                          );
                        } else if (data['type'] == 'Bank Transfer') {
                          return BankTransferHistoryCard(
                              transactionType: data['type'],
                              accountNumber: data['accountNumber'],
                              dateTime: data['time'].toString(),
                              bankName: data['bankName'],
                              status: data['status'],
                              amount: data['amount']);
                        } else if (data['type'] == 'Bill') {
                          return BillHistoryCard(
                            type: data['type'],
                            smsNumber: data['smsNumber'],
                            dateTime: data['time'].toDate().toString(),
                            amount: data['amount'],
                            status: data['status'],
                            billType: data['Type'],
                            dueDate: data['dueDate'],
                            fullName: data['fullName'],
                          );
                        } else if (data['type'] == 'Add Balance') {
                          return AddBalanceHistoryCard(
                              transactionType: data['type'],
                              phoneNumber: data['phoneNumber'],
                              dateTime: data['time'].toDate().toString(),
                              bankName: data['bankName'],
                              status: data['status'],
                              amount: data['amount'],
                              tId: data['transactionID']);
                        } else {
                          return Container();
                        }
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
