import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../app/assets_paths.dart';
import '../../../../app/providers/auth_controller.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../auth/presentation/screens/edit_profile_screen.dart';
import '../../../auth/presentation/screens/splash_screen.dart';
import '../../../brands/presentation/screens/brands_screen.dart';
import '../../../shared/presentation/screens/about_screen.dart';
import '../../../shared/presentation/widget/snack_bar_message.dart';

class NavigationDrawerView extends StatelessWidget {
  const NavigationDrawerView({super.key, required this.localization});

  final AppLocalizations localization;

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(localization.logout),
          content: Text(localization.logoutDescription),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(localization.no),
            ),
            TextButton(
              onPressed: () {
                AuthController.clearUserData();
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  SplashScreen.name,
                  (route) => false,
                );
              },
              child: Text(localization.yes),
            ),
          ],
        );
      },
    );
  }

  void _launchURL(BuildContext context, String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (context.mounted) {
        showSnackBarMessage(context, 'Could not launch $url');
      }
    }
  }

  void _sendEmail(BuildContext context) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'support@craftybay.com',
    );
    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      if (context.mounted) {
        showSnackBarMessage(context, 'Could not launch email app');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFF006A6B)
            ),
            accountName: Text(
              AuthController.userModel == null
                  ? localization.noUserNameFound
                  : '${AuthController.userModel!.firstName} ${AuthController.userModel!.lastName}',
              style: TextStyle(color: Colors.white),
            ),
            accountEmail: Text(
              AuthController.userModel == null
                  ? localization.noUserEmailFound
                  : AuthController.userModel!.email,
              style: TextStyle(color: Colors.white),
            ),
            currentAccountPicture: CircleAvatar(
              child: Icon(Icons.person, size: 40),
            ),
          ),

          SizedBox(height: 16),

          ListTile(
            leading: Icon(Icons.light),
            title: Text(localization.theme),
            trailing: ThemeChangerDropdown(),
          ),
          Divider(color: Colors.grey),

          ListTile(
            leading: Icon(Icons.language),
            title: Text(localization.language),
            trailing: LocalChangerDropdown(),
          ),
          Divider(color: Colors.grey),

          ListTile(
            leading: Icon(Icons.edit),
            title: Text(localization.editProfile),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.pushNamed(context, EditProfileScreen.name);
            },
          ),
          Divider(color: Colors.grey),

          ListTile(
            leading: Icon(Icons.local_attraction_sharp),
            title: Text(localization.brands),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.pushNamed(context, BrandsScreen.name);
            },
          ),
          Divider(color: Colors.grey),

          ListTile(
            leading: Icon(Icons.info_outline),
            title: Text(localization.about),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.pushNamed(context, AboutScreen.name);
            },
          ),
          Divider(color: Colors.grey),

          ListTile(
            leading: Icon(Icons.logout),
            title: Text(localization.logout),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              _showLogoutDialog(context);
            },
          ),
          Divider(color: Colors.grey),

          SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () =>
                    _launchURL(context, 'https://www.facebook.com/craftybay'),
                icon: const Icon(Icons.facebook, size: 38),
              ),
              const SizedBox(width: 16),
              IconButton(
                onPressed: () => _sendEmail(context),
                icon: const Icon(Icons.email, size: 38),
              ),
              const SizedBox(width: 16),
              IconButton(
                onPressed: () =>
                    _launchURL(context, 'https://wa.me/880123456789'),
                icon: SvgPicture.asset(
                  AssetsPaths.whatsappSvg,
                  height: 32,
                  width: 32,
                ),
              ),
            ],
          ),
          Spacer(),
          Text(localization.version),
          SizedBox(height: 12),
        ],
      ),
    );
  }
}
