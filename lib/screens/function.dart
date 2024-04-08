import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_board_mopidati/screens/Reports.dart';

Future<QuerySnapshot<Map<String, dynamic>>?>? initData() async {
  // استعلام لجلب جميع التقارير
  QuerySnapshot<Map<String, dynamic>> reportsSnapshot =
      await FirebaseFirestore.instance.collection("Reports").get();

  // التكرار عبر كل تقرير للحصول على id user
  for (var report in reportsSnapshot.docs) {
    var userId = report.data()["idUser"];

    // استعلام لجلب المستخدم بناءً على iduser
    DocumentSnapshot<Map<String, dynamic>> userSnapshot =
        await FirebaseFirestore.instance.collection("users").doc(userId).get();

    // التحقق إذا كان الوثيقة موجودة وبعدها طباعة الاسم
    if (userSnapshot.exists) {
      var userName =
          userSnapshot.data()!["name"]; // فرض أن حقل اسم المستخدم هو "name"
      print(userName); // هنا يمكنك التعامل مع اسم المستخدم كما تريد
    }
  }
  return FirebaseFirestore.instance.collection("Reports").get();
}

Future<List<String>> displayUserNames() async {
  List<String> userNames = [];

  QuerySnapshot<Map<String, dynamic>> reportsSnapshot =
      await FirebaseFirestore.instance.collection("Reports").get();

  for (var report in reportsSnapshot.docs) {
    var userId = report.data()["idUser"];

    DocumentSnapshot<Map<String, dynamic>> userSnapshot =
        await FirebaseFirestore.instance.collection("users").doc(userId).get();

    if (userSnapshot.exists) {
      var userName = userSnapshot.data()!["name"];
      userNames.add(userName);
    }
  }

  return userNames;
}

Future<String> acceptReport(context, String idReports) async {
  String resp = "Some Error Occurred";
  try {
    statusReport statusAccept = statusReport.Accept;
    int statusIndex = statusReport.Accept.index;
    await FirebaseFirestore.instance
        .collection("Reports")
        .doc(idReports)
        .update({'statusReport': statusIndex});
    print("Accept Report ✔");
  } catch (err) {
    resp = err.toString();
  }
  return resp;
}

Future<String> rejectReport(context, String idReports) async {
  String resp = "Some Error Occurred";
  try {
    statusReport statusReject = statusReport.reject;
    int statusIndex = statusReport.reject.index;
    await FirebaseFirestore.instance
        .collection("Reports")
        .doc(idReports)
        .update({'statusReport': statusIndex});
    print("reject Report ✔");
  } catch (err) {
    resp = err.toString();
  }
  return resp;
}

  // QuerySnapshot<Map<String, dynamic>>? userName;
  // Future<QuerySnapshot<Map<String, dynamic>>?>? initData() async {
  //   return FirebaseFirestore.instance.collection("Reports").get();
  // }


  