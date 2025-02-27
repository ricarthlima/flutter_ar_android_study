import 'package:flutter/material.dart';
import 'package:flutter_ar_android_study/domain/models/furniture.dart';
import 'package:flutter_ar_android_study/ui/ar/ar_screen.dart';
import 'package:flutter_ar_android_study/ui/ar/view/ar_view_model.dart';
import 'package:provider/provider.dart';

class HomeViewModel extends ChangeNotifier {
  onFurnitureArViewClicked(BuildContext context, Furniture furniture) {
    Provider.of<ARViewModel>(context, listen: false).furniture = furniture;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return ARScreen();
        },
      ),
    );
  }
}
