import 'package:flutter/material.dart';
import 'package:flutter_ar_android_study/ui/_core/widgets/appbar_text_field.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../_core/colors.dart';

AppBar getHomeAppBar(BuildContext context) {
  return AppBar(
    toolbarHeight: 144,
    backgroundColor: AppColors.appBarBackground,
    centerTitle: true,
    title: Column(
      spacing: 8,
      children: [
        SvgPicture.asset(
          "assets/logo.svg",
          height: 40,
        ),
        AppbarTextField(),
      ],
    ),
  );
}
