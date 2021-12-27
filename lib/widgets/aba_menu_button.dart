import 'package:flutter/material.dart';

class ABAMenuButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final double size;

  const ABAMenuButton(
      {Key key, @required this.icon, @required this.label, this.size = 48})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){},
      child: Container(
          color: Theme.of(context).accentColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                this.icon,
                color: Colors.white,
                size: this.size,
              ),
              SizedBox(height:10.0 ,),
              Text(
                this.label,
                style: TextStyle(color: Colors.white),
              ),
            ],
          )),
    );
  }
}
