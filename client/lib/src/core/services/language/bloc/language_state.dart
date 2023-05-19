import 'package:flutter/material.dart';

abstract class LanguageState {
  final Locale locale;
  const LanguageState(this.locale);
}

class LanguageChange extends LanguageState {
  const LanguageChange(Locale locale) : super(locale);
}
