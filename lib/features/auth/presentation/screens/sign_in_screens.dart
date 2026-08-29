import 'package:crafty_bay/features/auth/data/models/sign_in_params.dart';
import 'package:crafty_bay/features/auth/presentation/providers/sign_in_provider.dart';
import 'package:crafty_bay/features/auth/presentation/screens/sign_up_screens.dart';
import 'package:crafty_bay/features/auth/presentation/screens/verify_otp_screen.dart';
import 'package:crafty_bay/features/auth/presentation/widgets/app_logo.dart';
import 'package:crafty_bay/features/shared/presentation/widget/centered_progress_indicator.dart';
import 'package:crafty_bay/features/shared/presentation/widget/snack_bar_message.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/extension/utility_extension.dart';
import '../../../../app/validators.dart';
import '../../../shared/presentation/screens/main_nav_holder_screens.dart';

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
  final SignInProvider _signInProvider = SignInProvider();

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = context.textTheme;

    return ChangeNotifierProvider.value(
      value: _signInProvider,
      child: Scaffold(
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
                    Consumer<SignInProvider>(
                      builder: (context, _, _) {
                        if (_signInProvider.isSignInInProgress) {
                          return CenteredProgressIndicator();
                        }
                        return FilledButton(
                          onPressed: _onTapSignInButton,
                          child: Text("Sign In"),
                        );
                      },
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
      ),
    );
  }

  void _onTapSignInButton() {
    if (_formKey.currentState!.validate()) {
      _signIn();
    }
  }

  Future<void> _signIn() async {
    SignInParams params = SignInParams(
      email: _emailTEController.text.trim(),
      password: _passwordTEController.text,
    );

    bool isSuccess = await _signInProvider.signIn(params);

    if(!mounted) return;

    if (isSuccess) {
      Navigator.pushNamed(
        context,
        MainNavHolderScreens.name,
        arguments: params.email
      );
    } else {
      showSnackBarMessage(context, _signInProvider.errorMessage!);
    }
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
    Navigator.pushNamed(context, SignUpScreens.name);
  }
}
