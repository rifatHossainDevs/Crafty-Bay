import 'package:crafty_bay/features/auth/presentation/screens/verify_otp_screen.dart';
import 'package:flutter/material.dart';

import '../../../../app/extension/utility_extension.dart';
import '../../../../app/validators.dart';
import '../widgets/app_logo.dart';

class SignUpScreens extends StatefulWidget {
  const SignUpScreens({super.key});

  static const String name = "/sign-up";

  @override
  State<SignUpScreens> createState() => _SignUpScreensState();
}

class _SignUpScreensState extends State<SignUpScreens> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _cityTEController = TextEditingController();
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
                  const SizedBox(height: 16),
                  const AppLogo(width: 100, height: 100),
                  const SizedBox(height: 16),
                  Text("Sign Up", style: textTheme.titleLarge),
                  Text(
                    "Get stated with us with your details",
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
                    controller: _firstNameTEController,
                    textInputAction: .next,
                    decoration: InputDecoration(
                      hint: Text("First Name"),
                      suffixIcon: IconButton(
                        onPressed: () => _clearData(_firstNameTEController),
                        icon: Icon(Icons.cancel),
                      ),
                    ),
                    validator: (input) => Validators.validateText(
                      input,
                      message: 'Enter your first name',
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _lastNameTEController,
                    textInputAction: .next,
                    decoration: InputDecoration(
                      hint: Text("Last Name"),
                      suffixIcon: IconButton(
                        onPressed: () => _clearData(_lastNameTEController),
                        icon: Icon(Icons.cancel),
                      ),
                    ),
                    validator: (input) => Validators.validateText(
                      input,
                      message: 'Enter your last name',
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _mobileTEController,
                    textInputAction: .next,
                    keyboardType: .phone,
                    decoration: InputDecoration(
                      hint: Text("Mobile"),
                      suffixIcon: IconButton(
                        onPressed: () => _clearData(_mobileTEController),
                        icon: Icon(Icons.cancel),
                      ),
                    ),
                    validator: Validators.validatePhoneNumber,
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _cityTEController,
                    textInputAction: .next,
                    decoration: InputDecoration(
                      hint: Text("City"),
                      suffixIcon: IconButton(
                        onPressed: () => _clearData(_cityTEController),
                        icon: Icon(Icons.cancel),
                      ),
                    ),
                    validator: (input) => Validators.validateText(
                      input,
                      message: 'Enter your city name',
                    ),
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
                    onPressed: _onTapSignUpButton,
                    child: Text("Sign Up"),
                  ),

                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        context.localization.alreadyHaveAnAccount,
                        style: context.textTheme.labelLarge,
                      ),
                      TextButton(
                        onPressed: _onTapSignInButton,
                        child: Text(context.localization.signIn),
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

  }

  @override
  void dispose() {
    super.dispose();
    _emailTEController.dispose();
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _mobileTEController.dispose();
    _cityTEController.dispose();
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
    Navigator.pushNamed(context, VerifyOtpScreen.name);
  }
}
