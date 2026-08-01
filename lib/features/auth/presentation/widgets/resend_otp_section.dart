import 'package:crafty_bay/features/auth/presentation/providers/resend_otp_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/extension/utility_extension.dart';

class ResendOtpSection extends StatefulWidget {
  const ResendOtpSection({super.key});

  @override
  State<ResendOtpSection> createState() => _ResendOtpSectionState();
}

class _ResendOtpSectionState extends State<ResendOtpSection> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ResendOtpProvider>(
      builder: (context, resendOtpProvider, _) {
        return Column(
          children: [
            Visibility(
              visible: resendOtpProvider.isTimerRunning,
              replacement: TextButton(
                onPressed: _onTapResendButton,
                child: Text("Resend OTP"),
              ),
              child: Row(
                mainAxisAlignment: .center,
                children: [
                  Text(
                    "Resend otp after ",
                    style: context.textTheme.labelLarge,
                  ),

                  Text(
                    "${resendOtpProvider.resendOtpTimer}s",
                    style: context.textTheme.labelLarge?.copyWith(
                      color: AppColors.themeColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void _onTapResendButton() {
    context.read<ResendOtpProvider>().startResendOtpTimer();
  }
}
