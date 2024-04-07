import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_board_mopidati/shared/constant.dart';
import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

enum statusReport {
  depinding,
  Accept,
  reject;
}

class _ReportsScreenState extends State<ReportsScreen> {
  Future<QuerySnapshot<Map<String, dynamic>>?>? initData() async {
    return FirebaseFirestore.instance.collection("Reports").get();
  }

  // Future<QuerySnapshot<Map<String, dynamic>>?>? initData() async {
  //   QuerySnapshot<Map<String, dynamic>>? reportsQuery =
  //       await FirebaseFirestore.instance.collection("Reports").get();

  //   for (QueryDocumentSnapshot<Map<String, dynamic>> reportSnapshot
  //       in reportsQuery.docs) {
  //     String userId = reportSnapshot.data()['iduser'];

  //     DocumentSnapshot<Map<String, dynamic>> userSnapshot =
  //         await FirebaseFirestore.instance
  //             .collection('Users')
  //             .doc(userId)
  //             .get();

  //     if (userSnapshot.exists) {
  //       String userName = userSnapshot.data()?['name'] ?? 'Unknown User';
  //       // return userName;
  //     }
  //   }
  //   return null;

  //   // return 'Unknown User';
  // }

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
      statusReport statusAccept = statusReport.reject;
      int statusIndex = statusReport.Accept.index;
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

  // Future<QuerySnapshot<Map<String, dynamic>>?>? displayUserNames() async {
  //   // استعلام لجلب جميع التقارير
  //   QuerySnapshot<Map<String, dynamic>> reportsSnapshot =
  //       await FirebaseFirestore.instance.collection("Reports").get();

  //   // التكرار عبر كل تقرير للحصول على id user
  //   for (var report in reportsSnapshot.docs) {
  //     var userId = report.data()["idUser"];

  //     // استعلام لجلب المستخدم بناءً على iduser
  //     DocumentSnapshot<Map<String, dynamic>> userSnapshot =
  //         await FirebaseFirestore.instance
  //             .collection("users")
  //             .doc(userId)
  //             .get();

  //     // التحقق إذا كان الوثيقة موجودة وبعدها طباعة الاسم
  //     if (userSnapshot.exists) {
  //       var userName =
  //           userSnapshot.data()!["name"]; // فرض أن حقل اسم المستخدم هو "name"
  //       print(userName); // هنا يمكنك التعامل مع اسم المستخدم كما تريد
  //     }
  //   }
  //   return null;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('كل البلاغات'),
      ),
      body: FutureBuilder(
          future: initData(),
          builder: (context, snap) {
            // List<QuerySnapshot<Map<String, dynamic>>> userNames = [snap.data!];
            if (snap.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snap.hasError) return const Text("Something has error");
            if (snap.data == null) {
              print('empty data');
              return const Text("Empty data");
            }
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: snap.data?.docs.length ?? 0,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 200,
                                height: 200,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15)),
                                child: Image.network(
                                    // width: 200,
                                    // height: 150,
                                    // fit: BoxFit.cover,
                                    '${snap.data!.docs[index].data()["imageLink"]}'),
                              ),
                              // Text('اسم المستخدم '
                              //     '${snap.data!.docs[index].data()['idUser']}'),
                              Text(
                                "نوع الحشرة: ${snap.data!.docs[index].data()["Type Insect"]}",
                                // style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Text(
                                "عنوان المكان الذي نتنشر فيه الحشرة \n: ${snap.data!.docs[index].data()["Adress"]}",
                              ),
                              '${snap.data!.docs[index].data()["statusReport"]}' ==
                                      '0'
                                  ? const Icon(Icons.timelapse_outlined)
                                  : '${snap.data!.docs[index].data()["statusReport"]}' ==
                                          '1'
                                      ? const Icon(
                                          Icons.check_circle_outline_rounded)
                                      : const Icon(Icons.clear),
                              Row(
                                children: [
                                  MaterialButton(
                                    color: backgroundColor,
                                    elevation: 2,
                                    textColor: pColor,
                                    onPressed: () {
                                      setState(() {});
                                      acceptReport(context,
                                          snap.data!.docs[index].data()["id"]);
                                    },
                                    child: '${snap.data!.docs[index].data()["statusReport"]}' ==
                                            '0'
                                        ? const Text('قبول البلاغ')
                                        : '${snap.data!.docs[index].data()["statusReport"]}' ==
                                                '1'
                                            ? const Text('تم قبول البلاغ ')
                                            : const Text(' تم رفض البلاغ'),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  MaterialButton(
                                    color: backgroundColor,
                                    textColor: pColor,
                                    onPressed: () {
                                      setState(() {
                                        rejectReport(
                                            context,
                                            snap.data!.docs[index]
                                                .data()["id"]);
                                      });
                                    },
                                    child: const Text(' رفض البلاغ'),
                                  ),
                                ],
                              )
                            ]),
                      ],
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}
