import 'package:js/js.dart';

@JS()
@anonymous
class CheckoutOptions {
  // external List<LineItem> get lineItems;

  external List<LineItem> get lineItems;

  external String get mode;

  external String get successUrl;

  external String get cancelUrl;

  external String get sessionId;

  external factory CheckoutOptions({
    // List<LineItem> lineItems,
    List<LineItem> lineItems,
    String mode,
    String successUrl,
    String cancelUrl,
    String sessionId,
  });
}



@JS()
@anonymous
class LineItem {

  // external PriceData get price_data;
  external String get price;
  external int get quantity;

  external factory LineItem({String price, int quantity});
}




@JS()
@anonymous
class PayItem {

  external String get type;
  external String get id;
  external String get quantity;

  external factory PayItem({String type, String id, String quantity});
}


//
// @JS()
// @anonymous
// class PriceData {
//
//   external String get currency;
//   external ProductData get product_data;
//   external double get unit_amount;
//
//   external factory PriceData({String currency, ProductData product_data , double unit_amount});
// }
//
//
// @JS()
// @anonymous
// class ProductData {
//   external String get name;
//
//   external factory ProductData({String name});
// }