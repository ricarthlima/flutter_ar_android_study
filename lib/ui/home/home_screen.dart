import 'package:flutter/material.dart';
import 'package:flutter_ar_android_study/data/list_categories.dart';
import 'package:flutter_ar_android_study/domain/models/furniture.dart';
import 'package:flutter_ar_android_study/ui/_core/dimensions.dart';
import 'package:flutter_ar_android_study/ui/_core/widgets/section_widget.dart';
import 'package:flutter_ar_android_study/ui/home/view/home_view_model.dart';
import 'package:flutter_ar_android_study/ui/home/widgets/home_app_bar.dart';
import 'package:flutter_ar_android_study/ui/home/widgets/home_bottom_navigation.dart';
import 'package:flutter_ar_android_study/ui/home/widgets/home_category_widget.dart';
import 'package:flutter_ar_android_study/ui/home/widgets/home_grid_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeViewModel homeViewModel = Provider.of<HomeViewModel>(context);

    return Scaffold(
      appBar: getHomeAppBar(context),
      bottomNavigationBar: HomeBottomNavigationBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SvgPicture.asset(
              "assets/home-banner.svg",
              width: width(context),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
              child: Column(
                spacing: 32,
                children: [
                  SectionWidget(
                    title: "Categorias",
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        spacing: 8,
                        children: listCategories
                            .map((e) => HomeCategoryWidget(category: e))
                            .toList(),
                      ),
                    ),
                  ),
                  SectionWidget(
                    title: "Destaques",
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        spacing: 8,
                        children: List.generate(
                          homeViewModel
                              .getListHighlightedFurniture(context)
                              .length,
                          (index) {
                            Furniture furniture = homeViewModel
                                .getListHighlightedFurniture(context)[index];
                            return HomeGridWidget(furniture: furniture);
                          },
                        ),
                      ),
                    ),
                  ),
                  SectionWidget(
                    title: "Descontos",
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        spacing: 8,
                        children: List.generate(
                          homeViewModel
                              .getListDiscountedFurniture(context)
                              .length,
                          (index) {
                            Furniture furniture = homeViewModel
                                .getListDiscountedFurniture(context)[index];
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
