import 'package:feedback_app/UI/Authentication/authenticate.dart';
import 'package:feedback_app/UI/Subjects/semester_screen.dart';
import 'package:feedback_app/backend/model/user.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    //return either home or authenticate widget
    final user = Provider.of<UserModel?>(context);
    if (user == null) {
      return const Authenticate();
    } else {
      return SemesterScreen();
    }
  }
}
