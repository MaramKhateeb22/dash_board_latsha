import 'package:cloud_firestore/cloud_firestore.dart';

//All
Future<QuerySnapshot<Map<String, dynamic>>?>? initDataReverse() async {
  // استعلام لجلب جميع التقارير
  QuerySnapshot<Map<String, dynamic>> reverseSnapshot = await FirebaseFirestore
      .instance
      .collection("Reverses")
      .orderBy('createdAt', descending: true)
      .get();

  // التكرار عبر كل تقرير للحصول على id user
  for (var reverse in reverseSnapshot.docs) {
    var userId = reverse.data()["idUser"];

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
  return FirebaseFirestore.instance.collection("Reverses").get();
}

Future<List<String>> displayUserNamesReverse() async {
  List<String> userNames = [];

  QuerySnapshot<Map<String, dynamic>> reverseSnapshot =
      await FirebaseFirestore.instance.collection("Reverses").get();

  for (var reverse in reverseSnapshot.docs) {
    var userId = reverse.data()["idUser"];

    DocumentSnapshot<Map<String, dynamic>> userSnapshot =
        await FirebaseFirestore.instance.collection("users").doc(userId).get();

    if (userSnapshot.exists) {
      var userName = userSnapshot.data()!["name"];
      userNames.add(userName);
    }
  }

  return userNames;
}

Future<List<String>> displayUserPhoneReverse() async {
  List<String> userNames = [];

  QuerySnapshot<Map<String, dynamic>> reverseSnapshot =
      await FirebaseFirestore.instance.collection("Reverses").get();

  for (var reverse in reverseSnapshot.docs) {
    var userId = reverse.data()["idUser"];

    DocumentSnapshot<Map<String, dynamic>> userSnapshot =
        await FirebaseFirestore.instance.collection("users").doc(userId).get();

    if (userSnapshot.exists) {
      var userName = userSnapshot.data()!["numberphone"];
      userNames.add(userName);
    }
  }

  return userNames;
}

//Reject

Future<QuerySnapshot<Map<String, dynamic>>?>? initDataRejectReverse() async {
  QuerySnapshot<Map<String, dynamic>> reverseSnapshots =
      await FirebaseFirestore.instance
          .collection("Reverses")
          .where("statusReverse", isEqualTo: 2)
          // .orderBy('createdAt', descending: true)
          .get();

  // التكرار عبر كل تقرير للحصول على id user
  for (var reverse in reverseSnapshots.docs) {
    var userId = reverse.data()["idUser"];

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
      .collection("Reverses")
      .where("statusReverse", isEqualTo: 2)
      .get();
}

Future<List<String>> displayUserNamesRejectReverse() async {
  List<String> userNames = [];

  QuerySnapshot<Map<String, dynamic>> reverseSnapshot = await FirebaseFirestore
      .instance
      .collection("Reverses")
      .where("statusReverse", isEqualTo: 2)
      .get();

  for (var reverse in reverseSnapshot.docs) {
    var userId = reverse.data()["idUser"];

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

Future<QuerySnapshot<Map<String, dynamic>>?>? initDataPendingReverse() async {
  QuerySnapshot<Map<String, dynamic>> reversesSnapshot =
      await FirebaseFirestore.instance
          .collection("Reverses")
          .where("statusReverse", isEqualTo: 0)
          // .orderBy('createdAt', descending: true)
          .get();

  // التكرار عبر كل تقرير للحصول على id user
  for (var reverse in reversesSnapshot.docs) {
    var userId = reverse.data()["idUser"];

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
      .collection("Reverses")
      .where("statusReverse", isEqualTo: 0)
      .get();
}

Future<List<String>> displayUserNamesPendingReverse() async {
  List<String> userNames = [];

  QuerySnapshot<Map<String, dynamic>> reversesSnapshot = await FirebaseFirestore
      .instance
      .collection("Reverses")
      .where("statusReverse", isEqualTo: 0)
      .get();

  for (var reverse in reversesSnapshot.docs) {
    var userId = reverse.data()["idUser"];

    DocumentSnapshot<Map<String, dynamic>> userSnapshot =
        await FirebaseFirestore.instance.collection("users").doc(userId).get();

    if (userSnapshot.exists) {
      var userName = userSnapshot.data()!["name"];
      userNames.add(userName);
    }
  }

  return userNames;
}

//Accept
Future<QuerySnapshot<Map<String, dynamic>>?>? initDataAcceptReveres() async {
  QuerySnapshot<Map<String, dynamic>> reverseSnapshot =
      await FirebaseFirestore.instance
          .collection("Reverses")
          .where("statusReverse", isEqualTo: 1)
          // .orderBy('createdAt', descending: true)
          .get();

  // التكرار عبر كل تقرير للحصول على id user
  for (var reverse in reverseSnapshot.docs) {
    var userId = reverse.data()["idUser"];

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
      .collection("Reverses")
      .where("statusReverse", isEqualTo: 1)
      .get();
}

Future<List<String>> displayUserNamesAcceptReverse() async {
  List<String> userNames = [];

  QuerySnapshot<Map<String, dynamic>> reverseSnapshot = await FirebaseFirestore
      .instance
      .collection("Reverses")
      .where("statusReverse", isEqualTo: 1)
      .get();

  for (var reverse in reverseSnapshot.docs) {
    var userId = reverse.data()["idUser"];

    DocumentSnapshot<Map<String, dynamic>> userSnapshot =
        await FirebaseFirestore.instance.collection("users").doc(userId).get();

    if (userSnapshot.exists) {
      var userName = userSnapshot.data()!["name"];
      userNames.add(userName);
    }
  }

  return userNames;
}

//Done Reverse

Future<QuerySnapshot<Map<String, dynamic>>?>? initDataDoneReverse() async {
  QuerySnapshot<Map<String, dynamic>> reverseSnapshots =
      await FirebaseFirestore.instance
          .collection("Reverses")
          .where("statusReverse", isEqualTo: 3)
          // .orderBy('createdAt', descending: true)
          .get();

  // التكرار عبر كل تقرير للحصول على id user
  for (var reverse in reverseSnapshots.docs) {
    var userId = reverse.data()["idUser"];

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
      .collection("Reverses")
      .where("statusReverse", isEqualTo: 3)
      .get();
}

Future<List<String>> displayUserNamesDoneReverse() async {
  List<String> userNames = [];

  QuerySnapshot<Map<String, dynamic>> reverseSnapshot = await FirebaseFirestore
      .instance
      .collection("Reverses")
      .where("statusReverse", isEqualTo: 3)
      .get();

  for (var reverse in reverseSnapshot.docs) {
    var userId = reverse.data()["idUser"];

    DocumentSnapshot<Map<String, dynamic>> userSnapshot =
        await FirebaseFirestore.instance.collection("users").doc(userId).get();

    if (userSnapshot.exists) {
      var userName = userSnapshot.data()!["name"];
      userNames.add(userName);
    }
  }

  return userNames;
}
