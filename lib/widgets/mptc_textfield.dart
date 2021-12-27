import 'package:flutter/material.dart';

class MPTCTextField extends StatelessWidget {
  @required
  final String label;
  @required
  final String value;
  MPTCTextField({this.label, this.value});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            child: Text(label, style: TextStyle(fontWeight: FontWeight.bold),),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
