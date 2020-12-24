import 'package:flutter/material.dart';

import 'package:tstore_dart/tstore_dart.dart';

class SettingsDocument extends TDocument {
  final String languageCode;
  final String theme;
  final int year;

  SettingsDocument({
    this.languageCode,
    this.theme,
    this.year,
  });

  @override
  SettingsDocument clone() {
    return SettingsDocument(
      languageCode: languageCode,
      theme: theme,
      year: year,
    );
  }

  factory SettingsDocument.fromJson(Map<String, dynamic> json) {
    return SettingsDocument(
      languageCode: json['languageCode'] as String,
      theme: json['theme'] as String,
      year: json['year'] as int,
    );
  }

  @override
  SettingsDocument copyWith({
    String languageCode,
    String theme,
    int year,
  }) {
    return SettingsDocument(
      languageCode: languageCode ?? this.languageCode,
      theme: theme ?? this.theme,
      year: year ?? this.year,
    );
  }

  @override
  SettingsDocument merge({@required SettingsDocument entity}) {
    assert(entity != null);

    return copyWith(
      languageCode: entity.languageCode,
      theme: entity.theme,
      year: entity.year,
    );
  }

  @override
  List<Object> get props => [languageCode, theme, year];

  @override
  Map<String, dynamic> toJson() {
    return {
      'languageCode': languageCode,
      'theme': theme,
      'year': year,
    };
  }
}
