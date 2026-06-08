class Validators {

  static String? name(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Name required";
    }
    if (value.trim().length < 3) {
      return "Min 3 characters";
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Email required";
    }

    final regex = RegExp(r'^[\w\.-]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!regex.hasMatch(value.trim())) {
      return "Invalid email";
    }
    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Phone required";
    }

    final regex = RegExp(r'^[0-9]{10,15}$');

    if (!regex.hasMatch(value.trim())) {
      return "Invalid phone number";
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return "Password required";
    }

    if (value.length < 6) {
      return "Min 6 characters";
    }

    return null;
  }

  // 🔥 NEW
  static String? cnic(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "CNIC required";
    }

    if (value.trim().length != 13) {
      return "CNIC must be 13 digits";
    }

    return null;
  }

  static String? experience(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Experience required";
    }

    final isNumber = int.tryParse(value.trim());

    if (isNumber == null) {
      return "Must be a number";
    }

    return null;
  }
}