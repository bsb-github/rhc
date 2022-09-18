import 'package:flutter/material.dart';

class AddBalanceHistoryCard extends StatefulWidget {
  final String transactionType;
  final String phoneNumber;
  final String tId;
  final String dateTime;
  final String bankName;
  final String status;
  final String amount;
  AddBalanceHistoryCard(
      {Key? key,
      required this.transactionType,
      required this.phoneNumber,
      required this.dateTime,
      required this.bankName,
      required this.status,
      required this.amount,
      required this.tId})
      : super(key: key);

  @override
  State<AddBalanceHistoryCard> createState() => _AddBalanceHistoryCardState();
}

class _AddBalanceHistoryCardState extends State<AddBalanceHistoryCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5.0,
        child: Container(
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.transactionType,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Transaction ID : ${widget.tId}',
                        style:
                            const TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      // Text(
                      //   'Cost %00.00',
                      //   style: TextStyle(
                      //       fontSize: 18,
                      //       color: Colors.grey,
                      //       fontWeight: FontWeight.w600),
                      // ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '৳ ${widget.amount}',
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.dateTime,
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Text(
                        'Status : ${widget.status}',
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
