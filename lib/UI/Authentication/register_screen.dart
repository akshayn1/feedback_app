import 'package:feedback_app/UI/core/constants.dart';
import 'package:feedback_app/UI/widgets/loading.dart';
import 'package:feedback_app/backend/auth/auth.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key, required this.toggleView});
  final Function toggleView;
  ValueNotifier<String> email = ValueNotifier<String>('');
  ValueNotifier<String> error = ValueNotifier<String>('');
  ValueNotifier<String> name = ValueNotifier<String>('');
  ValueNotifier<String> registerNum = ValueNotifier<String>('');
  ValueNotifier<String> branch = ValueNotifier<String>('');
  ValueNotifier<String> password = ValueNotifier<String>('');
  ValueNotifier<String> password2 = ValueNotifier<String>('');
  ValueNotifier<String> dropValue = ValueNotifier<String>('Branch');
  ValueNotifier<bool> loading = ValueNotifier<bool>(false);

  final AuthService _auth = AuthService();
  final branchList = [
    'Branch',
    'Computer Science',
    'Mechanical',
    'Aeronautical',
    'Civil',
    'Electronics And Communication',
    'Agricultural',
    'Cybersecurity',
    'Data Science',
  ];
  bool isEmailValid(String email) {
    // Basic email validation using regex
    // You can implement more complex validation if needed
    return RegExp(r'^[\w-\.]+@[a-zA-Z]+\.[a-zA-Z]{2,}$').hasMatch(email);
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return loading.value
        ? const Loading()
        : Scaffold(
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
                padding: const EdgeInsets.all(18.0),
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
                    height: 700,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            ValueListenableBuilder(
                              valueListenable: name,
                              builder: (context, value, child) {
                                return TextFormField(
                                  validator: (value) =>
                                      value!.isEmpty ? 'Enter a Name' : null,
                                  onChanged: (value) {
                                    name.value = value;
                                  },
                                  decoration: const InputDecoration(
                                      prefixIcon: Icon(Icons.person),
                                      border: OutlineInputBorder(),
                                      hintText: "Full Name"),
                                );
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
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
                              valueListenable: registerNum,
                              builder: (context, value, child) {
                                return TextFormField(
                                  validator: (value) => value!.isEmpty
                                      ? 'Please Enter your register number'
                                      : null,
                                  onChanged: (value) {
                                    registerNum.value = value;
                                  },
                                  decoration: const InputDecoration(
                                      prefixIcon: Icon(Icons.app_registration),
                                      border: OutlineInputBorder(),
                                      hintText: "Register Number"),
                                );
                              },
                            ),
                            ValueListenableBuilder(
                              valueListenable: dropValue,
                              builder: (context, value, child) {
                                return Container(
                                  width: 300,
                                  child: DropdownButtonFormField(
                                      isExpanded: true,
                                      value: dropValue.value,
                                      items:
                                          branchList.map((String branchList) {
                                        return DropdownMenuItem(
                                            value: branchList,
                                            child: Text(branchList));
                                      }).toList(),
                                      onChanged: (value) {
                                        dropValue.value = value.toString();
                                      }),
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
                                  obscureText: true,
                                  obscuringCharacter: "*",
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
                              height: 20,
                            ),
                            ValueListenableBuilder(
                              valueListenable: password,
                              builder: (context, value, child) {
                                return TextFormField(
                                  obscureText: true,
                                  obscuringCharacter: "*",
                                  validator: (value) => password.value != value
                                      ? 'Password does not match'
                                      : null,
                                  onChanged: (value) {},
                                  decoration: const InputDecoration(
                                      prefixIcon: Icon(Icons.lock),
                                      border: OutlineInputBorder(),
                                      hintText: "Re-Type Password"),
                                );
                              },
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            SizedBox(
                              height: 50,
                              width: 140,
                              child: ValueListenableBuilder(
                                valueListenable: loading,
                                builder: (context, value, child) {
                                  return ElevatedButton(
                                      style: const ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll<Color>(
                                                kPrimary),
                                      ),
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          loading.value = true;
                                          dynamic result = await _auth
                                              .registerWithEmailAndPassword(
                                                  email.value,
                                                  password.value,
                                                  name.value,
                                                  registerNum.value,
                                                  dropValue.value);
                                          print(result);
                                          if (result == null) {
                                            error.value =
                                                'please supply valid email';
                                            loading.value = false;
                                          }
                                        }
                                      },
                                      child: const Text(
                                        "Register",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ));
                                },
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Already User?"),
                                TextButton(
                                    onPressed: () {
                                      toggleView();
                                    },
                                    child: const Text("Click Here"))
                              ],
                            ),
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
