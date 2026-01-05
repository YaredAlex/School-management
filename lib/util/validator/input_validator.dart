String? validatePhoneNumber(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your phone number';
  }

  if (!RegExp(r'^[0-9]{9}$').hasMatch(value)) {
    return 'Please enter a valid 9-digit phone number';
  }
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter password';
  }

  if (value.length < 4) {
    return 'Password min length should be 6';
  }
  return null;
}

String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter email';
  }

  if (value.length < 6) {
    return 'Password min length should be 6';
  }
  return null;
}
