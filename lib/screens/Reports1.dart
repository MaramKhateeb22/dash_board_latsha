import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UsersList extends StatelessWidget {
  const UsersList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: displayUserNames(),
        builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Text('حدث خطأ: ${snapshot.error}');
            }
            if (snapshot.hasData) {
              // إنشاء قائمة من أسماء المستخدمين
              List<String> userNames = snapshot.data!;
              return ListView.builder(
                itemCount: userNames.length,
                itemBuilder: (context, index) {
                  return Text(userNames[index]);
                },
              );
            } else {
              return const Text('لا يوجد بيانات متاحة');
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  // توقع أن هذه الدالة ستعيد قائمة الأسماء
  Future<List<String>> displayUserNames() async {
    List<String> userNames = [];
    // استعلام لجلب جميع التقارير
    QuerySnapshot<Map<String, dynamic>> reportsSnapshot =
        await FirebaseFirestore.instance.collection("reports").get();

    // التكرار عبر كل تقرير للحصول على id user
    for (var report in reportsSnapshot.docs) {
      var userId = report.data()["iduser"];

      // استعلام لجلب المستخدم بناءً على iduser
      DocumentSnapshot<Map<String, dynamic>> userSnapshot =
          await FirebaseFirestore.instance
              .collection("users")
              .doc(userId)
              .get();

      // التحقق إذا كان الوثيقة موجودة وبعدها طباعة الاسم
      if (userSnapshot.exists) {
        var userName =
            userSnapshot.data()!["name"]; // فرض أن حقل اسم المستخدم هو "name"
        print(userName); // هنا يمكنك التعامل مع اسم المستخدم كما تريد
      }
    }

    // ... (هنا ستضع الكود الذي يجلب أسماء المستخدمين)

    return userNames; // إرجاع القائمة التي تحتوي على أسماء المستخدمين
  }
}
