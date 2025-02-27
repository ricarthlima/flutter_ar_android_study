import 'package:flutter/material.dart';
import 'package:flutter_ar_android_study/domain/furniture_provider.dart';
import 'package:flutter_ar_android_study/domain/models/furniture.dart';
import 'package:flutter_ar_android_study/ui/home/widgets/home_grid_widget.dart';
import 'package:provider/provider.dart';

import 'view/home_view_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    FurnitureProvider furnitureProvider =
        Provider.of<FurnitureProvider>(context);

    HomeViewModel homeViewModel = Provider.of<HomeViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Toca")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 3.5 / 10,
            mainAxisSpacing: 16,
            crossAxisSpacing: 8,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: NeverScrollableScrollPhysics(),
            children: List.generate(
              furnitureProvider.listFurniture.length,
              (index) {
                Furniture furniture = furnitureProvider.listFurniture[index];
                return HomeGridWidget(furniture: furniture);
              },
            ),
          ),
        ),
      ),
    );
  }
}
