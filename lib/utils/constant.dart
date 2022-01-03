String? validateEmail(String value) {
  if (value.isEmpty) {
    return "Empty field";
  }
  return (value.contains('@') && value.contains('.'))
      ? null
      : "Enter a valid email";
}

String? validatePassword(String value) {
  if (value.isEmpty) {
    return "Empty field";
  }
  return (value.length < 6) ? "Enter at least 6 char" : null;
}
