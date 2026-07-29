import 'package:crafty_bay/features/auth/presentation/widgets/app_logo.dart';
import 'package:flutter/material.dart';

class SignUpScreens extends StatefulWidget {
  const SignUpScreens({super.key});

  static const String name = "/sign-up";

  @override
  State<SignUpScreens> createState() => _SignUpScreensState();
}

class _SignUpScreensState extends State<SignUpScreens> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const AppLogo(width: 100, height: 100),
            const SizedBox(height: 24),
            Text(
              "Welcome Back",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text("Get stated with us with your details"),
          ],
        ),
      ),
    );
  }
}
