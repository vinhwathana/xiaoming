String? validateEmail(String value) {
  return (value.contains('@') && value.contains('.'))
      ? null
      : "Enter a valid email";
}

String? validatePassword(String value) {
  return (value.length < 6) ? "Enter at least 6 char" : null;
}
