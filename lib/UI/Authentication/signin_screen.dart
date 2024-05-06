import 'package:feedback_app/UI/core/constants.dart';
import 'package:feedback_app/UI/widgets/loading.dart';
import 'package:feedback_app/backend/auth/auth.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key, required this.toggleView});

  final Function toggleView;
  ValueNotifier<String> email = ValueNotifier<String>('');
  ValueNotifier<String> password = ValueNotifier<String>('');
  ValueNotifier<String> error = ValueNotifier<String>('');
  ValueNotifier<bool> loading = ValueNotifier<bool>(false);
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  bool isEmailValid(String email) {
    // Basic email validation using regex
    // You can implement more complex validation if needed
    return RegExp(r'^[\w-\.]+@[a-zA-Z]+\.[a-zA-Z]{2,}$').hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    if (loading.value) {
      return const Loading();
    } else {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("Assets/Image/bg.png"),
                fit: BoxFit.cover,
                opacity: 0.7),
          ),
          child: Padding(
            padding: const EdgeInsets.all(19.0),
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    // border: Border.all(width: 5, color: kPrimary),
                    boxShadow: const [
                      BoxShadow(
                          offset: Offset(0, 1),
                          color: Colors.grey,
                          spreadRadius: 2,
                          blurRadius: 10)
                    ]),
                height: 400,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        ValueListenableBuilder(
                          valueListenable: email,
                          builder: (context, value, child) {
                            return TextFormField(
                              validator: (value) => !isEmailValid(value!)
                                  ? 'Enter an valid email'
                                  : null,
                              onChanged: (value) {
                                email.value = value;
                              },
                              decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.mail),
                                  border: OutlineInputBorder(),
                                  hintText: "Email"),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ValueListenableBuilder(
                          valueListenable: password,
                          builder: (context, value, child) {
                            return TextFormField(
                              validator: (value) => value!.length < 6
                                  ? 'Enter atleast 6+ characters'
                                  : null,
                              onChanged: (value) {
                                password.value = value;
                              },
                              decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.lock),
                                  border: OutlineInputBorder(),
                                  hintText: "Password"),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          height: 50,
                          width: 140,
                          child: ElevatedButton(
                              style: const ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(kPrimary),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  loading.value = true;
                                  dynamic result =
                                      await _auth.siginInWithEmailAndPassword(
                                          email.value, password.value);
                                  if (result == null) {
                                    error.value =
                                        'Something trouble with email and password';
                                    loading.value = false;
                                  } else {
                                    error.value = "";
                                  }
                                }
                              },
                              child: const Text(
                                "SignIn",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              )),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("New User?"),
                            TextButton(
                                onPressed: () {
                                  toggleView();
                                },
                                child: const Text("Click Here"))
                          ],
                        ),
                        ValueListenableBuilder(
                          valueListenable: error,
                          builder: (context, value, child) {
                            return Text(
                              error.value,
                              style: const TextStyle(color: Colors.red),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        )),
      );
    }
  }
}
