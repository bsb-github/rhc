import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rhc/models/UserModel.dart';
import 'package:rhc/widgets/TopBar.dart';

class PayBill extends StatefulWidget {
  PayBill({Key? key}) : super(key: key);

  @override
  State<PayBill> createState() => _PayBillState();
}

class _PayBillState extends State<PayBill> {
  List items = [
    'Select Bill Type',
    'Polli Biddut Prepaid',
    'Polli Biddut Postpaid'
  ];
  final _formKey = GlobalKey<FormState>();
  String selectedItem = 'Select Bill Type';
  TextEditingController smsController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController pinController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  DateTime? dateTime;
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
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Field cannot be empty';
                    }
                    return null;
                  },
                  controller: smsController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person),
                    hintText: 'SMS Number',
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Field cannot be empty';
                    }
                    return null;
                  },
                  controller: fullNameController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person),
                    hintText: 'Full Name',
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Field cannot be empty';
                    }
                    return null;
                  },
                  maxLength: 4,
                  keyboardType: TextInputType.number,
                  controller: pinController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.pin),
                    hintText: 'Pin',
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Field cannot be empty';
                    }
                    return null;
                  },
                  maxLength: 11,
                  keyboardType: TextInputType.phone,
                  controller: phoneNumberController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.phone),
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Field cannot be empty';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  controller: amountController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.monetization_on),
                    hintText: 'Amount',
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 12.0, top: 8.0),
                      height: 50,
                      width: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.green,
                      ),
                      child: Center(
                        child: Text(
                          dateTime == null
                              ? 'Select Bill Due Date'
                              : '${dateTime?.day}/${dateTime?.month}/${dateTime?.year}',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1979),
                                lastDate: DateTime(3000))
                            .then((value) {
                          setState(() {
                            dateTime = value;
                          });
                        });
                      },
                      child: const Icon(
                        Icons.calendar_today,
                        size: 30,
                        color: Colors.lightGreen,
                      ),
                    )
                  ],
                ),
              ),
              DropdownButton(
                items: items.map((e) {
                  return DropdownMenuItem(
                    child: Text(e),
                    value: e,
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedItem = value.toString();
                  });
                },
                value: selectedItem,
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () async {
                  if (_formKey.currentState!.validate() &&
                      dateTime != null &&
                      selectedItem != 'Select Bill Type' &&
                      pinController.text == UserList.user.first.pin) {
                    await FirebaseFirestore.instance
                        .collection('PendingBills')
                        .doc(smsController.text)
                        .set({
                      'smsNumber': smsController.text,
                      'fullName': fullNameController.text,
                      'phoneNumber': phoneNumberController.text,
                      'amount': amountController.text,
                      'dueDate':
                          '${dateTime?.day}/${dateTime?.month}/${dateTime?.year}',
                      'status': 'Pending',
                      'Type': selectedItem,
                      'time': DateTime.now(),
                    });
                    await FirebaseFirestore.instance
                        .collection(UserList.user.first.phone + 'History')
                        .doc(smsController.text)
                        .set({
                      'smsNumber': smsController.text,
                      'fullName': fullNameController.text,
                      'phone Number': phoneNumberController.text,
                      'amount': amountController.text,
                      'dueDate':
                          '${dateTime?.day}/${dateTime?.month}/${dateTime?.year}',
                      'status': 'Pending',
                      'Type': selectedItem,
                      'type': 'Bill',
                      'time': DateTime.now(),
                    }).then((value) {
                      Get.snackbar('Bill Paying request sent',
                          'Please wait for the admin response',
                          snackPosition: SnackPosition.BOTTOM,
                          colorText: Colors.white,
                          backgroundColor: Colors.green);
                    });
                  } else {
                    Get.snackbar('Enter a Valid Data',
                        'Please check your information you entered',
                        snackPosition: SnackPosition.BOTTOM,
                        colorText: Colors.white,
                        backgroundColor: Colors.red);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.green,
                    ),
                    child: const Center(
                      child: Text(
                        'Send',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
