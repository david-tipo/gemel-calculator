class UsefulFunc {
  static String numberFormStr(String str) {
    String finalStr = str;
    for (int i = str.length - 3; i > 0; i -= 3){
      finalStr = finalStr.substring(0, i) + "," + finalStr.substring(i);
    }
    return finalStr;
  }

  /// this function gets a string-number (with ot without commas already in in it) and adds comma to it
  /// for example the function will get : 5000 . return : 5,000
  /// another one is get: 50,09,9 . return: 50,099
  static String commaString(String str){
    str = removeCommas(str);
    str = _addCommas(str);
    return str;
  }

  static String removeCommas(String str){
    return str.replaceAll(",", "");
  }

  static String _addCommas(String str){
    for (int i = str.length - 3; i > 0; i -= 3){
      str = str.substring(0, i) + "," + str.substring(i);
    }
    return str;
  }
}