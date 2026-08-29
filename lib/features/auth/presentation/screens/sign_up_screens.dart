import 'package:crafty_bay/features/auth/presentation/screens/sign_in_screens.dart';
import 'package:crafty_bay/features/auth/presentation/screens/verify_otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/extension/utility_extension.dart';
import '../../../../app/validators.dart';
import '../../../shared/presentation/widget/centered_progress_indicator.dart';
import '../../../shared/presentation/widget/snack_bar_message.dart';
import '../../data/models/sign_up_params.dart';
import '../providers/sign_up_provider.dart';
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

  final SignUpProvider _signUpProvider = SignUpProvider();

  bool isObscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = context.textTheme;

    return ChangeNotifierProvider.value(
      value: _signUpProvider,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(32),
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
                    Consumer<SignUpProvider>(
                      builder: (context, _, _) {
                        if (_signUpProvider.isSignUpInProgress) {
                          return CenteredProgressIndicator();
                        }
                        return FilledButton(
                          onPressed: _onTapSignUpButton,
                          child: Text("Sign Up"),
                        );
                      },
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
      ),
    );
  }

  void _onTapSignInButton() {
    Navigator.pushNamed(context, SignInScreens.name);
  }

  Future<void> _signUp() async {
    SignUpParams params = SignUpParams(
      email: _emailTEController.text.trim(),
      firstName: _firstNameTEController.text.trim(),
      lastName: _lastNameTEController.text.trim(),
      phone: _mobileTEController.text.trim(),
      city: _cityTEController.text.trim(),
      password: _passwordTEController.text,
    );

    final isSuccess = await _signUpProvider.signUp(params);
    if (isSuccess) {
      Navigator.pushNamed(
        context,
        VerifyOtpScreen.name,
        arguments: params.email,
      );
    } else {
      showSnackBarMessage(context, _signUpProvider.errorMessage!);
    }
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
    if (_formKey.currentState!.validate()) {
      _signUp();
    }
  }
}
