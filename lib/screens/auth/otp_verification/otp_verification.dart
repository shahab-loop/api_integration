import 'package:api_integ/screens/auth/otp_verification/controller/otp_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpVerification extends StatelessWidget {
  static const String routeName = '/otpVerification';

  const OtpVerification({super.key});

  @override
  Widget build(BuildContext context) {
    final OtpController controller = Get.put(OtpController());
    return Scaffold(
      appBar: AppBar(title: const Text("OTP Verification")),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const Text(
              "Enter Verification Code",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            const Text(
              "Enter the 6 digit code sent to your email",
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 30),

            TextField(
              controller: controller.otpController,
              keyboardType: TextInputType.number,
              maxLength: 6,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "------",
              ),
            ),

            const SizedBox(height: 20),

            Obx(() => controller.isLoading.value
                ? const CircularProgressIndicator()
                : ElevatedButton(
              onPressed: controller.otpVerification,
              child: const Text("Verify OTP"),
            )),

            const SizedBox(height: 20),

            TextButton(
              onPressed: controller.resendOtp,
              child: const Text("Resend OTP"),
            )

          ],
        ),
      ),
    );
  }
}