@JS()
library stripe;

import 'package:foody/stripeWeb/checkout_options.dart';
import 'package:js/js.dart';

@JS()
class Stripe {
  external Stripe(String key);

  external redirectToCheckout(CheckoutOptions checkoutOptions);
}