import 'package:flutter/material.dart';
import 'package:flutter_ar_android_study/domain/models/furniture.dart';
import 'package:flutter_ar_android_study/ui/ar/ar_screen.dart';

class HomeViewModel extends ChangeNotifier {
  onFurnitureArViewClicked(BuildContext context, Furniture furniture) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return ARScreen(furniture: furniture);
        },
      ),
    );
  }
}
