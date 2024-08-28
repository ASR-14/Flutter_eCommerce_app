import 'package:flutter_ecommerce/consts/consts.dart';

Widget homeButtons({width, height, icon, String? title, onPress}) {
  return Expanded(
      child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(
        icTodaysDeal,
        width: 26,
      ),
      10.heightBox,
      title!.text.fontFamily(semibold).color(darkFontGrey).make()
    ],
  )).box.rounded.white.size(width, height).make();
}
