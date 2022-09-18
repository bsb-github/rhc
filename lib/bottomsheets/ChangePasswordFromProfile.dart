import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/UserModel.dart';
import '../widgets/TopBar.dart';

class ChangePaswordFromProfile extends StatefulWidget {
  ChangePaswordFromProfile({Key? key}) : super(key: key);

  @override
  State<ChangePaswordFromProfile> createState() =>
      _ChangePaswordFromProfileState();
}

class _ChangePaswordFromProfileState extends State<ChangePaswordFromProfile> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPin = TextEditingController();
  TextEditingController newPin = TextEditingController();
  bool hidePin = true;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text(
                'Change Your Password',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: newPin,
                  obscureText: hidePin,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a valid pin';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock),
                    hintText: 'New Password',
                    filled: true,
                    suffixIcon: IconButton(
                      icon: hidePin
                          ? const Icon(
                              Icons.remove_red_eye,
                              color: Colors.red,
                            )
                          : const Icon(Icons.visibility_off,
                              color: Colors.green),
                      onPressed: () {
                        setState(() {
                          hidePin = !hidePin;
                        });
                      },
                    ),
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
                  controller: confirmPin,
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a valid pin';
                    } else if (value != newPin.text) {
                      return 'Pin does not match';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock),
                    hintText: 'Confirm Password',
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
              InkWell(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pop(context);
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Enter your pin to confirm'),
                            content: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: password,
                                maxLength: 4,
                                obscureText: true,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter a valid pin';
                                  } else if (value != UserList.user.first.pin) {
                                    return 'Pin Entered is incorrect';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.lock),
                                  hintText: 'Pin',
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
                            ),
                            actions: [
                              GestureDetector(
                                onTap: () async {
                                  final phone = UserList.user.first.phone;

                                  await FirebaseDatabase.instance
                                      .ref(
                                          'users/${UserList.user.first.phone}recharge')
                                      .update({'password': confirmPin.text});
                                  UserList.user.clear();

                                  await FirebaseDatabase.instance
                                      .ref()
                                      .child('users')
                                      .child(phone + 'recharge')
                                      .get()
                                      .then((value) {
                                    var data = value.children;
                                    var datalist = data
                                        .map(
                                          (e) => e.value.toString(),
                                        )
                                        .toList();
                                    // print(datalist);

                                    UserList.user = [
                                      UserModel(
                                        username: datalist[7],
                                        password: datalist[3],
                                        phone: datalist[4],
                                        name: datalist[2],
                                        imageUrl: datalist[1],
                                        rechargeBalance: datalist[6],
                                        driveBalance: datalist[0],
                                        pin: datalist[5],
                                      )
                                    ];
                                    Get.snackbar('Password Changed',
                                        'Your Account Password is SuccessFully Changed',
                                        backgroundColor: Colors.green,
                                        colorText: Colors.white,
                                        snackPosition: SnackPosition.BOTTOM);
                                  });
                                  Navigator.pop(context);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    height: 50,
                                    width: MediaQuery.of(context).size.width,
                                    child: const Center(
                                      child: Text(
                                        'Confirm',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          );
                        });
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const Center(
                      child: const Text(
                        'Change PIN',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
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
