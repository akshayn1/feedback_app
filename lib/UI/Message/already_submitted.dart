import 'package:feedback_app/UI/core/constants.dart';
import 'package:feedback_app/backend/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AlreadySubmitted extends StatelessWidget {
  const AlreadySubmitted({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthService auth = AuthService();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "You have already submitted your responses in this subject",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
            ),
            const Image(
              image: AssetImage("Assets/Image/already.png"),
              width: 270,
              height: 300,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 40,
                ),
                Text(
                  "Note :",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                ),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "● If you haven't submitted, please kindly \nask your faculty to resolve the issue.",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 150,
              height: 50,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.arrow_back),
                style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(kPrimary),
                    foregroundColor: WidgetStatePropertyAll(Colors.white)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                label: const Text(
                  "Go Back",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
