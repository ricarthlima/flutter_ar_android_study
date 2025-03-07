import 'package:flutter/material.dart';
import 'package:flutter_ar_android_study/domain/models/furniture.dart';
import 'package:flutter_ar_android_study/ui/_core/colors.dart';
import 'package:flutter_ar_android_study/ui/_core/dimensions.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OverlapFurniture extends StatelessWidget {
  final Furniture furniture;
  final bool isShowingControllers;
  final bool isShowingIndicatorText;
  final bool isShowingIndicatorImage;
  final double barrierOpacity;

  final Function? onRotateButtonPressed;
  final Function? onZoomInButtonPressed;
  final Function? onZoomOutButtonPressed;
  final Function? onCenterButtonPressed;

  const OverlapFurniture({
    super.key,
    required this.furniture,
    this.isShowingControllers = false,
    this.isShowingIndicatorText = true,
    this.isShowingIndicatorImage = true,
    this.barrierOpacity = 0.8,
    this.onRotateButtonPressed,
    this.onZoomInButtonPressed,
    this.onZoomOutButtonPressed,
    this.onCenterButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width(context),
      height: height(context),
      decoration: BoxDecoration(
        color: Colors.black.withAlpha((250 * barrierOpacity).floor()),
      ),
      child: Stack(
        children: [
          if (isShowingIndicatorImage)
            Align(
              alignment: Alignment.center,
              child: Image.network(
                furniture.captureWA,
                width: 300,
                height: 300,
              ),
            ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 32, horizontal: 48),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 16,
                children: [
                  if (isShowingIndicatorText)
                    Text(
                      "Mova o dispositivo para posicionar a mobília no ambiente.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                  if (isShowingControllers)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: 16,
                      children: [
                        InkWell(
                          onTap: () => onRotateButtonPressed?.call(),
                          child: SvgPicture.asset(
                            "assets/button-rotate.svg",
                            width: 48,
                            height: 48,
                          ),
                        ),
                        InkWell(
                          onTap: () => onZoomInButtonPressed?.call(),
                          child: SvgPicture.asset(
                            "assets/button-zoom-in.svg",
                            width: 48,
                            height: 48,
                          ),
                        ),
                        InkWell(
                          onTap: () => onZoomOutButtonPressed?.call(),
                          child: SvgPicture.asset(
                            "assets/button-zoom-out.svg",
                            width: 48,
                            height: 48,
                          ),
                        ),
                        InkWell(
                          onTap: () => onCenterButtonPressed?.call(),
                          child: SvgPicture.asset(
                            "assets/button-center.svg",
                            width: 48,
                            height: 48,
                          ),
                        ),
                      ],
                    )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
