import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../app/assets_paths.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key, required this.width, required this.height});

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      AssetsPaths.logoSvg,
      width: width,
      height: height,
      fit: .scaleDown,
    );
  }
}