import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:xiaoming/components/logo_title_widget.dart';
import 'package:xiaoming/components/type_textfield.dart';
import 'package:xiaoming/controllers/authentication_controller.dart';
import 'package:xiaoming/models/authentication.dart';
import 'package:xiaoming/models/login.dart';
import 'package:xiaoming/services/authentication_service.dart';
import 'package:xiaoming/utils/constant.dart';

import 'forgot_password/forget_password_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  final LogIn _logIn = LogIn();
  bool isVisible = false;

  final emailCon = TextEditingController(),
      passwordCon = TextEditingController();

  final authService = AuthenticationService();

  Future<void> _submitLogin() async {
    FocusScope.of(context).requestFocus(FocusNode());
    setState(() {
      isVisible = true;
    });
    if (_formStateKey.currentState!.validate()) {
      final username = emailCon.text.trim();
      final password = passwordCon.text.trim();

      final authModel = Authentication(
        username: username,
        password: password,
      );

      final token = await authService.login(authModel);
      if (token != null) {
        final controller = Get.find<AuthenticationController>();
        await controller.updateToken(token);
      }
    }
    setState(() {
      isVisible = false;
    });
  }

  Widget highLevelWidget({required Widget child}) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: child,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return highLevelWidget(
      child: Column(
        children: <Widget>[
          const LogoTitleWidget(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Visibility(
              visible: isVisible,
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
          Form(
              key: _formStateKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: AutofillGroup(
                  child: Column(
                    children: [
                      TypeTextField(
                        controller: emailCon,
                        hintText: 'ឈ្មោះគណនី (អ៊ីមែល)',
                        iconData: Icons.email,
                        autofillHints: const [
                          AutofillHints.username,
                          AutofillHints.email
                        ],
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) => validateEmail(value!),
                        onSaved: (value) => _logIn.email = value,
                      ),
                      TypeTextField(
                        controller: passwordCon,
                        hintText: 'ពាក្យសំងាត់',
                        autofillHints: const [AutofillHints.password],
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value) => validatePassword(value!),
                        onSaved: (value) => _logIn.email = value,
                        hasObscureText: true,
                        onEditingComplete: () =>
                            TextInput.finishAutofillContext(
                          shouldSave: true,
                        ),
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      SizedBox(
                          width: Get.width,
                          height: Get.height / 18,
                          child: ElevatedButton(
                            child: const Text('ចូល'),
                            onPressed: () {
                              _submitLogin();
                            },
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      TextButton(
                        onPressed: () {
                          Get.to(() => const ForgetPasswordPage());
                        },
                        child: const Text('ភ្លេចលេខសំងាត់'),
                      )
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
