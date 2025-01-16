import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';

extension CustomValidationBuilder on ValidationBuilder {
  password() => add((value) {
        String pattern =
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
        RegExp regex = RegExp(pattern);

        if (value == 'password') {
          return 'Kata sandi tidak boleh "password"'.tr;
        } else if (value!.length < 8) {
          return 'Kata sandi harus lebih dari 8 karakter'.tr;
        } else if (!regex.hasMatch(value)) {
          return 'Kata sandi harus mengandung huruf besar, huruf kecil, angka dan karakter khusus'
              .tr;
        }
        return null;
      });

  phoneNumber() => add((value) {
        if (value?.isEmpty ?? false) {
          return 'Masukan tidak boleh kosong'.tr;
        } else if (value!.length < 9) {
          return "Nomor telepon tidak boleh kurang dari 9 karakter".tr;
        } else if (value.length > 13) {
          return "Nomor telepon tidak boleh lebih dari 13 karakter".tr;
        }
        return null;
      });

  zipCode() => add((value) {
        if (value!.length < 5) {
          return 'Kode Pos harus terdiri dari 5 karakter'.tr;
        }
        return null;
      });

  name() => add((value) {
        if (value!.length > 30) {
          return 'Nama tidak boleh lebih dari 30 karakter'.tr;
        }
        return null;
      });

  address() => add((value) {
        if (value!.length > 90) {
          return 'Alamat tidak boleh lebih dari 90 karakter'.tr;
        }
        return null;
      });

  ValidationBuilder min(int minValue) => add((value) {
        if (int.parse(value!.digitOnly()) < minValue) {
          return "${'Isian Harus lebih besar atau sama dengan'.tr} ${minValue.toString()}";
        }

        return null;
      });

  ValidationBuilder max(int maxValue, [String? message]) => add((value) {
        if (int.parse(value!.digitOnly()) > maxValue) {
          return message ??
              "${'Isian tidak boleh lebih besar dari'.tr} ${maxValue.toString()}";
        }

        return null;
      });

  ValidationBuilder validLink() {
    return add((value) {
      String pattern =
          r'(http|https)://[\w]+(\.[\w-]+)+([\w.,@?^=%&amp;:/~+#-]*[\w@?^=%&amp;/~+#-])?';
      RegExp regExp = RegExp(pattern);
      if (!regExp.hasMatch(value!)) {
        return 'Silakan masukkan url yang valid'.tr;
      }
      return null;
    });
  }
}
