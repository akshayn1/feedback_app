import 'package:cloud_firestore/cloud_firestore.dart';

class AdminService {
  Future getSubDetails() async {
    final DocumentReference adminDetails =
        FirebaseFirestore.instance.collection('Admin').doc('userControl');
    DocumentSnapshot snapshot = await adminDetails.get();

    int cIndex = snapshot.get('allow');

    return cIndex;
  }
}
