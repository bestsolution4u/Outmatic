import 'package:convert/convert.dart';

class StringUtil {
  static String parseRFID(String hexStr) {
    String hexTrim = hexStr.replaceAll("0x", "");
    List<int> parsed = hex.decode(hexTrim);
    String result = "";
    parsed.forEach((element) {
      result += element.toString();
    });
    return result;
  }
}