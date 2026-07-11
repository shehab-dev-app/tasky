import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taskyapp/core/theme/theme_controller.dart';

class CustomSvgPicture extends StatelessWidget {
  const CustomSvgPicture({
    super.key,
    required this.path,
    this.withColorFilter = true,
    this.width,
    this.height,
  });

  const CustomSvgPicture.withOutColorFilter({
    super.key,
    required this.path,
    this.height,
    this.width,
  }) : withColorFilter = false;

  final String path;
  final bool withColorFilter;
  final double? width;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      colorFilter: withColorFilter
          ? ColorFilter.mode(
              ThemeController.isDark() ? Color(0xffFFFCFC) : Color(0xff161F1B),
              BlendMode.srcIn,
            )
          : null,
    );
  }
}
