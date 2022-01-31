import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xiaoming/components/logo_title_widget.dart';
import 'package:xiaoming/components/type_textfield.dart';
import 'package:xiaoming/services/authentication_service.dart';
import 'package:xiaoming/utils/constant.dart';
import 'package:xiaoming/views/forgot_password/verify_otp_page.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgetPasswordPageState createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  final emailCon = TextEditingController();
  final authService = AuthenticationService();
  bool isVisible = false;

  void _submitLogin() {
    if (_formStateKey.currentState!.validate()) {
      _formStateKey.currentState!.save();
      final email = emailCon.text.trim();
      setState(() {
        isVisible = true;
      });

      setState(() {
        isVisible = false;
      });
      authService.recoveryUserPassword(email).then((value) {
        setState(() {
          isVisible = false;
        });
        if (value) {
          Get.to(() => VerifyOtpPage(
                email: email,
              ));
        } else {
          showToast("Error Occurred");
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const LogoTitleWidget(),
                    Form(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        key: _formStateKey,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              TypeTextField(
                                controller: emailCon,
                                hintText: 'ឈ្មោះគណនី (អ៊ីមែល)',
                                iconData: Icons.email,
                                autofillHints: const [AutofillHints.email],
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) => validateEmail(value!),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: const [
                                  Text(
                                    'យើងនឹងផ្ញើពាក្យសម្ចាត់ដើម្បីកំណត់តំណទៅអ៊ីមែលរបស់អ្នក',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 35.0),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height / 18,
                                  child: ElevatedButton(
                                    child: const Text('ផ្ញើរ OTP'),
                                    onPressed: () => _submitLogin(),
                                  )),
                              TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: const Text('ត្រឡប់ទៅចូលវិញ'),
                              )
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: isVisible,
              child: const Center(
                heightFactor: 15,
                child: CircularProgressIndicator(),
              ),
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text(''),
      ),
    );
  }
}
