import 'dart:io';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:profile/model/product_model.dart';

class TestScreen extends StatelessWidget {
  final Products? products;

  const TestScreen({Key? key, this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return ThemeSwitchingArea(
      child: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.symmetric(),
            child: Image.file(
                File('/data/user/0/com.example.profile/app_flutter/image.png'))
          ),
        ),
      ),
    );
  }
}
