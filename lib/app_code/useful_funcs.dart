class UsefulFunc {
  static String numberFormStr(String str) {
    String finalStr = str;
    for (int i = str.length - 3; i > 0; i -= 3){
      finalStr = finalStr.substring(0, i) + "," + finalStr.substring(i);
    }
    return finalStr;
  }
}