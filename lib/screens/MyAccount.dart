import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rhc/bottomsheets/ChangePasswordFromProfile.dart';
import 'package:rhc/bottomsheets/ChangePin.dart';
import 'package:rhc/widgets/TopBar.dart';

import '../models/UserModel.dart';

class MyAccount extends StatefulWidget {
  MyAccount({Key? key}) : super(key: key);

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  File? image;
  String imgeUrl = '';
  bool isPass = true;
  TextEditingController data = TextEditingController();
  updateImage() async {
    try {
      final storageRef = FirebaseStorage.instance.ref();
      final imageRef =
          storageRef.child('images/${UserList.user.first.username}');
      await imageRef.putFile(image!).then((p0) {
        const SnackBar snackBar = SnackBar(content: Text('Image Uploaded'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }).onError((error, stackTrace) {
        const SnackBar snackBar =
            SnackBar(content: Text('Error Uploading Image'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });
      imgeUrl = await imageRef.getDownloadURL();
    } on FirebaseException catch (e) {
      const SnackBar snackBar = SnackBar(content: Text('Error'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
      await updateImage();
      print(imgeUrl);
      DatabaseReference ref = FirebaseDatabase.instance
          .ref("users/${UserList.user.first.phone}recharge");
      await ref.update({
        'image': imgeUrl,
      });
    } on PlatformException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            TopBar(),
            const SizedBox(height: 20),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: GestureDetector(
                  onTap: () {
                    pickImage();
                  },
                  child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          image: DecorationImage(
                              image: UserList.user[0].imageUrl.isEmpty
                                  ? const AssetImage(
                                      'assets/images/user_icon.jpg')
                                  : NetworkImage(UserList.user.first.imageUrl)
                                      as ImageProvider,
                              fit: BoxFit.cover),
                          color: Colors.white),
                      child: Center()),
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 5.0,
                child: Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Row(
                      children: [
                        const Text(
                          'User Name :',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          UserList.user.first.username,
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
              child: Card(
                elevation: 5.0,
                child: Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Row(
                      children: [
                        const Text(
                          'Name :',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          UserList.user.first.name,
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 5.0,
                child: Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Row(
                      children: [
                        const Text(
                          'Phone Number :',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          '+' + UserList.user.first.phone,
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ],
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
                setState(() {
                  isPass = !isPass;
                });
                showModalBottomSheet(
                    context: context,
                    builder: (context) => ChangePaswordFromProfile());
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: isPass ? Colors.green : Colors.white,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Center(
                    child: Text(
                      'Change Password',
                      style: TextStyle(
                          color: isPass ? Colors.yellow : Colors.red,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  isPass = !isPass;
                });
                showModalBottomSheet(
                    context: context, builder: (context) => ChangePin());
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: !isPass ? Colors.red : Colors.yellow,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Center(
                    child: Text(
                      'Change PIN',
                      style: TextStyle(
                          color: !isPass ? Colors.white : Colors.green,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
