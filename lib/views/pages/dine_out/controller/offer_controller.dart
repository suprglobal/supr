import 'package:flutter/foundation.dart';
import 'package:superapp/views/pages/dine_out/model/offer_model.dart';

class OfferProvider extends ChangeNotifier {
  Offer? _selectedOffer;

  Offer? get selectedOffer => _selectedOffer;

  void selectOffer(Offer offer) {
    _selectedOffer = offer;
    notifyListeners();
  }
}
