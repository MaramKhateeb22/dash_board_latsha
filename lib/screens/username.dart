import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DisplayUserName extends StatelessWidget {
  final Future<QuerySnapshot<Map<String, dynamic>>?>? userNameFuture;

  DisplayUserName({required this.userNameFuture});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot<Map<String, dynamic>>?>(
      future: userNameFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // عرض رمز التحميل أثناء جلب البيانات
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          String userName = snapshot.data!.docs[0]
              .data()["name"]; // افترض أن الاسم هو العنصر الأول في النتيجة
          return Text(userName); // عرض اسم المستخدم داخل Text widget
        } else {
          return Text('No data available');
        }
      },
    );
  }
}
