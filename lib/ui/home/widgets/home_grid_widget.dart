import 'package:flutter/material.dart';
import 'package:flutter_ar_android_study/domain/models/furniture.dart';
import 'package:flutter_ar_android_study/ui/_core/widgets/primary_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../_core/colors.dart';
import '../view/home_view_model.dart';

class HomeGridWidget extends StatelessWidget {
  final Furniture furniture;
  const HomeGridWidget({
    super.key,
    required this.furniture,
  });

  @override
  Widget build(BuildContext context) {
    HomeViewModel homeViewModel = Provider.of<HomeViewModel>(context);
    return SizedBox(
      height: 375,
      width: 186,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 186,
            height: 200,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: AppColors.buttonBorder,
                    ),
                  ),
                  child: Image.network(
                    furniture.capture,
                    width: 186,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: InkWell(
                        onTap: () =>
                            homeViewModel.onFurnitureArViewClicked(furniture),
                        child: SvgPicture.asset("assets/ar-button.svg"),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColors.furnitureWidgetBackground,
            ),
            padding: EdgeInsets.all(16),
            height: 175,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  furniture.name,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                Text(
                  "R\$${furniture.price.toStringAsFixed(2).replaceAll(".", ",")}",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ),
                PrimaryButton(
                  onPressed: () {},
                  child: "Comprar",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
