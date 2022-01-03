import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xiaoming/components/type_textfield.dart';
import 'package:xiaoming/models/authentication.dart';
import 'package:xiaoming/models/login.dart';
import 'package:xiaoming/services/authentication_service.dart';
import 'package:xiaoming/views/chart_page.dart';
import 'package:xiaoming/views/home_page.dart';
import 'package:xiaoming/views/mptc_forgetpassword_hr.dart';
import 'package:xiaoming/utils/constant.dart';

import 'mptc_signup_hr.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  bool _secureText = true; // display eye and security icon
  final LogIn _logIn = LogIn();

  final emailCon = TextEditingController(),
      passwordCon = TextEditingController();

  final authService = AuthenticationService();

  Future<void> _submitLogin() async {
    if (_formStateKey.currentState!.validate()) {
      _formStateKey.currentState!.save();
      final username = emailCon.text.trim();
      final password = passwordCon.text.trim();

      final authModel = Authentication(
        username: username,
        password: password,
      );
      bool result = await authService.login(authModel);
      if (result) {
        Get.offAll(() => HomePage());
      }
    }
  }

  Widget highLevelWidget({required Widget child}) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(padding: const EdgeInsets.all(16.0), child: child),
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
          Form(
              key: _formStateKey,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TypeTextField(
                      controller: emailCon,
                      hintText: 'ឈ្មោះគណនី (អ៊ីមែល)',
                      iconData: Icons.email,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) => validateEmail(value!),
                      onSaved: (value) => _logIn.email = value,
                    ),
                    //TODO: obscure text function
                    TypeTextField(
                      controller: passwordCon,
                      hintText: 'ពាក្យសំងាត់',
                      iconData: Icons.email,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) => validatePassword(value!),
                      onSaved: (value) => _logIn.email = value,
                    ),
                    // TextFormField(
                    //   decoration: InputDecoration(
                    //       hintText: 'ពាក្យសំងាត់',
                    //       enabledBorder: UnderlineInputBorder(
                    //           borderSide: BorderSide(color: Colors.blue)),
                    //       suffixIcon: IconButton(
                    //         icon: Icon(_secureText
                    //             ? Icons.remove_red_eye
                    //             : Icons.security),
                    //         onPressed: () {
                    //           setState(() {
                    //             _secureText = !_secureText;
                    //           });
                    //         },
                    //       )
                    //       //labelText: 'ពាក្យសំងាត់',
                    //       ),
                    //   validator: (value) => validatePassword(value!),
                    //   onSaved: (value) => _logIn.password = value,
                    //   obscureText: _secureText,
                    // ),
                    SizedBox(height: 35.0),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 18,
                        child: ElevatedButton(
                          child: Text('ចូល'),
                          onPressed: () {
                            _submitLogin();
                          },
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Signup()));
                            },
                            child: Text('ចុះឈ្មោះ')),
                        Text(' || '),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ForgetPassword()));
                            },
                            child: Text('ភ្លេចលេខសំងាត់')),
                      ],
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

class LogoTitleWidget extends StatelessWidget {
  const LogoTitleWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Image(
          image: AssetImage("assets/images/mptc_logo.png"),
          //color: Colors.orange,
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width / 3,
        ),
        SizedBox(height: 16.0),
        Text(
          'ប្រព័ន្ធគ្រប់គ្រងទិន្នន័យមន្ត្រី',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.w600, fontSize: 20, color: Colors.black87),
        ),
        SizedBox(height: 8.0),
      ],
    );
  }
}
