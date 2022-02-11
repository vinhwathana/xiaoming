import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:xiaoming/components/logo_title_widget.dart';
import 'package:xiaoming/components/type_textfield.dart';
import 'package:xiaoming/services/authentication_service.dart';
import 'package:xiaoming/utils/constant.dart';
import 'package:xiaoming/views/landing_page.dart';

class VerifyOtpPage extends StatefulWidget {
  const VerifyOtpPage({
    Key? key,
    required this.email,
  }) : super(key: key);
  final String email;

  @override
  State<VerifyOtpPage> createState() => _VerifyOtpPageState();
}

class _VerifyOtpPageState extends State<VerifyOtpPage> {
  final otpCon = TextEditingController(),
      newPasswordCon = TextEditingController();

  final authService = AuthenticationService();

  bool isVisible = false;

  Future<void> onConfirm() async {
    if (!verifyOtpForm.currentState!.validate()) {
      return;
    }
    final newPassword = newPasswordCon.text.trim();
    final otp = otpCon.text.trim();
    final response = await authService.changePasswordWithOTP(
      widget.email,
      newPassword,
      otp,
    );
    if (response.statusCode == 200) {
      Get.offAll(() => const LandingPage());
    } else {
      showToast("Error Occurred");
    }
  }

  final verifyOtpForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text("ផ្ទៀងផ្ទាត់ OTP"),
          ),
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Form(
                key: verifyOtpForm,
                child: Column(
                  children: [
                    const LogoTitleWidget(),
                    Text(
                      "ឈ្មោះគណនី (អ៊ីមែល): ${widget.email}",
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TypeTextField(
                      controller: otpCon,
                      hintText: "លេខកូដ ៦ ខ្ទង់",
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: false,
                        signed: false,
                      ),
                      maxLength: 6,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "emptyField".tr;
                        } else if (value.length < 6) {
                          return "OTP ត្រូវតែមាន 6 ខ្ទង់";
                        }
                      },
                      // autofillHints: [AutofillHints.oneTimeCode],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    AutofillGroup(
                      child: TypeTextField(
                        controller: newPasswordCon,
                        hintText: "ពាក្យសម្ងាត់ថ្មី",
                        hasObscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        autofillHints: const [AutofillHints.newPassword],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: double.maxFinite,
                      child: ElevatedButton(
                        onPressed: () {
                          onConfirm();
                        },
                        child: const Text("ផ្ទៀងផ្ទាត់ OTP"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Visibility(
          visible: isVisible,
          maintainSize: false,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        )
      ],
    );
  }
}
