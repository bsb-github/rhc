import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random_string/random_string.dart';
import 'package:rhc/widgets/TopBar.dart';
import 'package:rhc/widgets/packageInfo.dart';

import '../models/UserModel.dart';

class ActivateDriveOffer extends StatefulWidget {
  final String offerName;
  final String offerPrice;
  final String offerOriginalPrice;
  final String OperatorName;
  final String duration;
  final String phoneNumber;
  ActivateDriveOffer(
      {Key? key,
      required this.offerName,
      required this.offerPrice,
      required this.offerOriginalPrice,
      required this.OperatorName,
      required this.duration,
      required this.phoneNumber})
      : super(key: key);

  @override
  State<ActivateDriveOffer> createState() => _ActivateDriveOfferState();
}

class _ActivateDriveOfferState extends State<ActivateDriveOffer> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              TopBar(),
              const SizedBox(height: 20),
              Container(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/images/${widget.OperatorName}',
                  height: 100,
                  width: 100,
                ),
              ),
              const SizedBox(height: 20),
              PkgInfo(
                  operatorName: '',
                  type: 'recharge',
                  OfferName: widget.offerName,
                  OfferPrice: widget.offerPrice,
                  OfferOriginalPrice: widget.offerOriginalPrice,
                  duration: widget.duration,
                  phoneNumber: ''),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: phoneNumberController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Field cannot be empty';
                    } else if (value.length < 11) {
                      return 'Invalid Phone Number';
                    }
                    return null;
                  },
                  maxLength: 11,
                  decoration: InputDecoration(
                    counterStyle: TextStyle(color: Colors.white),
                    hintText: 'Phone Number',
                    filled: true,
                    hintStyle: TextStyle(fontWeight: FontWeight.w600),
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 0.5),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  enabled: false,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.monetization_on_sharp),
                    hintText: 'Amount to Transfer = ৳ ${widget.offerPrice}',
                    filled: true,
                    hintStyle: const TextStyle(fontWeight: FontWeight.w600),
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.green, width: 0.5),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Field cannot be empty';
                    } else if (value.length < 4) {
                      return 'Invalid Pin';
                    } else if (value != UserList.user.first.pin) {
                      return 'Pin Doesn\'t Match';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  controller: pinController,
                  maxLength: 4,
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.pin),
                    hintText: 'Pin',
                    filled: true,
                    hintStyle: const TextStyle(fontWeight: FontWeight.w600),
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.green, width: 0.5),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () async {
                  if (_formKey.currentState!.validate() &&
                      double.parse(UserList.user.first.driveBalance) >=
                          int.parse(widget.offerPrice)) {
                    var offerID = randomAlpha(20);
                    await FirebaseFirestore.instance
                        .collection(UserList.user.first.phone + 'History')
                        .doc(offerID)
                        .set({
                      'offerName': widget.offerName,
                      'offerPrice': widget.offerPrice,
                      'offerOriginalPrice': widget.offerOriginalPrice,
                      'OperatorName': widget.OperatorName,
                      'duration': widget.duration,
                      'type': 'Offer Activation',
                      'time': DateTime.now(),
                      'phoneNumber': phoneNumberController.text,
                      'status': 'Pending',
                    });
                    await FirebaseFirestore.instance
                        .collection('PendingOffers')
                        .doc(offerID)
                        .set({
                      'offerName': widget.offerName,
                      'offerPrice': widget.offerPrice,
                      'offerOriginalPrice': widget.offerOriginalPrice,
                      'OperatorName': widget.OperatorName,
                      'duration': widget.duration,
                      'transactionType': 'Offer Activation',
                      'time': DateTime.now(),
                      'phoneNumber': phoneNumberController.text,
                      'clientPhoneNumber': UserList.user.first.phone,
                      'status': 'Pending',
                      'offerID': offerID,
                    }).then((value) async {
                      await FirebaseDatabase.instance
                          .ref()
                          .child('users')
                          .child(UserList.user.first.phone + 'recharge')
                          .update({
                        'driveBalance':
                            (double.parse(UserList.user.first.driveBalance) -
                                    double.parse(widget.offerPrice))
                                .toString(),
                      }).then((value) {
                        setState(() {
                          UserList.user.first.driveBalance =
                              (double.parse(UserList.user.first.driveBalance) -
                                      double.parse(widget.offerPrice))
                                  .toString();
                        });
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
                    });

                    Navigator.pop(context);
                  } else if (double.parse(UserList.user.first.driveBalance) <
                      double.parse(widget.offerPrice)) {
                    Get.snackbar('Insufficient Balance',
                        'You don\'t have sufficient balance to activate this offer',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red,
                        borderRadius: 10,
                        margin: EdgeInsets.all(10),
                        borderColor: Colors.red,
                        borderWidth: 1,
                        colorText: Colors.white);
                  }
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Center(
                    child: Text(
                      'Buy',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        )),
      ),
    );
  }
}
