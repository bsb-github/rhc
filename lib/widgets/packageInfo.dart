import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rhc/models/SelectedOffer.dart';
import 'package:rhc/screens/ActivateDriveOffer.dart';

class PkgInfo extends StatefulWidget {
  final String type;
  final String OfferName;
  final String OfferPrice;
  final String OfferOriginalPrice;
  final String duration;
  final String phoneNumber;
  final String operatorName;
  PkgInfo(
      {Key? key,
      required this.type,
      required this.OfferName,
      required this.OfferPrice,
      required this.OfferOriginalPrice,
      required this.duration,
      required this.phoneNumber,
      required this.operatorName})
      : super(key: key);

  @override
  State<PkgInfo> createState() => _PkgInfoState();
}

class _PkgInfoState extends State<PkgInfo> {
  bool selected = false;
  var now = DateTime.now();
  var formatter = DateFormat('yMd');
  Widget showIsSelected() {
    if (SelectedOfferList.selectedOffer.isNotEmpty &&
        SelectedOfferList.selectedOffer.first.OperatorName ==
            widget.operatorName &&
        SelectedOfferList.selectedOffer.first.offerName == widget.OfferName) {
      selected = true;
      return Icon(Icons.check_box, color: Colors.green[700], size: 20);
    } else {
      return Center();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: SelectedOfferList.selectedOffer.isEmpty
            ? () {
                SelectedOfferList.selectedOffer.clear();
                SelectedOfferList.selectedOffer = [
                  SelectedOffer(
                      offerName: widget.OfferName,
                      offerPrice: widget.OfferPrice,
                      offerOriginalPrice: widget.OfferOriginalPrice,
                      OperatorName: widget.operatorName,
                      duration: widget.duration)
                ];
                setState(() {
                  selected = !selected;
                });
                if (selected == false) {
                  SelectedOfferList.selectedOffer.clear();
                }

                // debugPrint(SelectedOfferList.selectedOffer.first.offerName);
              }
            : () {
                SelectedOfferList.selectedOffer.clear();
                SelectedOfferList.selectedOffer = [
                  SelectedOffer(
                      offerName: widget.OfferName,
                      offerPrice: widget.OfferPrice,
                      offerOriginalPrice: widget.OfferOriginalPrice,
                      OperatorName: widget.operatorName,
                      duration: widget.duration)
                ];
                setState(() {
                  selected = !selected;
                });

                if (selected == false) {
                  SelectedOfferList.selectedOffer.clear();
                }
                // debugPrint(SelectedOfferList.selectedOffer.first.offerName);
              },
        child: Material(
          borderRadius: BorderRadius.circular(10),
          elevation: 5, //
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.OfferName,
                          style: TextStyle(
                            color: Colors.green[700],
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          '৳ ${widget.OfferPrice}',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${formatter.format(now)} - ${formatter.format(now.add(Duration(days: int.parse(widget.duration))))}',
                          style: TextStyle(
                            color: Colors.teal,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '৳ ${widget.OfferOriginalPrice}            ৳ ${int.parse(widget.OfferOriginalPrice) - int.parse(widget.OfferPrice)}',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 10, bottom: 8),
                          child: widget.type == 'recharge'
                              ? selected
                                  ? showIsSelected()
                                  : null
                              : GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ActivateDriveOffer(
                                                  phoneNumber:
                                                      widget.phoneNumber,
                                                  offerName: widget.OfferName,
                                                  offerOriginalPrice:
                                                      widget.OfferOriginalPrice,
                                                  offerPrice: widget.OfferPrice,
                                                  duration: widget.duration,
                                                  OperatorName:
                                                      widget.operatorName,
                                                )));
                                  },
                                  child: Text(
                                    'Buy',
                                    style: TextStyle(
                                      color: Colors.green[700],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 19,
                                    ),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
