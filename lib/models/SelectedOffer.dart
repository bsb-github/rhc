class SelectedOfferList {
  static List<SelectedOffer> selectedOffer = [];
}

class SelectedOffer {
  final String offerName;
  final String offerPrice;
  final String offerOriginalPrice;
  final String OperatorName;
  final String duration;

  SelectedOffer(
      {required this.offerName,
      required this.offerPrice,
      required this.offerOriginalPrice,
      required this.OperatorName,
      required this.duration});
}
