import 'package:flutter/material.dart';
import 'package:flutter_ar_android_study/domain/furniture_provider.dart';
import 'package:flutter_ar_android_study/domain/models/furniture.dart';
import 'package:flutter_ar_android_study/ui/_core/dimensions.dart';
import 'package:flutter_ar_android_study/ui/_core/widgets/section_widget.dart';
import 'package:flutter_ar_android_study/ui/home/widgets/home_app_bar.dart';
import 'package:flutter_ar_android_study/ui/home/widgets/home_grid_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    FurnitureProvider furnitureProvider =
        Provider.of<FurnitureProvider>(context);

    return Scaffold(
      appBar: getHomeAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          spacing: 32,
          children: [
            SvgPicture.asset(
              "assets/home-banner.svg",
              width: width(context),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  SectionWidget(
                    title: "Destaques",
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
                            Furniture furniture =
                                furnitureProvider.listFurniture[index];
                            return HomeGridWidget(furniture: furniture);
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
