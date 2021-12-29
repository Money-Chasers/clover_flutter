bool checkEmailValid(email) {
  return RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
}

String? getCountryCodeFromLanguageCode(languageCode) {
  switch (languageCode) {
    case ('hi'):
      return 'in';
    case ('en'):
      return 'us';
    default:
      return null;
  }
}

String getLanguageNameFromLanguageCode(languageCode) {
  switch (languageCode) {
    case ('en'):
      return 'English';
    case ('hi'):
      return 'हिन्दी';
    default:
      return 'English';
  }
}
