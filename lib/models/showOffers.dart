import 'package:flutter/material.dart';
import 'package:rhc/models/UserModel.dart';

import '../widgets/packageInfo.dart';
import 'Offers.dart';

Widget showOffers(
    {required bool isfSelected,
    required bool issSelected,
    required bool istSelected,
    required bool isfoSelected,
    required bool isfiSelected,
    required bool issxSelected,
    required String type,
    required BuildContext context,
    required String phone}) {
  if (isfSelected) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: OffersList.grameenOffers.length,
          itemBuilder: (context, index) {
            var data = OffersList.grameenOffers[index];
            return PkgInfo(
              type: type,
              OfferName: data.offerName,
              OfferOriginalPrice: data.offerOriginalPrice,
              OfferPrice: data.offerPrice,
              duration: data.duration,
              phoneNumber: phone,
              operatorName: 'telenor.png',
            );
          }),
    );
  } else if (issSelected) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: OffersList.teleOffers.length,
          itemBuilder: (context, index) {
            var data = OffersList.teleOffers[index];
            return PkgInfo(
              type: type,
              OfferName: data.offerName,
              OfferOriginalPrice: data.offerOriginalPrice,
              OfferPrice: data.offerPrice,
              duration: data.duration,
              phoneNumber: phone,
              operatorName: 'tele.png',
            );
          }),
    );
  } else if (istSelected) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: OffersList.robiOffers.length,
          itemBuilder: (context, index) {
            var data = OffersList.robiOffers[index];
            return PkgInfo(
              type: type,
              OfferName: data.offerName,
              OfferOriginalPrice: data.offerOriginalPrice,
              OfferPrice: data.offerPrice,
              duration: data.duration,
              phoneNumber: phone,
              operatorName: 'robi.png',
            );
          }),
    );
  } else if (isfoSelected) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: OffersList.banglaLinkOffers.length,
          itemBuilder: (context, index) {
            var data = OffersList.banglaLinkOffers[index];
            return PkgInfo(
              type: type,
              OfferName: data.offerName,
              OfferOriginalPrice: data.offerOriginalPrice,
              OfferPrice: data.offerPrice,
              duration: data.duration,
              phoneNumber: phone,
              operatorName: 'banglalink.png',
            );
          }),
    );
  } else if (isfiSelected) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: OffersList.airtelOffers.length,
          itemBuilder: (context, index) {
            var data = OffersList.airtelOffers[index];
            return PkgInfo(
              type: type,
              OfferName: data.offerName,
              OfferOriginalPrice: data.offerOriginalPrice,
              OfferPrice: data.offerPrice,
              duration: data.duration,
              phoneNumber: phone,
              operatorName: 'airtel.png',
            );
          }),
    );
  } else if (issxSelected) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: OffersList.skittoOffers.length,
          itemBuilder: (context, index) {
            var data = OffersList.skittoOffers[index];
            return PkgInfo(
              type: type,
              OfferName: data.offerName,
              OfferOriginalPrice: data.offerOriginalPrice,
              OfferPrice: data.offerPrice,
              duration: data.duration,
              phoneNumber: phone,
              operatorName: 'skitto.png',
            );
          }),
    );
  } else {
    return Container();
  }
}
