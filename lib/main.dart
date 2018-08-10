import 'package:flutter/material.dart';
import 'package:initiativetracker/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  SharedPreferences _prefs;
  Brightness _brightness;

  @override
  void initState() {
    super.initState();
    _initBrightness();
  }

  void _initBrightness() async {
    _prefs = await SharedPreferences.getInstance();
    _brightness = (_prefs.getBool("isDark") ?? false)
        ? Brightness.dark
        : Brightness.light;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Initiative tracker',
      locale: const Locale('en'),
      supportedLocales: const <Locale>[const Locale('en')],
      home: HomePage(
        onThemeToggled: () {
          _toggleTheme();
          _prefs.setBool("isDark", _brightness == Brightness.dark);
        }
      ),
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        brightness: _brightness
      ),
    );
  }

  void _toggleTheme() {
    setState(() {
      if (_brightness == Brightness.light) {
        _brightness = Brightness.dark;
      } else {
        _brightness = Brightness.light;
      }
    });
  }
}
