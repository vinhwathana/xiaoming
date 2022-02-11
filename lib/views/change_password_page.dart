import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:xiaoming/components/type_textfield.dart';
import 'package:xiaoming/controllers/authentication_controller.dart';
import 'package:xiaoming/controllers/user_controller.dart';
import 'package:xiaoming/services/authentication_service.dart';
import 'package:xiaoming/utils/constant.dart';
import 'package:xiaoming/views/landing_page.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final oldPasswordCon = TextEditingController(),
      newPasswordCon = TextEditingController(),
      confirmNewPasswordCon = TextEditingController();

  final authService = AuthenticationService();
  final userController = Get.find<UserController>();
  final authController = Get.find<AuthenticationController>();

  Future<void> onConfirmPasswordChange() async {
    FocusScope.of(context).requestFocus(FocusNode());
    final oldPassword = oldPasswordCon.text.trim();
    final newPassword = newPasswordCon.text.trim();
    final confirmNewPassword = confirmNewPasswordCon.text.trim();
    if (!resetPasswordFormKey.currentState!.validate()) {
      return;
    }

    if (newPassword != confirmNewPassword) {
      showToast("ពាក្យសម្ងាត់របស់អ្នកមិនត្រូវគ្នា");
      return;
    }

    final user = userController.users?.value;

    if (user == null) {
      print("User null");
      await authController.clearToken();
      Get.offAll(() => const LandingPage());
      return;
    }
    final userEmail = user.officialInfo?.contactEmail;
    if (userEmail == null) {
      print("Email null");
      await authController.clearToken();
      Get.offAll(() => const LandingPage());
      return;
    }

    final response = await authService.changePassword(
      userEmail,
      oldPassword,
      newPassword,
    );
    if (response == null) {
      showToast("Something went wrong");
      await authController.clearToken();
      Get.offAll(() => const LandingPage());
      return;
    }
    if (response.statusCode == 200) {
      showToast("ពាក្យសម្ងាត់កែសម្រួលបានសម្រេច\nសូមចូលម្តងទៀត");
      await authController.clearToken();
      Get.offAll(() => const LandingPage());
    } else {
      showToast("ប្រតិបត្តិបរាជ័យ");
    }
  }

  final resetPasswordFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ផ្លាស់ប្តូរពាក្យសម្ងាត់"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Form(
          key: resetPasswordFormKey,
          child: AutofillGroup(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "ផ្លាស់ប្តូរពាក្យសម្ងាត់",
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  height: 20,
                ),
                TypeTextField(
                  hintText: "ពាក្យសម្ងាត់ចាស់",
                  autofillHints: const [AutofillHints.password],
                  keyboardType: TextInputType.visiblePassword,
                  validator: (value) => validatePassword(value!),
                  hasObscureText: true,
                  controller: oldPasswordCon,
                ),
                const SizedBox(
                  height: 20,
                ),
                TypeTextField(
                  hintText: "ពាក្យសម្ងាត់ថ្មី",
                  autofillHints: const [AutofillHints.newPassword],
                  keyboardType: TextInputType.visiblePassword,
                  validator: (value) => validatePassword(value!),
                  hasObscureText: true,
                  onEditingComplete: () => TextInput.finishAutofillContext(
                    shouldSave: true,
                  ),
                  controller: newPasswordCon,
                ),
                const SizedBox(
                  height: 20,
                ),
                TypeTextField(
                  hintText: "បញ្ជាក់លេខសំងាត់ថ្មី",
                  autofillHints: const [AutofillHints.newPassword],
                  keyboardType: TextInputType.visiblePassword,
                  validator: (value) => validatePassword(value!),
                  hasObscureText: true,
                  onEditingComplete: () => TextInput.finishAutofillContext(
                    shouldSave: true,
                  ),
                  controller: confirmNewPasswordCon,
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.maxFinite,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      onConfirmPasswordChange();
                    },
                    child: const Text("ផ្លាស់ប្តូរ"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
