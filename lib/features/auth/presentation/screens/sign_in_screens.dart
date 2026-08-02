import 'package:crafty_bay/features/auth/presentation/widgets/app_logo.dart';
import 'package:crafty_bay/features/shared/presentation/screens/main_nav_holder_screens.dart';
import 'package:flutter/material.dart';

import '../../../../app/extension/utility_extension.dart';
import '../../../../app/validators.dart';

class SignInScreens extends StatefulWidget {
  const SignInScreens({super.key});

  static const String name = "/sign-in";

  @override
  State<SignInScreens> createState() => _SignInScreensState();
}

class _SignInScreensState extends State<SignInScreens> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isObscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = context.textTheme;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUnfocus,
              child: Column(
                children: [
                  const SizedBox(height: 62),
                  const AppLogo(width: 100, height: 100),
                  const SizedBox(height: 16),
                  Text("Welcome Back!", style: textTheme.titleLarge),
                  Text(
                    "Please enter your email and password",
                    style: textTheme.labelLarge,
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _emailTEController,
                    keyboardType: .emailAddress,
                    textInputAction: .next,
                    decoration: InputDecoration(
                      hint: Text("Email"),
                      suffixIcon: IconButton(
                        onPressed: () => _clearData(_emailTEController),
                        icon: Icon(Icons.cancel),
                      ),
                    ),
                    validator: Validators.validateEmail,
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    obscureText: isObscurePassword,
                    obscuringCharacter: '*',
                    controller: _passwordTEController,
                    decoration: InputDecoration(
                      hint: Text("Password"),
                      suffixIcon: IconButton(
                        onPressed: _changePasswordVisibility,
                        icon: isObscurePassword
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility),
                      ),
                    ),

                    validator: Validators.validatePassword,
                  ),

                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: _onTapSignInButton,
                    child: Text("Sign In"),
                  ),

                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an Account?",
                        style: context.textTheme.labelLarge,
                      ),
                      TextButton(
                        onPressed: _onTapSignUpButton,
                        child: Text("Sign Up"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapSignInButton() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      MainNavHolderScreens.name,
      (_) => false,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _emailTEController.dispose();
    _passwordTEController.dispose();
  }

  void _clearData(TextEditingController textEditingController) {
    textEditingController.clear();
  }

  void _changePasswordVisibility() {
    setState(() {
      isObscurePassword = !isObscurePassword;
    });
  }

  void _onTapSignUpButton() {
    Navigator.pop(context);
  }
}
