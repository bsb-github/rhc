import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random_string/random_string.dart';
import 'package:rhc/models/UserModel.dart';

class PaymentConfirmation extends StatefulWidget {
  final String operatorLogo;
  final String phoneNumber;
  final String simType;
  const PaymentConfirmation(
      {Key? key,
      required this.operatorLogo,
      required this.phoneNumber,
      required this.simType})
      : super(key: key);

  @override
  State<PaymentConfirmation> createState() => _PaymentConfirmationState();
}

class _PaymentConfirmationState extends State<PaymentConfirmation> {
  @override
  Widget build(BuildContext context) {
    TextEditingController pin = TextEditingController();
    TextEditingController amount = TextEditingController();
    // create a formkey
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      body: Form(
        key: formKey,
        child: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 150,
                width: 150,
                child: Image.asset(
                  widget.operatorLogo,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a valid ammount';
                    }

                    return null;
                  },
                  controller: amount,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.monetization_on_outlined),
                    hintText: 'Amount To Recharge',
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
                  controller: pin,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a valid pin';
                    } else if (value.length < 4) {
                      return 'Pin must be 4 digits';
                    } else if (value != UserList.user.first.pin) {
                      return 'Pin is incorrect';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.pin),
                    hintText: 'Enter Your Pin To Confirm Payment',
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
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: InkWell(
                  onTap: () async {
                    var time = DateTime.now().toString();
                    var rechargeID = randomAlpha(20);
                    if (formKey.currentState!.validate() &&
                        double.parse(amount.text) <=
                            double.parse(UserList.user.first.rechargeBalance)) {
                      await FirebaseFirestore.instance
                          .collection('PendingRecharges')
                          .doc(rechargeID)
                          .set({
                        'amount': amount.text,
                        'clientPhoneNumber': UserList.user.first.phone,
                        'phoneNumber': widget.phoneNumber,
                        'simType': widget.simType,
                        'operatorLogo': widget.operatorLogo,
                        'time': time,
                        'rechargeID': rechargeID,
                        'status': 'Pending'
                      });
                      await FirebaseFirestore.instance
                          .collection(UserList.user.first.phone + 'History')
                          .doc(rechargeID)
                          .set({
                        'amount': amount.text,
                        'type': 'Recharge',
                        'phoneNumber': widget.phoneNumber,
                        'simType': widget.simType,
                        'operatorLogo': widget.operatorLogo,
                        'status': 'Pending',
                        'time': time,
                      }).then((value) async {
                        Get.snackbar('Your Request had been Added to Queue',
                            'Please wait for the operator to confirm',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.green,
                            colorText: Colors.white,
                            borderRadius: 10,
                            margin: EdgeInsets.all(10),
                            borderColor: Colors.green,
                            borderWidth: 1,
                            duration: Duration(seconds: 5),
                            icon: Icon(Icons.check, color: Colors.white));
                        var remainingRechargeBalance =
                            double.parse(UserList.user.first.rechargeBalance) -
                                double.parse(amount.text);
                        setState(() {
                          UserList.user.first.rechargeBalance =
                              remainingRechargeBalance.toString();
                        });
                        await FirebaseDatabase.instance
                            .ref()
                            .child('users')
                            .child(UserList.user.first.phone + 'recharge')
                            .update({
                          'rechargeBalance': remainingRechargeBalance.toString()
                        });
                      });
                      Navigator.pop(context);
                    } else if (double.parse(amount.text) >
                        double.parse(UserList.user.first.rechargeBalance)) {
                      Get.snackbar('Insufficient Balance',
                          'Please recharge your account',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                          borderRadius: 10,
                          margin: EdgeInsets.all(10),
                          borderColor: Colors.red,
                          borderWidth: 1,
                          duration: Duration(seconds: 5),
                          icon: Icon(Icons.error, color: Colors.white));
                    }
                  },
                  child: Container(
                    height: 50,
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
              ),
            ],
          ),
        )),
      ),
    );
  }
}
