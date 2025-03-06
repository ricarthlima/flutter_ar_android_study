import 'package:flutter/material.dart';
import 'package:flutter_ar_android_study/domain/models/furniture.dart';
import 'package:flutter_ar_android_study/ui/home/home_screen.dart';

class HomeViewModel extends ChangeNotifier {
  void onSplashEnterButtonPressed(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ),
    );
  }

  onFurnitureArViewClicked(Furniture furniture) {}
}
