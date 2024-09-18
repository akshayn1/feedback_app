import 'package:feedback_app/UI/wrapper.dart';
import 'package:feedback_app/backend/auth/auth.dart';
import 'package:feedback_app/backend/model/user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyDWPg9Zp7OW1ycwOmtldaYLEwFL1HC-vow",
        authDomain: "feedback-app-a3209.firebaseapp.com",
        projectId: "feedback-app-a3209",
        storageBucket: "feedback-app-a3209.appspot.com",
        messagingSenderId: "991465783681",
        appId: "1:1055560479514:android:d484c4ecb05a12cd1e32a3"),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserModel?>.value(
      catchError: (_, __) => null,
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Feedback',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const Wrapper()),
    );
  }
}
