import 'package:flutter/material.dart';
import 'package:new_project/src/screens/login.dart';
class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.orange),
      ),
      home: LoginScreen(),
    );
  }
}
