import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

class OperatorContainer extends StatefulWidget {
  final String bankName;
  final bool isSelected;
  const OperatorContainer(
      {Key? key, required this.bankName, required this.isSelected})
      : super(key: key);

  @override
  State<OperatorContainer> createState() => _OperatorContainerState();
}

class _OperatorContainerState extends State<OperatorContainer> {
  //Offset distance = Offset(6, 6);
  //double blur = widget.isSelected ? : 12;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  color: Colors.grey[50],
                  boxShadow: [
                    BoxShadow(
                      blurRadius: widget.isSelected ? 3 : 12,
                      color: Color(0xffa7a9af),
                      offset: widget.isSelected ? Offset(2, 2) : Offset(6, 6),
                      inset: widget.isSelected,
                    ),
                    BoxShadow(
                        blurRadius: widget.isSelected ? 3 : 12,
                        color: Colors.white,
                        offset:
                            widget.isSelected ? Offset(-2, -2) : Offset(-6, -6),
                        inset: widget.isSelected)
                  ],
                  borderRadius: const BorderRadius.all(Radius.circular(
                    12,
                  ))),
              child: Center(
                  child: Image.asset(
                widget.bankName,
                height: 35,
              ))),
        ));
  }
}
