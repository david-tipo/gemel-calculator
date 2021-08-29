
enum InputValidStatus{
  ok,
  empty,
  invalidChar,
  tooBig,
  belowZero,
}

extension InputValidStatusExtension on InputValidStatus {

  static const errorStrings = <InputValidStatus, String>{
    InputValidStatus.empty: "תיבה ריקה",
    InputValidStatus.belowZero: "ערך נמוך מ0 לא תקין",
    InputValidStatus.invalidChar: 'תו לא חוקי,',
    InputValidStatus.tooBig: "אופס. ערך גדול מדי",
  };

  /// The error message
  String get errorString => errorStrings[this];
}
