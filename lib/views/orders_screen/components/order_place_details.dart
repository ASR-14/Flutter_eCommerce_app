import 'package:flutter_ecommerce/consts/consts.dart';

Widget orderPlaceDetails(data) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "Order Code".text.fontFamily(semibold).make(),
            "${data['order_code']}"
                .text
                .color(redColor)
                .fontFamily(semibold)
                .make()
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "Shipping Method".text.fontFamily(semibold).make(),
            "${data['shipping_method']}".text.make()
          ],
        )
      ],
    ),
  );
}
