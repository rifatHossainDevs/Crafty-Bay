import 'package:flutter/material.dart';
import '../../../../app/app_colors.dart';
import '../../../../app/extension/utility_extension.dart';
import '../../../auth/presentation/widgets/app_logo.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  static const String name = '/about';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 24.0, right: 24, top: 24, bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const AppLogo(width: 100, height: 100),
              const SizedBox(height: 16),
              const Text(
                "Crafty Bay",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.themeColor,
                ),
              ),
              Text(
                context.localization.version,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                """Crafty Bay is a premium e-commerce platform that offers a wide variety of high-quality products. Our mission is to provide a seamless and enjoyable shopping experience for our customers, ensuring they find exactly what they need at the best prices.""",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 40),
              _buildAboutItem(
                icon: Icons.language,
                title: "Official Website",
                subtitle: "www.craftybay.com",
                onTap: () {},
              ),
              const Divider(),
              _buildAboutItem(
                icon: Icons.privacy_tip_outlined,
                title: "Privacy Policy",
                subtitle: "Read our privacy guidelines",
                onTap: () {},
              ),
              const Divider(),
              _buildAboutItem(
                icon: Icons.description_outlined,
                title: "Terms & Conditions",
                subtitle: "Review our service terms",
                onTap: () {},
              ),
              const SizedBox(height: 50),
              const Text(
                "© 2026 Crafty Bay Inc.",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
              const Text(
                "All rights reserved.",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAboutItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.themeColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: AppColors.themeColor),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
