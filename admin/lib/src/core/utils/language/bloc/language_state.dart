import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class LanguageState extends Equatable {
  final Locale locale;

  const LanguageState(this.locale);
}

class LanguageChange extends LanguageState {
  const LanguageChange(Locale locale) : super(locale);

  @override
  List<Object?> get props => [super.locale];
}
