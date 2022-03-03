import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:xiaoming/colors/company_colors.dart';
import 'package:xiaoming/views/personal_info/new_personal_info_page.dart';
import 'controllers/initial_binding.dart';
import 'language/khmer_cupertino_localization_delegate.dart';
import 'services/localization_service.dart';
import 'views/landing_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: CompanyColors.blue,
    systemNavigationBarColor: CompanyColors.blue,
    statusBarIconBrightness: Brightness.light,
  ));

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    LocalizationService().getLocale();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'MPTC HR App',
      locale: LocalizationService.locale,
      fallbackLocale: LocalizationService.fallbackLocale,
      translations: LocalizationService(),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        DefaultMaterialLocalizations.delegate,
        KhmerCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('km'),
      ],

      initialBinding: InitialBinding(),

      theme: ThemeData(
        // primaryColor: CompanyColors.blue,
        primarySwatch: CompanyColors.blue,
        fontFamily: 'KhmerOSBattambong',
        textTheme: const TextTheme(
          bodyText1: TextStyle(fontSize: 16),
        ),
        hintColor: Colors.grey[400],
        appBarTheme: const AppBarTheme(
          color: Color(0xFF003D7C),
          elevation: 0,
        ),
        iconTheme: IconThemeData(color: CompanyColors.yellow),
        // colorScheme: const ColorScheme(
        //   primary: Color(0xFF003D7C),
        //   primaryVariant: Color(0xFF003D7C),
        //   secondary: Color(0xFFF07C08),
        //   secondaryVariant: Color(0xFFF07C08),
        //   background: Colors.white,
        //   brightness: Brightness.light,
        //   error: Colors.red,
        //   onBackground: Colors.white,
        //   onError: Colors.white,
        //   onPrimary: Colors.white,
        //   onSecondary: Colors.white,
        //   onSurface: Colors.white,
        //   surface: Colors.white,
        // ),
      ),
      home: const LandingPage(),
      // home: NewPersonalInfoPage(),
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
