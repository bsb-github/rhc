import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rhc/models/SelectedOffer.dart';

import '../models/UserModel.dart';
import '../widgets/packageInfo.dart';

class RechargeOffer extends StatefulWidget {
  final SelectedOffer selectedOffer;
  final String phoneNumber;
  RechargeOffer(
      {Key? key, required this.selectedOffer, required this.phoneNumber})
      : super(key: key);

  @override
  State<RechargeOffer> createState() => _RechargeOfferState();
}

class _RechargeOfferState extends State<RechargeOffer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 20),
          Container(
            alignment: Alignment.center,
            child: Image.asset(
              'assets/images/${widget.selectedOffer.OperatorName}',
              height: 100,
              width: 100,
            ),
          ),
          const SizedBox(height: 20),
          PkgInfo(
              operatorName: widget.selectedOffer.OperatorName,
              type: 'recharge',
              OfferName: widget.selectedOffer.offerName,
              OfferPrice: widget.selectedOffer.offerPrice,
              OfferOriginalPrice: widget.selectedOffer.offerOriginalPrice,
              duration: widget.selectedOffer.duration,
              phoneNumber: ''),
          const SizedBox(height: 20),
          InkWell(
            onTap: () async {
              if (widget.phoneNumber.isEmpty) {
                Get.snackbar('Error', 'Please enter your phone number',
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                    icon: Icon(Icons.error));
              } else {
                await FirebaseFirestore.instance
                    .collection(UserList.user.first.phone + 'History')
                    .doc(widget.selectedOffer.offerName + widget.phoneNumber)
                    .set({
                  'offerName': widget.selectedOffer.offerName,
                  'offerPrice': widget.selectedOffer.offerPrice,
                  'offerOriginalPrice': widget.selectedOffer.offerOriginalPrice,
                  'OperatorName': widget.selectedOffer.OperatorName,
                  'duration': widget.selectedOffer.duration,
                  'type': 'Offer Activation',
                  'time': DateTime.now(),
                  'phoneNumber': widget.phoneNumber,
                  'status': 'Pending',
                });
                await FirebaseFirestore.instance
                    .collection('PendingOffers')
                    .doc(widget.selectedOffer.offerName + widget.phoneNumber)
                    .set({
                  'offerName': widget.selectedOffer.offerName,
                  'offerPrice': widget.selectedOffer.offerPrice,
                  'offerOriginalPrice': widget.selectedOffer.offerOriginalPrice,
                  'OperatorName': widget.selectedOffer.OperatorName,
                  'duration': widget.selectedOffer.duration,
                  'transactionType': 'Offer Activation',
                  'time': DateTime.now(),
                  'phoneNumber': widget.phoneNumber,
                  'clientPhoneNumber': UserList.user.first.phone,
                  'status': 'Pending',
                }).then((value) {
                  Get.snackbar('Offer Activation request Sent',
                      'Sit Back and Relax your requested Offer will be Activated in few moments',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.green,
                      borderRadius: 10,
                      margin: EdgeInsets.all(10),
                      borderColor: Colors.green,
                      borderWidth: 1,
                      colorText: Colors.white);
                  // Navigator.pushNamed(context, '/recharge');
                });

                Navigator.pop(context);
              }
            },
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.green[800],
                borderRadius: BorderRadius.circular(20.0),
              ),
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 5),
              child: const Text(
                'Confirm',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
