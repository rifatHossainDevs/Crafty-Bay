import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../app/assets_paths.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: SvgPicture.asset(AssetsPaths.navLogoSvg),
      actions: [
        _buildIconButton(icon: Icons.person_outline, onTap: () {}),
        const SizedBox(width: 8,),
        _buildIconButton(icon: Icons.add_ic_call_outlined, onTap: () {}),
        const SizedBox(width: 8,),
        _buildIconButton(icon: Icons.notifications_active_outlined, onTap: () {}),
        const SizedBox(width: 16,)
      ],
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: 16,
        backgroundColor: Colors.grey.withAlpha(40),
        child: Icon(icon, color: Colors.grey, size: 20,),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}