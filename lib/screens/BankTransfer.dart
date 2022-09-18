import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random_string/random_string.dart';
import 'package:rhc/models/UserModel.dart';
import 'package:rhc/widgets/packageInfo.dart';

import '../widgets/TopBar.dart';
import '../widgets/operatorContainer.dart';

class BankTransfer extends StatefulWidget {
  final String phoneNumber;
  final String ammount;
  final String OfferName;
  final String OfferPrice;
  final String OfferOriginalPrice;
  final String duration;
  BankTransfer(
      {Key? key,
      required this.phoneNumber,
      required this.ammount,
      required this.OfferName,
      required this.OfferPrice,
      required this.OfferOriginalPrice,
      required this.duration})
      : super(key: key);

  @override
  State<BankTransfer> createState() => _BankTransferState();
}

class _BankTransferState extends State<BankTransfer> {
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController pinController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();
  bool isfSelected = true;
  bool issSelected = false;
  bool istSelected = false;
  bool isfoSelected = false;
  bool isfiSelected = false;
  String bankName = 'Bkash Bank Ltd';
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
          child: Form(
        key: _formKey,
        child: ListView(
          children: [
            TopBar(),
            const SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: () {
                          if (isfSelected) {
                            setState(() {
                              isfSelected = false;
                              isfoSelected = false;
                              istSelected = false;
                              issSelected = false;
                              isfiSelected = false;
                            });
                          } else {
                            setState(() {
                              bankName = 'Bkash Bank Ltd';
                              isfSelected = true;
                              isfiSelected = false;
                              isfoSelected = false;
                              istSelected = false;
                              issSelected = false;
                            });
                          }
                        },
                        child: OperatorContainer(
                            bankName: 'assets/images/bkash.png',
                            isSelected: isfSelected)),
                    GestureDetector(
                        onTap: () {
                          if (issSelected) {
                            setState(() {
                              isfSelected = false;
                              isfoSelected = false;
                              istSelected = false;
                              issSelected = false;
                              isfiSelected = false;
                            });
                          } else {
                            setState(() {
                              bankName = 'Rocket Bank Ltd';

                              issSelected = true;
                              isfSelected = false;
                              isfoSelected = false;
                              istSelected = false;
                              isfiSelected = false;
                            });
                          }
                        },
                        child: OperatorContainer(
                          bankName: 'assets/images/rocket.png',
                          isSelected: issSelected,
                        )),
                    GestureDetector(
                        onTap: () {
                          if (istSelected) {
                            setState(() {
                              isfSelected = false;
                              isfoSelected = false;
                              istSelected = false;
                              issSelected = false;
                              isfiSelected = false;
                            });
                          } else {
                            setState(() {
                              bankName = 'Nagad Bank Ltd';
                              istSelected = true;
                              isfSelected = false;
                              isfoSelected = false;
                              isfiSelected = false;
                              issSelected = false;
                            });
                          }
                        },
                        child: OperatorContainer(
                          bankName: 'assets/images/nagad.png',
                          isSelected: istSelected,
                        )),
                    GestureDetector(
                        onTap: () {
                          if (isfoSelected) {
                            setState(() {
                              isfSelected = false;
                              isfoSelected = false;
                              istSelected = false;
                              issSelected = false;
                              isfiSelected = false;
                            });
                          } else {
                            setState(() {
                              bankName = 'UPay Bank Ltd';
                              isfoSelected = true;
                              isfSelected = false;
                              isfiSelected = false;

                              istSelected = false;
                              issSelected = false;
                            });
                          }
                        },
                        child: OperatorContainer(
                          bankName: 'assets/images/upay.png',
                          isSelected: isfoSelected,
                        )),
                    GestureDetector(
                        onTap: () {
                          if (isfiSelected) {
                            setState(() {
                              isfSelected = false;
                              isfoSelected = false;
                              istSelected = false;
                              issSelected = false;
                              isfiSelected = false;
                            });
                          } else {
                            setState(() {
                              isfoSelected = false;
                              isfSelected = false;
                              isfiSelected = true;

                              istSelected = false;
                              issSelected = false;
                            });
                          }
                        },
                        child: OperatorContainer(
                          bankName: 'assets/images/bank.png',
                          isSelected: isfiSelected,
                        )),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      isfiSelected
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: bankNameController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Field cannot be empty';
                                  }
                                  setState(() {
                                    bankName = value;
                                  });
                                  return null;
                                },
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.person),
                                  hintText: 'Bank Details',
                                  filled: true,
                                  hintStyle: const TextStyle(
                                      fontWeight: FontWeight.w600),
                                  fillColor: Colors.grey[200],
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.green, width: 0.5),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: accountNumberController,
                          keyboardType: TextInputType.number,
                          maxLength: 17,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Field cannot be empty';
                            } else if (value.length < 17 || value.length > 17) {
                              return 'Please enter valid account number';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.person),
                            hintText: 'Account Number',
                            filled: true,
                            hintStyle:
                                const TextStyle(fontWeight: FontWeight.w600),
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.blue, width: 0.5),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: amountController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Field cannot be empty';
                            } else if (int.parse(value) < 1000 &&
                                int.parse(value) > 5000) {
                              return 'Please enter valid amount';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.monetization_on_sharp),
                            hintText: 'Amount to Transfer (1000 - 5000)',
                            filled: true,
                            hintStyle:
                                const TextStyle(fontWeight: FontWeight.w600),
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.blue, width: 0.5),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: pinController,
                          maxLength: 4,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Field cannot be empty';
                            } else if (value.length < 4 || value.length > 4) {
                              return 'Please enter valid pin';
                            }
                            return null;
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.pin),
                            hintText: 'Pin',
                            filled: true,
                            hintStyle:
                                const TextStyle(fontWeight: FontWeight.w600),
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.blue, width: 0.5),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            if (pinController.text == UserList.user.first.pin) {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text(
                                          'Are you sure that you want to make this transfer?'),
                                      actions: [
                                        InkWell(
                                          onTap: () async {
                                            var tId = randomAlpha(8);
                                            await FirebaseFirestore.instance
                                                .collection(
                                                    'PendingBankTransfers')
                                                .doc(tId)
                                                .set({
                                              'clientPhoneNumber':
                                                  UserList.user.first.phone,
                                              'accountNumber':
                                                  accountNumberController.text,
                                              'bankName': bankName,
                                              'amount': int.parse(
                                                  amountController.text),
                                              'status': 'Pending',
                                              'time': DateTime.now(),
                                              'TID': tId,
                                              'type': 'BankTransfer',
                                            });
                                            await FirebaseFirestore.instance
                                                .collection(
                                                    UserList.user.first.phone +
                                                        'History')
                                                .doc(tId)
                                                .set({
                                              'type': 'Bank Transfer',
                                              'accountNumber':
                                                  accountNumberController.text,
                                              'bankName': bankName,
                                              'amount': amountController.text,
                                              'status': 'Pending',
                                              'time': DateTime.now(),
                                            }).then((value) {
                                              Get.snackbar(
                                                  'Your Transfer is Added to Queue',
                                                  'Please wait for the admin to approve it',
                                                  backgroundColor: Colors.green,
                                                  snackPosition:
                                                      SnackPosition.BOTTOM,
                                                  colorText: Colors.white);
                                            });
                                            Navigator.pop(context);
                                            setState(() {
                                              accountNumberController.text = '';

                                              amountController.text = '';

                                              pinController.text = '';

                                              bankNameController.text = '';
                                            });
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                                height: 50,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                ),
                                                child: const Center(
                                                    child: Text(
                                                  'Confirm',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ))),
                                          ),
                                        )
                                      ],
                                    );
                                  });
                            } else {
                              Get.snackbar('Wrong Pin',
                                  'Please enter a valid PIN number',
                                  colorText: Colors.white,
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.red);
                            }
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
                              'Transfer',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
