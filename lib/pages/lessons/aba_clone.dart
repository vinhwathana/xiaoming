import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xiaoming/widgets/aba_logo.dart';
import 'package:xiaoming/widgets/aba_menu_button.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  BuildContext context;
  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
      appBar: _buildAppBar,
      drawer: Drawer(),
      body: _buildBody,
    );
  }

  Widget get _buildAppBar {
    return AppBar(
      title: abaLogo,
      actions: [
        IconButton(
            icon: Icon(
              Icons.notifications_active_outlined,
              size: 30.0,
            ),
            onPressed: () {}),
        IconButton(
            icon: Icon(
              Icons.phone_callback,
              size: 28.0,
            ),
            onPressed: () {}),
      ],
    );
  }

  Widget get _buildBody {
    return Container(
      //color: Theme.of(context).accentColor,
      child: Column(
        children: [
          Flexible(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                  gradient: RadialGradient(colors: [
                Colors.white,
                Theme.of(context).accentColor,
              ])),
              child: GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 1.0,
                mainAxisSpacing: 1.0,
                children: [
                  ABAMenuButton(
                    icon: Icons.wallet_membership,
                    label: 'Account',
                    size: 50,
                  ),
                  ABAMenuButton(
                    icon: Icons.card_travel,
                    label: 'Card',
                    size: 50,
                  ),
                  ABAMenuButton(
                    icon: Icons.payment,
                    label: 'Payments',
                    size: 50,
                  ),
                  ABAMenuButton(
                    icon: Icons.open_in_new,
                    label: 'New Account',
                    size: 50,
                  ),
                  ABAMenuButton(
                    icon: Icons.local_atm,
                    label: 'Cash to ATM',
                    size: 50,
                  ),
                  ABAMenuButton(
                    icon: CupertinoIcons.repeat,
                    label: 'Transfer',
                    size: 50,
                  ),
                  ABAMenuButton(
                    icon: Icons.qr_code,
                    label: 'Scan QR',
                    size: 50,
                  ),
                  ABAMenuButton(
                    icon: Icons.attach_money,
                    label: 'Loans',
                    size: 50,
                  ),
                  ABAMenuButton(
                    icon: Icons.location_on_sharp,
                    label: 'Locator',
                    size: 50,
                  ),
                ],
              ),
            ),
          ),
          Flexible(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.only(left: 20.0),
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Quick Transfer',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'Create your templates here to make transfer\nquicker',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      right: -40,
                        bottom: -40,
                        child: Icon(
                      Icons.circle,
                      color: Colors.white.withOpacity(0.5),
                      size: 130,
                    )),
                    Positioned(
                        right: -1,
                        bottom: -1,
                        child: Icon(
                          CupertinoIcons.repeat,
                          color: Color(0xFF00BCD5).withOpacity(0.8),
                          size: 60,
                        )),
                  ],
                ),
                color: Color(0xFF00BCD5),
              )),
          Flexible(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.only(left: 20.0),
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Quick Payment',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'Paying your bill with templates in faster',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                        right: -40,
                        bottom: -40,
                        child: Icon(
                          Icons.circle,
                          color: Colors.white.withOpacity(0.5),
                          size: 130,
                        )),
                    Positioned(
                        right: -3,
                        bottom: -3,
                        child: Icon(
                          CupertinoIcons.money_dollar,
                          color: Color(0xFFEE534F).withOpacity(0.8),
                          size: 70,
                        )),
                  ],
                ),
                color: Color(0xFFEE534F),
              )),
        ],
      ),
    );
  }
}
