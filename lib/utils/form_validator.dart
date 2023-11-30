import 'package:doctor_test/logic/export_bloc.dart';

class FormValidatorUtils {
  static String? required(dynamic value) {
    if (value == null ||
        value == false ||
        ((value is Iterable || value is String || value is Map) &&
            value.length == 0)) {
      return 'Ô này cần được điền';
    }
    return null;
  }

  static String? email(String value) {
    if (FieldBlocValidators.email(value) != null) {
      return 'Đây không phải là định dạng của một email';
    }
    return null;
  }
}

class Hospital {
  static String? checkLength10(String value) {
    if (value.length != 10) {
      return 'Mã bệnh nhân phải có 10 kí tự';
    }
    return null;
  }
}
