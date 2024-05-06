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
        apiKey: "AIzaSyDaIDQjoFRVamnGCK5rN_fh68Oa4-MOVgQ",
        authDomain: "fir-project-55915.firebaseapp.com",
        projectId: "fir-project-55915",
        storageBucket: "fir-project-55915.appspot.com",
        messagingSenderId: "1055560479514",
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
          home: Wrapper()),
    );
  }
}
