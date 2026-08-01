import 'package:crafty_bay/app/app_colors.dart';
import 'package:crafty_bay/features/auth/presentation/providers/resend_otp_provider.dart';
import 'package:crafty_bay/features/auth/presentation/widgets/resend_otp_section.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

import '../../../../app/extension/utility_extension.dart';
import '../widgets/app_logo.dart';

class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({super.key});

  static const String name = "/verify_otp";

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {

  @override
  void initState() {
    super.initState();
    _resendOtpProvider.startResendOtpTimer();
  }
  final PinInputController _otpTEController = PinInputController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final ResendOtpProvider _resendOtpProvider = ResendOtpProvider();

  bool isObscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = context.textTheme;

    return ChangeNotifierProvider.value(
      value: _resendOtpProvider,

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
                    Text("Verify OTP", style: textTheme.titleLarge),
                    Text(
                      "A 4 Digit OTP Code has been Sent",
                      style: textTheme.labelLarge,
                    ),
                    const SizedBox(height: 24),

                    MaterialPinField(
                      pinController: _otpTEController,
                      length: 4,
                      theme: MaterialPinTheme(
                        shape: MaterialPinShape.outlined,
                        cellSize: Size(48, 48),
                        fillColor: Colors.transparent,
                        borderColor: AppColors.themeColor,
                        completeFillColor: Colors.grey,
                        focusedFillColor: AppColors.themeColor.withAlpha(50),
                        filledBorderColor: AppColors.themeColor,
                        borderRadius: BorderRadius.circular(12),
                        completeBorderColor: AppColors.themeColor,
                        spacing: 14,
                      ),
                    ),
                    const SizedBox(height: 16),
                    FilledButton(
                      onPressed: _onTapNextButton,
                      child: Text(context.localization.next),
                    ),

                    const SizedBox(height: 16),
                    ResendOtpSection()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapNextButton() {}

  @override
  void dispose() {
    super.dispose();
    _otpTEController.dispose();
  }
}
