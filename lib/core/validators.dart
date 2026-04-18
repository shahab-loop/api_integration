class Validators {
  // ✅ Required Field
  static String? requiredField(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return "$fieldName is required";
    }
    return null;
  }

  // ✅ Rating Validation
  static String? rating(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Rating is required";
    }

    final number = double.tryParse(value);
    if (number == null) {
      return "Enter a valid number";
    }

    if (number < 0 || number > 5) {
      return "Rating must be between 0 and 5";
    }

    return null;
  }

  // ✅ Name Validation (optional stricter)
  static String? name(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Item name is required";
    }

    if (value.length < 3) {
      return "Name must be at least 3 characters";
    }

    return null;
  }

  // ✅ Description Validation
  static String? description(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Description is required";
    }

    if (value.length < 5) {
      return "Description too short";
    }

    return null;
  }
}