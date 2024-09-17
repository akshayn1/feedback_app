import 'dart:developer';

import 'package:feedback_app/UI/Subjects/subjects_screen.dart';
import 'package:feedback_app/UI/core/constants.dart';
import 'package:feedback_app/UI/widgets/loading.dart';
import 'package:feedback_app/backend/auth/auth.dart';
import 'package:feedback_app/backend/database/database.dart';
import 'package:feedback_app/backend/model/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SemesterScreen extends StatelessWidget {
  SemesterScreen({super.key});

  final AuthService _auth = AuthService();

  final List<String> semester = [
    's1',
    's2',
    's3',
    's4',
    's5',
    's6',
    's7',
    's8'
  ];

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user!.uid).fdb,
        builder: (context, snapshot) {
          UserData? uData = snapshot.data;
          // log(uData!.branch);

          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                flexibleSpace: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                          child: Text(
                        "Hi, ${uData!.name}",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                    ],
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton.icon(
                        style: const ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(kPrimary),
                            foregroundColor:
                                WidgetStatePropertyAll(Colors.white)),
                        onPressed: () async {
                          await _auth.signOut();
                        },
                        icon: const Icon(Icons.logout),
                        label: const Text(
                          "Log out",
                        )),
                  )
                ],
              ),
              body: Column(
                children: [
                  const Text(
                    "Please Select your Semester ",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: SizedBox(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              child: SizedBox(
                                height: 50,
                                width: 50,
                                child: ElevatedButton(
                                    style: const ButtonStyle(
                                        backgroundColor:
                                            WidgetStatePropertyAll(kPrimary),
                                        foregroundColor: WidgetStatePropertyAll(
                                            Colors.white)),
                                    onPressed: () {
                                      log(semester[index]);
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SreenSubjects(
                                                      semDoc: semester[index],
                                                      course: uData.branch)));
                                    },
                                    child: Text(semester[index].toUpperCase())),
                              ),
                            ),
                          );
                        },
                        itemCount: semester.length,
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Loading();
          }
        });
  }
}
