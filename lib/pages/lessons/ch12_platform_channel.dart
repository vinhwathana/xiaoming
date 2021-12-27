//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const _methodChannel =  const MethodChannel('plateformchannel.companyname.com/devideinfo');
  String _deviceInfo = '';
  Future<void> _getDeviceInfo() async {
    String deviceInfo;
    try {
      deviceInfo = await _methodChannel.invokeMethod('getDeviceInfo');
    } catch(e){
      deviceInfo = "Failed to get device info: '${e.message}'.";
    }
    setState(() {
      _deviceInfo = deviceInfo;
    });
  }
  @override
  void initState() {
    super.initState();
    _getDeviceInfo();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListTile(
          title: Text(
            'Device info:',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            _deviceInfo,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          contentPadding: EdgeInsets.all(16.0),
        ),
      ),
      appBar: AppBar(
        title: Text('Home'),
      ),
    );
  }
}


