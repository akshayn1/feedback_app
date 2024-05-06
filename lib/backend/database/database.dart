import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feedback_app/backend/model/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});
  //collection refrence
  final CollectionReference fdbCollection =
      FirebaseFirestore.instance.collection('feedbacks');

  //
  Future updateUserData(
    String name,
    String cls,
    String regNo,
    int q1,
    int q2,
    int q3,
    int q4,
    int q5,
    int q6,
    int q7,
    int q8,
    int q9,
    int q10,
    int q11,
    int q12,
    int q13,
    int q14,
    int q15,
    int q16,
    int q17,
    int q18,
    int q19,
    int q20,
  ) async {
    return await fdbCollection.doc(uid).set({
      'name': name,
      'branch': cls,
      'registerNumber': regNo,
      'q1': q1,
      'q2': q2,
      'q3': q3,
      'q4': q4,
      'q5': q5,
      'q6': q6,
      'q7': q7,
      'q8': q8,
      'q9': q9,
      'q10': q10,
      'q11': q11,
      'q12': q12,
      'q13': q13,
      'q14': q14,
      'q15': q15,
      'q16': q16,
      'q17': q17,
      'q18': q18,
      'q19': q19,
      'q20': q20
    });
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid,
      snapshot['name'],
      snapshot['registerNumber'],
      snapshot['branch'],
      snapshot['q1'],
      snapshot['q2'],
      snapshot['q3'],
      snapshot['q4'],
      snapshot['q5'],
      snapshot['q6'],
      snapshot['q7'],
      snapshot['q8'],
      snapshot['q9'],
      snapshot['q10'],
      snapshot['q11'],
      snapshot['q12'],
      snapshot['q13'],
      snapshot['q14'],
      snapshot['q15'],
      snapshot['q16'],
      snapshot['q17'],
      snapshot['q18'],
      snapshot['q19'],
      snapshot['q20'],
    );
  }

  // get streams
  Stream<UserData> get fdb {
    return fdbCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
