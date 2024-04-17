import 'package:cloud_firestore/cloud_firestore.dart';

//All
Future<QuerySnapshot<Map<String, dynamic>>?>? initData() async {
  // استعلام لجلب جميع التقارير
  QuerySnapshot<Map<String, dynamic>> reportsSnapshot = await FirebaseFirestore
      .instance
      .collection("Reports")
      .orderBy('createdAt', descending: true)
      .get();

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

Future<List<String>> displayUserPhone() async {
  List<String> userNames = [];

  QuerySnapshot<Map<String, dynamic>> reportsSnapshot =
      await FirebaseFirestore.instance.collection("Reports").get();

  for (var report in reportsSnapshot.docs) {
    var userId = report.data()["idUser"];

    DocumentSnapshot<Map<String, dynamic>> userSnapshot =
        await FirebaseFirestore.instance.collection("users").doc(userId).get();

    if (userSnapshot.exists) {
      var userName = userSnapshot.data()!["numberphone"];
      userNames.add(userName);
    }
  }

  return userNames;
}

//Accept
Future<QuerySnapshot<Map<String, dynamic>>?>? initDataAccept() async {
  QuerySnapshot<Map<String, dynamic>> reportsSnapshot =
      await FirebaseFirestore.instance
          .collection("Reports")
          .where("statusReport", isEqualTo: 1)
          // .orderBy('createdAt', descending: true)
          .get();

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
  return FirebaseFirestore.instance
      .collection("Reports")
      .where("statusReport", isEqualTo: 1)
      .get();
}

Future<List<String>> displayUserNamesAccept() async {
  List<String> userNames = [];

  QuerySnapshot<Map<String, dynamic>> reportsSnapshot = await FirebaseFirestore
      .instance
      .collection("Reports")
      .where("statusReport", isEqualTo: 1)
      .get();

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

//Reject

Future<QuerySnapshot<Map<String, dynamic>>?>? initDataReject() async {
  QuerySnapshot<Map<String, dynamic>> reportsSnapshots =
      await FirebaseFirestore.instance
          .collection("Reports")
          .where("statusReport", isEqualTo: 2)
          // .orderBy('createdAt', descending: true)
          .get();

  // التكرار عبر كل تقرير للحصول على id user
  for (var report in reportsSnapshots.docs) {
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
  return FirebaseFirestore.instance
      .collection("Reports")
      .where("statusReport", isEqualTo: 2)
      .get();
}

Future<List<String>> displayUserNamesReject() async {
  List<String> userNames = [];

  QuerySnapshot<Map<String, dynamic>> reportsSnapshot = await FirebaseFirestore
      .instance
      .collection("Reports")
      .where("statusReport", isEqualTo: 2)
      .get();

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

//pending

Future<QuerySnapshot<Map<String, dynamic>>?>? initDataPending() async {
  QuerySnapshot<Map<String, dynamic>> reportsSnapshot =
      await FirebaseFirestore.instance
          .collection("Reports")
          .where("statusReport", isEqualTo: 0)
          // .orderBy('createdAt', descending: true)
          .get();

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
  return FirebaseFirestore.instance
      .collection("Reports")
      .where("statusReport", isEqualTo: 0)
      .get();
}

Future<List<String>> displayUserNamesPending() async {
  List<String> userNames = [];

  QuerySnapshot<Map<String, dynamic>> reportsSnapshot = await FirebaseFirestore
      .instance
      .collection("Reports")
      .where("statusReport", isEqualTo: 0)
      .get();

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
