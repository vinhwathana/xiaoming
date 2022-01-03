import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:xiaoming/colors/company_colors.dart';
import 'package:xiaoming/views/login_page.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: CompanyColors.blue,
      statusBarIconBrightness: Brightness.dark));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // late Map<int, Color> color = {
  //   50: Color.fromRGBO(51, 153, 255, .1),
  //   100: Color.fromRGBO(51, 153, 255, .2),
  //   200: Color.fromRGBO(51, 153, 255, .3),
  //   300: Color.fromRGBO(51, 153, 255, .4),
  //   400: Color.fromRGBO(51, 153, 255, .5),
  //   500: Color.fromRGBO(51, 153, 255, .6),
  //   600: Color.fromRGBO(51, 153, 255, .7),
  //   700: Color.fromRGBO(51, 153, 255, .8),
  //   800: Color.fromRGBO(51, 153, 255, .9),
  //   900: Color.fromRGBO(51, 153, 255, 1),
  // };

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'MPTC Officials information system',
      localizationsDelegates: const [
        DefaultMaterialLocalizations.delegate,
      ],
      // initialBinding: InitialBinding(),
      theme: ThemeData(
        primaryColor: const Color(0xFF003D7C),
        accentColor: const Color(0xFF003D7C),
        // accentColor: Color(0xFFF07C08),
        fontFamily: 'KhmerOSBattambong',
        textTheme: const TextTheme(
          bodyText1: TextStyle(fontSize: 16),
        ),
        hintColor: Colors.grey[400],
        appBarTheme: const AppBarTheme(
          color: Color(0xFF003D7C),
          elevation: 0,
        ),
        colorScheme: const ColorScheme(
          primary: Color(0xFF003D7C),
          primaryVariant: Color(0xFF003D7C),
          secondary: Color(0xFFF07C08),
          secondaryVariant: Color(0xFFF07C08),
          background: Colors.white,
          brightness: Brightness.light,
          error: Colors.red,
          onBackground: Colors.white,
          onError: Colors.white,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: Colors.white,
          surface: Colors.white,
        ),
      ),
      home: LoginPage(),
      // initialRoute: '/',
      // routes: {
      //   '/': (context) => ProtectedRoute(
      //     child: HomePage(),
      //   ),
      //   '/auth': (context) => const AuthenticationPage(),
      //   '/attendance/scan': (context) => ProtectedRoute(
      //     child: AttendancePage(),
      //   ),
      //   '/attendance/daily': (context) => ProtectedRoute(
      //     child: AttendancePage(),
      //   ),
      //   '/user-profile': (context) => ProtectedRoute(
      //     child: UserPage(),
      //   ),
      // },
    );
  }
}
