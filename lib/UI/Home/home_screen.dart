// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
import 'dart:developer';

import 'package:feedback_app/UI/Message/already_submitted.dart';
import 'package:feedback_app/UI/Message/responses_completed.dart';
import 'package:feedback_app/UI/successfull/successfull_screen.dart';
import 'package:feedback_app/UI/widgets/loading.dart';
import 'package:feedback_app/backend/auth/auth.dart';
import 'package:feedback_app/backend/data_fetching/model/subject_model.dart';
import 'package:feedback_app/backend/data_fetching/service/data_fetch.dart';
import 'package:feedback_app/backend/database/database.dart';
import 'package:feedback_app/backend/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen(
      {super.key,
      required this.sub,
      required this.subjects,
      required this.course});

  final String sub;
  final String course;
  final SubjectModel? subjects;

  final AuthService _auth = AuthService();
  final List<String> questions = [
    "Teacher comes to class on time",
    "Teacher makes objectives clear",
    "Subject matter organized in logical sequence",
    "Teacher comes well prepared in the subject",
    "Teacher speaks clearly and audibly",
    "Teaching is well planned",
    "Teacher writes and draws legibly",
    "Teacher explains with examples clearly",
    "Teaching pace is good; Not very fast",
    "Teachers offers assistance and counselling",
    "Teacher asks relevant questions for interaction",
    "Teacher encourages raising doubts",
    "Teacher ensures learning of subject",
    "Teacher encourages originality and creativity",
    "Teacher is courteous and impartial",
    "Teacher is regular and maintains discipline",
    "Teacher holds quizzes, seminars regularly",
    "Teacher correction of scripts fair and impartial",
    "Teacher promptly values and returns papers",
  ];
  final String name = '';
  final ValueNotifier<bool> isFinshed = ValueNotifier(false);
  final List<int> rate = [
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0
  ];
  final ValueNotifier<List<String>> emoji = ValueNotifier([
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    ""
  ]);

  @override
  Widget build(BuildContext context) {
    int currentIndex;
    final user = Provider.of<UserModel?>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user!.uid).fdb,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData? uData = snapshot.data;

            return StreamBuilder<UserData>(
              stream: DatabaseService(uid: user.uid).fdbSub(sub),
              builder: (context, snapshot) {
                log(isFinshed.value.toString());
                UserData? subUdata = snapshot.data;
                if (subUdata?.isSubmitted == 'true' &&
                    isFinshed.value == false) {
                  return const AlreadySubmitted();
                } else {
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
                    body: SafeArea(
                      child: ListView.separated(
                        itemBuilder: ((context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: const [
                                  BoxShadow(
                                      offset: Offset(0, 1),
                                      blurRadius: 10,
                                      blurStyle: BlurStyle.outer,
                                      color: Colors.grey)
                                ],
                                color: Colors.white,
                              ),
                              height: 200,
                              width: double.infinity,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Center(
                                      child: Text(
                                        questions[index],
                                        style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                  ValueListenableBuilder(
                                    valueListenable: emoji,
                                    builder: (context, value, child) {
                                      return Text(
                                        emoji.value[index],
                                        style: const TextStyle(fontSize: 40),
                                      );
                                    },
                                  ),
                                  RatingBar.builder(
                                      initialRating: 0,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      itemCount: 5,
                                      itemPadding: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                      itemBuilder: ((context, index) {
                                        return const Icon(
                                          Icons.star_border,
                                          color: Colors.yellow,
                                        );
                                      }),
                                      onRatingUpdate: (rating) {
                                        switch (rating.toInt()) {
                                          case 1:
                                            emoji.value[index] = "😞";

                                            emoji.notifyListeners();

                                            break;
                                          case 2:
                                            emoji.value[index] = "😐";
                                            emoji.notifyListeners();
                                            break;
                                          case 3:
                                            emoji.value[index] = "🙂";
                                            emoji.notifyListeners();
                                            break;
                                          case 4:
                                            emoji.value[index] = "😊";
                                            emoji.notifyListeners();
                                            break;
                                          case 5:
                                            emoji.value[index] = "😃";
                                            emoji.notifyListeners();
                                            break;
                                          default:
                                            emoji.value[index] = "";
                                            emoji.notifyListeners();
                                        }
                                        rate[index] = rating.toInt();
                                      })
                                ],
                              ),
                            ),
                          );
                        }),
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 20,
                          );
                        },
                        itemCount: questions.length,
                      ),
                    ),
                    floatingActionButton: SizedBox(
                      height: 50,
                      width: 120,
                      child: ElevatedButton(
                          onPressed: () async {
                            isFinshed.value = true;
                            log(isFinshed.value.toString());
                            int strength =
                                await DataFetch(doc: 'profile', course: course)
                                    .getCourseData();
                            try {
                              currentIndex =
                                  await DatabaseService(uid: user.uid)
                                      .getSubDetails(sub);
                            } catch (e) {
                              currentIndex = 0;
                            }

                            if (strength == currentIndex) {
                              log('Full');
                              if (!context.mounted) return;
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (context) {
                                return const ResponsesCompleted();
                              }));
                            } else {
                              await DatabaseService(uid: user.uid)
                                  .updateUserData(
                                'true',
                                sub,
                                uData.name,
                                uData.branch,
                                uData.regNo,
                                rate[0],
                                rate[1],
                                rate[2],
                                rate[3],
                                rate[4],
                                rate[5],
                                rate[6],
                                rate[7],
                                rate[8],
                                rate[9],
                                rate[10],
                                rate[11],
                                rate[12],
                                rate[13],
                                rate[14],
                                rate[15],
                                rate[16],
                                rate[17],
                                rate[18],
                                rate[19],
                              );
                              await DatabaseService(uid: user.uid)
                                  .updateUserData(
                                'true',
                                'students',
                                uData.name,
                                uData.branch,
                                uData.regNo,
                                0,
                                0,
                                0,
                                0,
                                0,
                                0,
                                0,
                                0,
                                0,
                                0,
                                0,
                                0,
                                0,
                                0,
                                0,
                                0,
                                0,
                                0,
                                0,
                                0,
                              );
                              log(currentIndex.toString());
                              await DatabaseService(uid: user.uid)
                                  .setSubDetails(sub, currentIndex + 1);
                              if (!context.mounted) return;

                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (context) {
                                return const SuccessfullScreen();
                              }));
                            }
                          },
                          child: const Text(
                            "Submit",
                            style: TextStyle(fontSize: 20),
                          )),
                    ),
                  );
                }
              },
            );
          } else {
            return const Loading();
          }
        });
  }
}
