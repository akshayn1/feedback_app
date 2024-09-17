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

  Future getCourseData() async {
    final DocumentReference courseDetails =
        FirebaseFirestore.instance.collection(course).doc('profile');
    DocumentSnapshot snapshot = await courseDetails.get();

    int strength = snapshot.get('strength');

    return strength;
  }

  Future updateCourseData(
    int cStatus,
    int strength,
  ) async {
    final CollectionReference courseDetails =
        FirebaseFirestore.instance.collection(course);

    return await courseDetails.doc('profile').set({
      'currentStatus': cStatus,
      'strength': strength,
    });
  }
}
