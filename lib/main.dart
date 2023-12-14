// import 'package:expense_tracker/model/expense/expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/myhomepage.dart';
import 'package:flutter/services.dart';

var kColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 16, 51, 147));
var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 209, 207, 207),
);
void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  // ]).then((fun) {
  runApp(const MyApp());
  // });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: kDarkColorScheme,
      ),
      theme: ThemeData().copyWith(
        useMaterial3: true,
        // scaffoldBackgroundColor: const Color.fromARGB(255, 45, 40, 41),
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer,
        ),
        cardTheme: const CardTheme().copyWith(
          color: kDarkColorScheme.onSecondaryContainer,
          margin: const EdgeInsets.all(5),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: kColorScheme.primaryContainer),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: const TextStyle(
                  fontWeight: FontWeight.normal,
                  // color: Color.fromARGB(0, 255, 255, 255),
                  fontSize: 20),
            ),
      ),
      themeMode: ThemeMode.system,
      title: 'Flutter Demo',
      home: const MyHomePage(title: 'Expense Tracker'),
    );
  }
}
