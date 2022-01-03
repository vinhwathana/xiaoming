import 'package:flutter/material.dart';
import 'package:xiaoming/models/login.dart';
import 'package:xiaoming/utils/constant.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  bool _secureText = true; // display eye and security icon
  final LogIn _logIn = LogIn();

  void _submitLogin() {
    if (_formStateKey.currentState!.validate()) {
      _formStateKey.currentState!.save();
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
                            hintText: 'អ៊ីមែល',
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue)),
                            suffixIcon: Icon(Icons.email),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) => validateEmail(value!),
                          onSaved: (value) => _logIn.email = value,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'អត្តលេខមន្ត្រី',
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue)),
                          ),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              hintText: 'ថ្ងៃ ខែ ឆ្នាំកំណើត',
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue))),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'ពាក្យសំងាត់',
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue)),
                          ),
                          validator: (value) => validatePassword(value!),
                          onSaved: (value) => _logIn.password = value,
                          obscureText: _secureText,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              hintText: 'បញ្ជាក់ពាក្យសំងាត់',
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
                          validator: (value) => validatePassword(value!),
                          onSaved: (value) => _logIn.password = value,
                          obscureText: _secureText,
                        ),
                        SizedBox(height: 35.0),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 18,
                          child: ElevatedButton(
                            child: Text('ចុះឈ្មោះ'),
                            onPressed: () => _submitLogin(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
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
    return Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Image(
        image: AssetImage("assets/images/mptc_logo.png"),
        //color: Colors.orange,
        fit: BoxFit.cover,
        width: MediaQuery.of(context).size.width / 3,
      ),
      SizedBox(height: 16.0),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'បំពេញពាក្យចុះឈ្មោះ',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: Colors.black87),
          ),
          SizedBox(height: 8.0),
        ],
      ),
    ]);
  }
}
