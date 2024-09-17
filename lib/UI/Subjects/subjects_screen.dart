import 'dart:developer';

import 'package:feedback_app/UI/Home/home_screen.dart';
import 'package:feedback_app/UI/core/constants.dart';
import 'package:feedback_app/UI/widgets/loading.dart';
import 'package:feedback_app/backend/auth/auth.dart';
import 'package:feedback_app/backend/data_fetching/model/subject_model.dart';
import 'package:feedback_app/backend/data_fetching/service/data_fetch.dart';
import 'package:feedback_app/backend/database/database.dart';
import 'package:feedback_app/backend/model/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SreenSubjects extends StatelessWidget {
  SreenSubjects({super.key, required this.semDoc, required this.course});

  final String semDoc;
  final String course;

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user!.uid).fdb,
        builder: (context, snapshot) {
          UserData? uData = snapshot.data;

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
                  ElevatedButton.icon(
                      onPressed: () async {
                        await _auth.signOut();
                      },
                      icon: const Icon(Icons.logout),
                      label: const Text("Log out"))
                ],
              ),
              body: StreamBuilder<SubjectModel>(
                  stream: DataFetch(doc: semDoc, course: course).getSub(course),
                  builder: (context, snapshot) {
                    SubjectModel? sub = snapshot.data;
                    List<String>? subList = sub?.getSubjectsList();
                    log(subList.toString());
                    return snapshot.hasData
                        ? Column(
                            children: [
                              const Text(
                                "Please select a subject ",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
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
                                              child: subList![index] != "null"
                                                  ? ElevatedButton(
                                                      style: const ButtonStyle(
                                                          backgroundColor:
                                                              WidgetStatePropertyAll(
                                                                  kPrimary),
                                                          foregroundColor:
                                                              WidgetStatePropertyAll(
                                                                  Colors
                                                                      .white)),
                                                      onPressed: () {
                                                        Navigator.of(context).push(
                                                            MaterialPageRoute(
                                                                builder: (context) => HomeScreen(
                                                                    course:
                                                                        course,
                                                                    subjects:
                                                                        sub,
                                                                    sub: subList[
                                                                        index])));
                                                      },
                                                      child:
                                                          Text(subList[index]))
                                                  : null),
                                        ),
                                      );
                                    },
                                    itemCount: subList?.length,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : const Loading();
                  }),
            );
          } else {
            return const Loading();
          }
        });
  }
}
