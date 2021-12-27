import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();

  //Order to Save
  Order _order = Order();

  String _validateItemRequired(String value){
    return value.isEmpty? 'Item Required' : null;
  }

  String _validateItemCount(String value) {
    //Check if value is not null and convert to integer
    int _valueAsInteger = value.isEmpty? 0 : int.tryParse(value);
    return _valueAsInteger ==0 ? 'At least one Item is Required': null;
  }

  void _submitOrder() {
    if (_formStateKey.currentState.validate()){
      _formStateKey.currentState.save();
      print('Order Item: ${_order.item}');
      print('Order Quantity: ${_order.quantity}');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Form(
              autovalidateMode: AutovalidateMode.always, key: _formStateKey,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Espresso',
                        labelText: 'Item',
                      ),
                      validator: (value) => _validateItemRequired(value),
                      onSaved: (value) => _order.item = value,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: '3',
                        labelText: 'Quantity',
                      ),
                      validator: (value) => _validateItemCount(value),
                      onSaved: (value) => _order.quantity = int.tryParse(value),
                    ),
                    Divider(height: 32.0,),
                    ElevatedButton(
                      //style: ElevatedButton.styleFrom(
                        //primary: Colors.lightBlue,
                        //onPrimary: Colors.white,
                      //),
                      child: Text('save'),
                      //color: Colors.lightBlue,
                      onPressed: () => _submitOrder(),),
                  ],
                ),
              )
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Home'),
      ),
    );
  }
}
class Order {
  String item;
  int quantity;
}