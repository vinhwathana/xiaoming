import 'package:flutter/material.dart';

class AnimatedContainerWidget extends StatefulWidget {
  const AnimatedContainerWidget({
    Key key,
}): super (key: key);
  @override
  _AnimatedContainerWidgetState createState() => _AnimatedContainerWidgetState();
}

class _AnimatedContainerWidgetState extends State<AnimatedContainerWidget> {
  double _height = 100.0;
  double _width = 100.0;

  _increaseWidth(){
    setState(() {
      _width = _width>=320.0?100.0: _width +=50;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AnimatedContainer(
          duration: Duration(microseconds: 500),
          curve: Curves.elasticInOut,
          color: Colors.amber,
          height: _height,
          width: _width,
          child: TextButton(
            child: Text('Tap to \nGrow Width\n $_width'),
            onPressed: () {
              _increaseWidth();
            },
          ),
        )
      ],
    );
  }
}
