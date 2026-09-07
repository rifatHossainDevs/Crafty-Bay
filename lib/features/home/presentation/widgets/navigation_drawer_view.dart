import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../app/assets_paths.dart';
import '../../../../app/providers/auth_controller.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../auth/presentation/screens/edit_profile_screen.dart';
import '../../../auth/presentation/screens/splash_screen.dart';
import '../../../brands/presentation/screens/brands_screen.dart';
import '../../../shared/presentation/screens/about_screen.dart';

class NavigationDrawerView extends StatelessWidget {
  const NavigationDrawerView({
    super.key,
    required this.localization,
  });

  final AppLocalizations localization;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('${AuthController.userModel!.firstName} ${AuthController.userModel!.lastName}'),
            accountEmail: Text(AuthController.userModel!.email),
            currentAccountPicture: CircleAvatar(
              child: Icon(Icons.person, size: 40),
            ),
          ),

          SizedBox(height: 16),

          ListTile(
            leading: Icon(Icons.light),
            title: Text("Theme"),
            trailing: ThemeChangerDropdown(),
          ),
          Divider(color: Colors.grey),

          ListTile(
            leading: Icon(Icons.language),
            title: Text("Language"),
            trailing: LocalChangerDropdown(),
          ),
          Divider(color: Colors.grey),

          ListTile(
            leading: Icon(Icons.edit),
            title: Text("Edit Profile"),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.pushNamed(context, EditProfileScreen.name);
            },
          ),
          Divider(color: Colors.grey),

          ListTile(
            leading: Icon(Icons.local_attraction_sharp),
            title: Text("Brands"),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.pushNamed(context, BrandsScreen.name);
            },
          ),
          Divider(color: Colors.grey),

          ListTile(
            leading: Icon(Icons.info_outline),
            title: Text("About"),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.pushNamed(context, AboutScreen.name);
            },
          ),
          Divider(color: Colors.grey),

          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Logout"),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
          Divider(color: Colors.grey),

          SizedBox(height: 16),

          Row(
            mainAxisAlignment: .center,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.facebook, size: 38),
              ),
              SizedBox(width: 16),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.email, size: 38),
              ),
              SizedBox(width: 16),
              IconButton(
                onPressed: () {},
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
          SizedBox(height: 12,)
        ],
      ),
    );
  }
}