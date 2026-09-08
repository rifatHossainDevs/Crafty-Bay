import 'package:crafty_bay/app/providers/auth_controller.dart';
import 'package:crafty_bay/features/auth/presentation/screens/sign_in_screens.dart';
import 'package:crafty_bay/features/shared/presentation/providers/main_nav_holder_provider.dart';
import 'package:crafty_bay/features/shared/presentation/widget/snack_bar_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../app/assets_paths.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key, required this.onProfileTap});

  final VoidCallback onProfileTap;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: SvgPicture.asset(AssetsPaths.navLogoSvg),
      actions: [
        _buildIconButton(
          icon: Icons.shopping_cart,
          onTap: () async {
            bool isLoggedIn = await AuthController.isLoggedIn();
            if (isLoggedIn) {
              context.read<MainNavHolderProvider>().changeIndex(2);
            } else {
              Navigator.pushNamed(context, SignInScreens.name);
            }
          },
        ),
        const SizedBox(width: 8),
        _buildIconButton(
          icon: Icons.add_ic_call_outlined,
          onTap: () async {
            final Uri launchUri = Uri(scheme: 'tel', path: '+880123456789');

            if (await canLaunchUrl(launchUri)) {
              await launchUrl(launchUri);
            } else {
              showSnackBarMessage(context, 'Could not launch dialer');
            }
          },
        ),
        const SizedBox(width: 8),
        _buildIconButton(icon: Icons.person_outline, onTap: onProfileTap),
        const SizedBox(width: 16),
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
        child: Icon(icon, color: Colors.grey, size: 20),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
