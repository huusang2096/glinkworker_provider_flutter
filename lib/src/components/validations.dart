import 'package:simplest/simplest.dart';

class Validations {
  String validateName(String value) {
    if (value.isEmpty) return 'pleae_enter_name'.tr;

    final words = value.trim().split(' ');
    final RegExp nameExp = new RegExp(
        r"^[a-zA-Z_ÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚĂĐĨŨƠàáâãèéêìíòóôõùúăđĩũơƯĂẠẢẤẦẨẪẬẮẰẲẴẶẸẺẼỀỀỂưăạảấầẩẫậắằẳẵặẹẻẽềềểỄỆỈỊỌỎỐỒỔỖỘỚỜỞỠỢỤỦỨỪễệỉịọỏốồổỗộớờởỡợụủứừỬỮỰỲỴÝỶỸửữựỳỵỷỹ\\s]+$");
    for (var word in words) {
      if (!nameExp.hasMatch(word)) return 'please_enter_correct_name'.tr;
    }
    return null;
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'please_enter_valid_email'.tr;
    else
      return null;
  }

  String validatePassword(String value) {
    if (value.isEmpty) return 'please_enter_password'.tr;
    return null;
  }
}
