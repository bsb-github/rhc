import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rhc/screens/AddBalanceToAccount.dart';
import 'package:rhc/widgets/TopBar.dart';

class AddBalance extends StatefulWidget {
  AddBalance({Key? key}) : super(key: key);

  @override
  State<AddBalance> createState() => _AddBalanceState();
}

class _AddBalanceState extends State<AddBalance> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              TopBar(),
              SizedBox(height: 20),
              Container(
                height: MediaQuery.of(context).size.height * 0.7 + 20,
                child: FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('AddBalanceMethods')
                      .get(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          color: Colors.green,
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error');
                    } else {
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (context, index) {
                            var data = snapshot.data.docs[index].data();
                            return Card(
                              child: ListTile(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AddBalanceToAccount(
                                                imgUrl: data['bankLogo'],
                                                BankName: data['bankName'],
                                              )));
                                },
                                title: Text(
                                    'Add balance with ' + data['bankName']),
                                subtitle: Text(data['bankName'] +
                                    ' Agent ' +
                                    data['agentPhone']),
                                leading: CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(data['bankLogo']),
                                ),
                              ),
                            );
                          });
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
