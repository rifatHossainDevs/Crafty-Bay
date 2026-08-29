import 'package:crafty_bay/app/app_colors.dart';
import 'package:crafty_bay/features/auth/data/models/verify_otp_params.dart';
import 'package:crafty_bay/features/auth/presentation/providers/resend_otp_provider.dart';
import 'package:crafty_bay/features/auth/presentation/widgets/resend_otp_section.dart';
import 'package:crafty_bay/features/shared/presentation/widget/snack_bar_message.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

import '../../../../app/extension/utility_extension.dart';
import '../../../shared/presentation/screens/main_nav_holder_screens.dart';
import '../../../shared/presentation/widget/centered_progress_indicator.dart';
import '../providers/verify_otp_provider.dart';
import '../widgets/app_logo.dart';

class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({super.key, required this.email});

  static const String name = "/verify_otp";
  final String email;

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

  final VerifyOtpProvider _verifyOtpProvider = VerifyOtpProvider();

  bool isObscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = context.textTheme;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _resendOtpProvider),
        ChangeNotifierProvider.value(value: _verifyOtpProvider),
      ],
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
                    Consumer<VerifyOtpProvider>(
                      builder: (context, _, _) {
                        if (_verifyOtpProvider.isVerifyOtpInProgress) {
                          return CenteredProgressIndicator();
                        }
                        return FilledButton(
                          onPressed: _onTapNextButton,
                          child: Text(context.localization.next),
                        );
                      },
                    ),

                    const SizedBox(height: 16),
                    ResendOtpSection(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapNextButton() {
    if (_otpTEController.text.length == 4) {
      _verifyOtp();
    }
  }

  Future<void> _verifyOtp() async {
    VerifyOtpParams params = VerifyOtpParams(
      email: widget.email,
      otp: _otpTEController.text,
    );
    bool isSuccess = await _verifyOtpProvider.verifyOtp(params);

    if (isSuccess) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        MainNavHolderScreens.name,
        (_) => false,
      );
    } else {
      showSnackBarMessage(context, _verifyOtpProvider.errorMessage!);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _otpTEController.dispose();
  }
}
