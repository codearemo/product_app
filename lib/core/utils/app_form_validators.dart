class AppFormValidator {
  static String? validateField(String? value, String? feild) {
    if (value?.isEmpty ?? true) {
      return '$feild is required';
    } else {
      return null;
    }
  }

  static String? validAmount(double? value, String feild, {double? min, double? max}) {
    if ((value == null) || value <= 0) {
      return '$feild is required';
    } else if (value < (min ?? 0)) {
      return '$feild must is less than $min';
    } else if (value > (max ?? 0)) {
      return max == null ? null : 'Insufficient balance';
    } else {
      return null;
    }
  }
}
