import 'package:angular2/src/common/forms.dart';

class ID {
  static const String zero = "00000000-0000-0000-0000-000000000000";
  static final RegExp _regExp = new RegExp(
      "^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}\$"
  );

  static bool isValid(String value) {
    return _regExp.hasMatch(value);
  }

  static Map<String, bool> Validator(AbstractControl control){
    return ID.isValid(control.value.toString()) ? null : {"notValidUIID":true};
  }

  String _str;

  ID([this._str = zero]);

  ID.fromString(String id){
    this._str = id;
  }

  String toString() {
    return _str;
  }

  String toJson() {
    return toString();
  }

  String get string => toString();

  set string(String value) {
    if (isValid(value)) {
      _str = value;
    }else{
      print("string $value is not valid id string");
    }
  }
}
