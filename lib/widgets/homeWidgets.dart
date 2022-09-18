import 'package:flutter/material.dart';

class HomeWidgets extends StatefulWidget {
  final String ImagePath;
  final String title;
  HomeWidgets({Key? key, required this.ImagePath, required this.title})
      : super(key: key);

  @override
  State<HomeWidgets> createState() => _HomeWidgetsState();
}

class _HomeWidgetsState extends State<HomeWidgets> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: 5.0,
        color: Colors.lightGreen,
        borderRadius: BorderRadius.circular(35),
        child: Container(
            height: 90,
            width: 90,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(45),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(widget.ImagePath, height: 40, width: 40),
                SizedBox(
                  height: 5,
                ),
                Text(widget.title,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ],
            )),
      ),
    );
  }
}
