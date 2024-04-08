import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_board_mopidati/screens/Reports/function.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('كل البلاغات'),
      ),
      body: FutureBuilder(
          future: initData(),
          builder: (context, snap) {
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
                              FutureBuilder<List<String>>(
                                future: displayUserNames(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else if (snapshot.hasData) {
                                    return Text(
                                        'اسم المستخدم: ${snapshot.data![index]}');
                                  } else {
                                    return const Text('No data available');
                                  }
                                },
                              ),
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
                                      print(
                                          snap.data!.docs[index].data()["id"]);
                                    },
                                    child: '${snap.data!.docs[index].data()["statusReport"]}' ==
                                            '0'
                                        ? const Text('قبول البلاغ')
                                        : '${snap.data!.docs[index].data()["statusReport"]}' ==
                                                '1'
                                            ? const Text('تم قبول البلاغ ')
                                            : null,
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
                                        print(snap.data!.docs[index]
                                            .data()["id"]);
                                      });
                                      print('تم رفض البلاغ');
                                    },
                                    child: '${snap.data!.docs[index].data()["statusReport"]}' ==
                                            '0'
                                        ? const Text('رفض البلاغ')
                                        : '${snap.data!.docs[index].data()["statusReport"]}' ==
                                                '1'
                                            ? null
                                            : const Text(' تم رفض البلاغ'),
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
