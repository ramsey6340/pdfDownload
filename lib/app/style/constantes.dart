import 'package:flutter/material.dart';

const kPrimaryColor = Colors.redAccent;
const kInactiveColorPrimary = Colors.grey;
const kDividerIndent = 30.0;
const kAllowedFileExtensions = ['pdf', 'xlsx', 'docx', 'ppt'];
enum DocStatus {
  traitement,
  ok,
  refuse

}

enum UploadStatus {
  uploading,
  finished,
}

enum LoginPageType {
  signIn,
  signUp
}

enum AcademicLevel {
  maternelle,
  fondamental,
  lycee,
  universite
}
List<AcademicLevel> kAcademicLevelList = [
  AcademicLevel.maternelle,
  AcademicLevel.fondamental,
  AcademicLevel.lycee,
  AcademicLevel.universite
];

enum CollectionNames {
  admins,
  documents,
  processing
}

const kShimmerDarkGradient = LinearGradient(
      colors: [
      Color(0xFF222222),
      Color(0xFF242424),
      Color(0xFF2B2B2B),
      Color(0xFF242424),
      Color(0xFF222222),
      ],
      stops: [
      0.0,
      0.2,
      0.5,
      0.8,
      1,
      ],
      begin: Alignment(-2.4, -0.2),
      end: Alignment(2.4, 0.2),
      tileMode: TileMode.clamp,
);

const kShimmerLightGradient = LinearGradient(
  colors: [
    Color(0xFFD8E3E7),
    Color(0xFFC8D5DA),
    Color(0xFFD8E3E7),
  ],
  stops: [
    0.1,
    0.5,
    0.9,
  ],
);

enum Role {
  admin,
  user
}

ThemeData _lightTheme = ThemeData(
  brightness: Brightness.light,
);

ThemeData _darkTheme = ThemeData(
  brightness: Brightness.dark,
);