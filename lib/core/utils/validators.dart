class Validators {
  static String? email(
      String? value, {
        required String requiredMessage,
        required String invalidMessage,
      }) {
    if (value == null || value.trim().isEmpty) {
      return requiredMessage;
    }

    final emailRegex = RegExp(
      r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
    );

    if (!emailRegex.hasMatch(value.trim())) {
      return invalidMessage;
    }

    return null;
  }

  static String? password(
      String? value, {
        required String requiredMessage,
        required String tooShortMessage,
      }) {
    if (value == null || value.isEmpty) {
      return requiredMessage;
    }

    if (value.length < 6) {
      return tooShortMessage;
    }

    return null;
  }
}