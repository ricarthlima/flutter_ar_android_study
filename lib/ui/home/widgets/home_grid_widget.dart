import 'package:flutter/material.dart';
import 'package:flutter_ar_android_study/domain/models/furniture.dart';
import 'package:flutter_ar_android_study/ui/_core/widgets/primary_button.dart';
import 'package:provider/provider.dart';

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
      height: 500,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            spacing: 8,
            children: [
              IntrinsicHeight(
                child: Stack(
                  children: [
                    Image.network(furniture.capture),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 32,
                          height: 32,
                          child: IconButton.filled(
                            onPressed: () => homeViewModel
                                .onFurnitureArViewClicked(furniture),
                            iconSize: 16,
                            icon: Icon(Icons.camera),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Text(
                furniture.name,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                furniture.description,
                textAlign: TextAlign.justify,
              ),
            ],
          ),
          Column(
            spacing: 8,
            children: [
              Text(
                furniture.price.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              PrimaryButton(
                onPressed: () {},
                child: "Comprar",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
