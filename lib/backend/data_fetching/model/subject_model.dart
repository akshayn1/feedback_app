class SubjectModel {
  final String currentStatus;
  final String strength;
  final String sub1;
  final String sub2;
  final String sub3;
  final String sub4;
  final String sub5;
  final String sub6;
  final String sub7;
  final String sub8;
  final String sub9;

  SubjectModel(
      {required this.currentStatus,
      required this.strength,
      required this.sub1,
      required this.sub2,
      required this.sub3,
      required this.sub4,
      required this.sub5,
      required this.sub6,
      required this.sub7,
      required this.sub8,
      required this.sub9});

  List<String> getSubjectsList() {
    return [
      currentStatus,
      strength,
      sub1,
      sub2,
      sub3,
      sub4,
      sub5,
      sub6,
      sub7,
      sub8,
      sub9
    ];
  }
}
