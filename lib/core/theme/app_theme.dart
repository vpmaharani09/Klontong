import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:klontong/gen/colors.gen.dart';

ThemeData get appTheme => ThemeData(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primaryColor: ColorName.primary,
      scaffoldBackgroundColor: Colors.white,
    );

AppBarTheme get appBarTheme => const AppBarTheme(
      color: Colors.white,
      elevation: 0,
      centerTitle: true,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      actionsIconTheme: IconThemeData(color: ColorName.primary),
      iconTheme: IconThemeData(color: ColorName.primary),
    );
