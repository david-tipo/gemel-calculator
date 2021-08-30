import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/tabs_screen.dart';
import 'screens/about_screen.dart';
import 'screens/terms_of_use_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  //makes the app only portrait ^^
  return runApp(Calculator());
}

class Calculator extends StatelessWidget {
  static const primaryColor = const Color(0xff32cd32);
  static const accentColor = const Color(0xff343232);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        return Directionality(
          // makes the whole app rtl
          textDirection: TextDirection.rtl,
          child: child,
        );
      },
      theme: ThemeData(
        primaryColor: primaryColor,
        accentColor: accentColor,
        primaryTextTheme: ThemeData
            .light()
            .primaryTextTheme
            .copyWith(
          headline6: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 40,
            fontFamily: 'Rubik',
          ),
          subtitle2: TextStyle(
            fontFamily: 'MiriamLibre',
            fontSize: 20,
          ),
          bodyText1: TextStyle(
            fontFamily: 'Alef',
            fontSize: 16,
            height: 1.8,
          ),
          subtitle1: TextStyle(
            fontSize: 30,
            fontFamily: 'Rubik',
            fontWeight: FontWeight.w500,
            letterSpacing: 1.5,
          ),
        ),
        primaryIconTheme: IconThemeData(color: Colors.white),
        appBarTheme: AppBarTheme(
          centerTitle: true,
        ),
      ),
      routes: {
        '/': (context) => TabsScreen(), // home page
        AboutScreen.pageName: (context) => AboutScreen(),
        TermsOfUseScreen.pageName: (context) => TermsOfUseScreen(),
      },
    );
  }
}
