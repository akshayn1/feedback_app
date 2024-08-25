import 'package:feedback_app/UI/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SuccessfullScreen extends StatelessWidget {
  const SuccessfullScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              const Center(
                child: SizedBox(
                    width: 300,
                    height: 300,
                    child: Image(
                        image:
                            AssetImage("Assets/Image/successful_emoji.png"))),
              ),
              const Text(
                "Responses submitted Successfully.",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const Text(
                "Thank you for your time.",
                textAlign: TextAlign.start,
              ),
              const SizedBox(
                height: 150,
              ),
              SizedBox(
                height: 50,
                width: 150,
                child: ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(kPrimary),
                        foregroundColor:
                            MaterialStatePropertyAll(Colors.white)),
                    onPressed: () {
                      SystemNavigator.pop();
                    },
                    child:
                        const Text("Exit App", style: TextStyle(fontSize: 18))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
