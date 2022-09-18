import 'package:flutter/material.dart';
import 'package:rhc/models/SelectedOffer.dart';
import 'package:rhc/models/showOffers.dart';
import 'package:rhc/screens/paymentConfirmation.dart';
import 'package:rhc/widgets/TopBar.dart';
import 'package:rhc/widgets/packageInfo.dart';

import '../bottomsheets/RechargeOffer.dart';
import '../widgets/operatorContainer.dart';

class Recharge extends StatefulWidget {
  Recharge({Key? key}) : super(key: key);

  @override
  State<Recharge> createState() => _RechargeState();
}

class _RechargeState extends State<Recharge> {
  bool isfSelected = false;
  bool issSelected = false;
  bool istSelected = false;
  bool isfoSelected = false;
  bool isfiSelected = false;
  bool issxSelected = false;
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController pin = TextEditingController();
  String opratorlogo = 'assets/images/telenor.png';
  String simType = 'prepaid';
  int _radioValue = 0;

  void _handleRadioValueChange(int? value) {
    setState(() {
      _radioValue = value!;

      switch (_radioValue) {
        case 0:
          simType = 'prepaid';
          break;
        case 1:
          simType = 'postpaid';
          break;
      }
    });
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        body: SafeArea(
          child: ListView(
            children: [
              TopBar(),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 75,
                width: 75,
                alignment: Alignment.center,
                child: Center(
                    child: Image.asset(
                  'assets/images/recharge.png',
                  height: 50,
                )),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 5),
                child: const Text(
                  'Recharge',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
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
                                issxSelected = false;
                              });
                            } else {
                              setState(() {
                                isfSelected = true;
                                isfiSelected = false;
                                issxSelected = false;
                                isfoSelected = false;
                                istSelected = false;
                                issSelected = false;
                                opratorlogo = 'assets/images/telenor.png';
                              });
                            }
                          },
                          child: OperatorContainer(
                              bankName: 'assets/images/telenor.png',
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
                                issxSelected = false;
                              });
                            } else {
                              setState(() {
                                issSelected = true;
                                isfSelected = false;
                                isfoSelected = false;
                                istSelected = false;
                                isfiSelected = false;
                                issxSelected = false;
                                opratorlogo = 'assets/images/tele.png';
                              });
                            }
                          },
                          child: OperatorContainer(
                            bankName: 'assets/images/tele.png',
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
                                issxSelected = false;
                              });
                            } else {
                              setState(() {
                                istSelected = true;
                                isfSelected = false;
                                isfoSelected = false;
                                isfiSelected = false;
                                issxSelected = false;
                                issSelected = false;
                                opratorlogo = 'assets/images/robi.png';
                              });
                            }
                          },
                          child: OperatorContainer(
                            bankName: 'assets/images/robi.png',
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
                                issxSelected = false;
                              });
                            } else {
                              setState(() {
                                isfoSelected = true;
                                isfSelected = false;
                                isfiSelected = false;
                                issxSelected = false;
                                istSelected = false;
                                issSelected = false;
                                opratorlogo = 'assets/images/banglalink.png';
                              });
                            }
                          },
                          child: OperatorContainer(
                            bankName: 'assets/images/banglalink.png',
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
                                issxSelected = false;
                              });
                            } else {
                              setState(() {
                                isfoSelected = false;
                                isfSelected = false;
                                isfiSelected = true;
                                issxSelected = false;
                                istSelected = false;
                                issSelected = false;
                                opratorlogo = 'assets/images/airtel.png';
                              });
                            }
                          },
                          child: OperatorContainer(
                            bankName: 'assets/images/airtel.png',
                            isSelected: isfiSelected,
                          )),
                      GestureDetector(
                          onTap: () {
                            if (issxSelected) {
                              setState(() {
                                isfSelected = false;
                                isfoSelected = false;
                                istSelected = false;
                                issSelected = false;
                                isfiSelected = false;
                                issxSelected = false;
                              });
                            } else {
                              setState(() {
                                isfoSelected = false;
                                isfSelected = false;
                                isfiSelected = false;
                                issxSelected = true;
                                istSelected = false;
                                issSelected = false;
                                opratorlogo = 'assets/images/skitto.png';
                              });
                            }
                          },
                          child: OperatorContainer(
                            bankName: 'assets/images/skitto.png',
                            isSelected: issxSelected,
                          )),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Radio(
                    value: 0,
                    groupValue: _radioValue,
                    onChanged: _handleRadioValueChange,
                    activeColor: Colors.pink,
                  ),
                  const Text(
                    'Prepaid',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  Radio(
                    value: 1,
                    groupValue: _radioValue,
                    onChanged: _handleRadioValueChange,
                    activeColor: Colors.pink,
                  ),
                  const Text(
                    'Pospaid',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 5),
                child: const Text(
                  'Enter 11 Digit Number eg: 01XXXXXXXXXXX',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter 11 digit phone number';
                      } else if (value.length < 11) {
                        return 'Please enter 11 digit phone number';
                      }
                      return null;
                    },
                    controller: phoneNumber,
                    maxLength: 11,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      suffixIcon: const Icon(Icons.phone_iphone_sharp),
                      hintText: 'Phone Number',
                      filled: true,
                      hintStyle: const TextStyle(fontWeight: FontWeight.w600),
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 0.5),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    if (SelectedOfferList.selectedOffer.isNotEmpty) {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => RechargeOffer(
                          phoneNumber: phoneNumber.text,
                          selectedOffer: SelectedOfferList.selectedOffer.first,
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentConfirmation(
                            phoneNumber: phoneNumber.text,
                            operatorLogo: opratorlogo,
                            simType: simType,
                          ),
                        ),
                      );
                    }
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.green[800],
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 5),
                    child: const Text(
                      'Recharge',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    child: showOffers(
                        type: 'recharge',
                        context: context,
                        phone: phoneNumber.text,
                        isfSelected: isfSelected,
                        issSelected: issSelected,
                        istSelected: istSelected,
                        isfoSelected: isfoSelected,
                        isfiSelected: isfiSelected,
                        issxSelected: issxSelected)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
