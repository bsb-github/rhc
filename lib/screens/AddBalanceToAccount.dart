import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rhc/models/UserModel.dart';
import 'package:rhc/widgets/TopBar.dart';

class AddBalanceToAccount extends StatefulWidget {
  final String imgUrl;
  final String BankName;
  AddBalanceToAccount({Key? key, required this.imgUrl, required this.BankName})
      : super(key: key);

  @override
  State<AddBalanceToAccount> createState() => _AddBalanceToAccountState();
}

class _AddBalanceToAccountState extends State<AddBalanceToAccount> {
  final list = [
    'Select your Account',
    'Drive Balance',
    'Recharge Balance',
    'App Balance'
  ];
  String selectedItem = 'Select your Account';
  TextEditingController _amountController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _tranasactionIdController = TextEditingController();
  TextEditingController _transactionRefController = TextEditingController();
  String countryCode = '880';
  final _formKey = GlobalKey<FormState>();
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
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(widget.imgUrl, height: 50),
                  const SizedBox(width: 20),
                  Image.asset('assets/images/money_transfer.png', height: 50),
                  const SizedBox(width: 10),
                  Image.asset('assets/images/rhc_logo_p.png', height: 75),
                ],
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _phoneNumberController,
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'field cannot be empty';
                    } else if (value.length < 10) {
                      return 'invalid phone number';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    prefixIcon: Container(
                      padding: EdgeInsets.only(left: 8.0),
                      child: CountryPickerDropdown(
                        iconSize: 18,
                        initialValue: 'BD',
                        // itemBuilder: _buildDropdownItem,
                        onValuePicked: (Country country) {
                          setState(() {
                            countryCode = country.phoneCode;
                          });
                        },
                      ),
                    ),
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
                  controller: _tranasactionIdController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.account_balance_wallet),
                    hintText: 'Transaction ID',
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
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Field cannot be empty';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  controller: _amountController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.monetization_on),
                    hintText: 'Amount',
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
              DropdownButton(
                elevation: 5,
                iconEnabledColor: Colors.green,
                icon: Icon(Icons.account_balance),
                iconSize: 20,
                items: list.map((e) {
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
                      selectedItem != 'Select your Account') {
                    try {
                      await FirebaseFirestore.instance
                          .collection('PendingAddBalance')
                          .doc(_tranasactionIdController.text)
                          .set({
                        'bankName': widget.BankName,
                        'phoneNumber':
                            countryCode + _phoneNumberController.text,
                        'amount': _amountController.text,
                        'transactionID': _tranasactionIdController.text,
                        'addBalanceAccount': selectedItem,
                        'clientPhoneNumber': UserList.user.first.phone,
                        'type': 'Add Balance',
                        'status': 'Pending',
                        'time': DateTime.now(),
                      });
                      await FirebaseFirestore.instance
                          .collection(UserList.user.first.phone + 'History')
                          .doc(_tranasactionIdController.text)
                          .set({
                        'bankName': widget.BankName,
                        'phoneNumber':
                            countryCode + _phoneNumberController.text,
                        'amount': _amountController.text,
                        'transactionID': _tranasactionIdController.text,
                        'addBalanceAccount': selectedItem,
                        'type': 'Add Balance',
                        'status': 'Pending',
                        'time': DateTime.now(),
                      }).then((value) {
                        Get.snackbar('Request Sent',
                            'Please Wait for the admin to approve your Request',
                            backgroundColor: Colors.green,
                            colorText: Colors.white);
                      });
                    } catch (PlatformException) {
                      Get.snackbar(
                          'Error', 'Please Check your Internet Connection',
                          backgroundColor: Colors.red, colorText: Colors.white);
                    }
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.green,
                    ),
                    child: Center(
                      child: Text('Send',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600)),
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
