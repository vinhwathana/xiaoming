import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:xiaoming/colors/company_colors.dart';
import 'package:xiaoming/views/home_page.dart';
import 'package:xiaoming/views/id_card/id_card_page.dart';
import 'package:xiaoming/views/landing_page2.dart';
import 'controllers/initial_binding.dart';
import 'language/khmer_cupertino_localization_delegate.dart';
import 'services/localization_service.dart';
import 'views/landing_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: CompanyColors.blue,
      systemNavigationBarColor: CompanyColors.blue,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

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
      key: widget.key,
      title: 'MPTC HR App Dev',
      locale: LocalizationService.locale,
      fallbackLocale: LocalizationService.fallbackLocale,
      translations: LocalizationService(),
      localizationsDelegates: const [
        ...GlobalMaterialLocalizations.delegates,
        GlobalWidgetsLocalizations.delegate,
        DefaultMaterialLocalizations.delegate,
        KhmerCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('km'),
      ],
      initialBinding: InitialBinding(),
      defaultTransition: Transition.cupertino,
      theme: ThemeData(
        primarySwatch: CompanyColors.blue,
        fontFamily: 'KhmerMPTC',
        textTheme: const TextTheme(
          bodyText1: TextStyle(fontSize: 16),
        ),
        hintColor: Colors.grey[400],
        appBarTheme: const AppBarTheme(
          color: Color(0xFF003D7C),
          elevation: 0,
        ),
        iconTheme: IconThemeData(color: CompanyColors.yellow),
        // pageTransitionsTheme: const PageTransitionsTheme(
        //   builders: {
        //     TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        //     TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        //   },
        // ),
      ),
      themeMode: ThemeMode.light,
      // home: IdCardPage(),
      home: const LandingPage(),
    );
  }
}
