import 'package:flutter/material.dart';
import 'package:flutter_ar_android_study/domain/furniture_provider.dart';
import 'package:flutter_ar_android_study/domain/models/furniture.dart';
import 'package:flutter_ar_android_study/ui/home/home_screen.dart';
import 'package:provider/provider.dart';

class HomeViewModel extends ChangeNotifier {
  List<Furniture> _listHighlightedFurniture = [];
  List<Furniture> _listDiscountedFurniture = [];

  void onSplashEnterButtonPressed(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ),
    );
  }

  onFurnitureArViewClicked(Furniture furniture) {}

  List<Furniture> getListHighlightedFurniture(BuildContext context) {
    if (_listHighlightedFurniture.isEmpty) {
      _listHighlightedFurniture =
          context.read<FurnitureProvider>().getRandomListFurniture(amount: 4);
    }
    return _listHighlightedFurniture;
  }

  List<Furniture> getListDiscountedFurniture(BuildContext context) {
    if (_listDiscountedFurniture.isEmpty) {
      _listDiscountedFurniture =
          context.read<FurnitureProvider>().getRandomListFurniture(amount: 4);
    }
    return _listDiscountedFurniture;
  }
}
