import 'package:flutter_ecommerce/consts/consts.dart';

Widget ourButton({onPress, color, textColor, String? title}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
        backgroundColor: color, padding: const EdgeInsets.all(5)),
    onPressed: onPress,
    child: title.toString().text.color(textColor).fontFamily(bold).make(),
  );
}
