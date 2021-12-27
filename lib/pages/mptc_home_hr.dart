import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xiaoming/pages/mptc_dashboard2.dart';
import 'package:xiaoming/pages/mptc_forgetpassword_hr.dart';
import 'package:xiaoming/pages/mptc_profile2.dart';

import 'mptc_signup_hr.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class LogIn {
  String email;
  String password;
}

class _HomeState extends State<Home> {
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  bool _secureText = true; // display eye and security icon
  LogIn _logIn = LogIn();

  String _validateEmail(String value) {
    return (value.contains('@') && value.contains('.'))
        ? null
        : "Enter a valid email";
  }

  String _validatePassword(String value) {
    return (value.length < 6) ? "Enter at least 6 char" : null;
  }

  void _submitLogin() {
    if (_formStateKey.currentState.validate()) {
      _formStateKey.currentState.save();
      print('Email: ${_logIn.email}');
      print('Password: ${_logIn.password}');
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
              children: <Widget>[
                const LogoTitleWidget(),
                Form(
                    autovalidateMode: AutovalidateMode.always,
                    key: _formStateKey,
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
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
                            validator: (value) => _validateEmail(value),
                            onSaved: (value) => _logIn.email = value,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                                hintText: 'ពាក្យសំងាត់',
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue)),
                                suffixIcon: IconButton(
                                  icon: Icon(_secureText
                                      ? Icons.remove_red_eye
                                      : Icons.security),
                                  onPressed: () {
                                    setState(() {
                                      _secureText = !_secureText;
                                    });
                                  },
                                )
                                //labelText: 'ពាក្យសំងាត់',
                                ),
                            validator: (value) => _validatePassword(value),
                            onSaved: (value) => _logIn.password = value,
                            obscureText: _secureText,
                          ),
                          SizedBox(height: 35.0),
                          Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 18,
                              child: ElevatedButton(
                                  child: Text('ចូល'),
                                  onPressed: () {
                                    _submitLogin();
                                    // if (_logIn.email == 'root@root.com' &&
                                    //     _logIn.password == 'rootroot') {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Dashboard2()));
                                    //}
                                  })),
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
    Key key,
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
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: Colors.black87),
        ),
        SizedBox(height: 8.0),
      ],
    );
  }
}
