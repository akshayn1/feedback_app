import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feedback_app/backend/data_fetching/model/subject_model.dart';

class DataFetch {
  final String doc;
  final String course;
  DataFetch({required this.doc, required this.course});

  Stream<SubjectModel> getSub(String course) {
    final CollectionReference fdbCollection =
        FirebaseFirestore.instance.collection(course);
    log(' Data fetch cou : $course');
    log(' Data fetch doc : $doc');

    SubjectModel subDataFromSnapshot(DocumentSnapshot snapshot) {
      return SubjectModel(
          currentStatus: snapshot['currentStatus'],
          strength: snapshot['strength'],
          sub1: snapshot['sub1'],
          sub2: snapshot['sub2'],
          sub3: snapshot['sub3'],
          sub4: snapshot['sub4'],
          sub5: snapshot['sub5'],
          sub6: snapshot['sub6'],
          sub7: snapshot['sub7'],
          sub8: snapshot['sub8'],
          sub9: snapshot['sub9']);
    }

    return fdbCollection.doc(doc).snapshots().map(subDataFromSnapshot);
  }

  Future updateCourseData(
    String cStatus,
    String strength,
    String sub1,
    String sub2,
    String sub3,
    String sub4,
    String sub5,
    String sub6,
    String sub7,
    String sub8,
    String sub9,
  ) async {
    final CollectionReference courseDetails =
        FirebaseFirestore.instance.collection(course);

    return await courseDetails.doc(doc).set({
      'currentStatus': cStatus,
      'strength': strength,
      'sub1': sub1,
      'sub2': sub1,
      'sub3': sub1,
      'sub4': sub1,
      'sub5': sub1,
      'sub6': sub1,
      'sub7': sub1,
      'sub8': sub1,
      'sub9': sub1
    });
  }
}
