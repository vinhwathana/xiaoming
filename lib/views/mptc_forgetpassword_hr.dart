import 'package:flutter/material.dart';
import 'package:xiaoming/models/login.dart';
import 'package:xiaoming/utils/constant.dart';

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  final LogIn _logIn = LogIn();

  void _submitLogin() {
    if (_formStateKey.currentState!.validate()) {
      _formStateKey.currentState!.save();
      print('Email: ${_logIn.email}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const LogoTitleWidget(),
                Form(
                    autovalidateMode: AutovalidateMode.always,
                    key: _formStateKey,
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'ឈ្មោះគណនី (អ៊ីមែល)',
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue)),
                              suffixIcon: Icon(Icons.email),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) => validateEmail(value!),
                            onSaved: (value) => _logIn.email = value,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'យើងនឹងផ្ញើពាក្យសម្ចាត់ដើម្បីកំណត់តំណទៅអ៊ីមែលរបស់អ្នក',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 35.0),
                          Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 18,
                              child: ElevatedButton(
                                child: Text('ផ្ញើរ OTP'),
                                onPressed: () => _submitLogin(),
                              )),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('ត្រឡប់ទៅចូលវិញ'))
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
      appBar: AppBar(
        title: Text(''),
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
      children: [
        Image(
          image: AssetImage("assets/images/mptc_logo.png"),
          //color: Colors.orange,
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width / 3,
        ),
        SizedBox(height: 16.0),
        Text(
          'កំណត់ពាក្យសម្ចាត់ឡើងវិញ',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.w600, fontSize: 20, color: Colors.black87),
        ),
        SizedBox(height: 8.0),
      ],
    );
  }
}
