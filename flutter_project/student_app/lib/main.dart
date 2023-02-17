import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_app/providers/user_provider.dart';
import 'package:student_app/responsive/mobile_screen_layout.dart';
import 'package:student_app/responsive/responsive_layout_scren.dart';
import 'package:student_app/responsive/web_screen_layout.dart';
import 'package:student_app/screens/login_screen.dart';
import 'package:student_app/utils/colors.dart';

void main() async { // for web
  WidgetsFlutterBinding
      .ensureInitialized(); // ensure flutter widgets initialize
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyDtmILw78waXsm9TJ-I1--DFogAqtPzbb8",
          // authDomain: "student-app-f92c2.firebaseapp.com",
          projectId: "student-app-f92c2",
          storageBucket: "student-app-f92c2.appspot.com",
          messagingSenderId: "284267415707",
          appId: "1:284267415707:web:468aee26bc96bdd5bade3e"
      ),
    );
  } else { // for mobile
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Student app',
        theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: primaryColor,
        ),
        // home: const ResponsiveLayout(
        //   mobileScreenLayout: MobileScreenLayout(),
        //   webScreenLayout: WebScreenLayout(),
        // ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(), // when state change sign in in app or sign out in app
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.active) {
              if(snapshot.hasData) { // user is authenticated.
                return const ResponsiveLayout(
                  mobileScreenLayout: MobileScreenLayout(),
                  webScreenLayout: WebScreenLayout(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'), // some internal error occured
                );
              }
            }
            if(snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            }
            return const LoginScreen(); // snapshot has no data regarding user is loged in.
          },
        ),
      ),
    );
  }
}

