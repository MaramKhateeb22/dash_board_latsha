import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class acceptReportScreen extends StatefulWidget {
  const acceptReportScreen({super.key});

  @override
  State<acceptReportScreen> createState() => _acceptReportScreenState();
}

class _acceptReportScreenState extends State<acceptReportScreen> {
  Future<QuerySnapshot<Map<String, dynamic>>?>? initData() async {
    return FirebaseFirestore.instance
        .collection("Reports")
        .where("statusReport", isEqualTo: 1)
        .get();
  }

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
                                // style: Theme.of(context).textTheme.titleMedium,
                              ),
                              '${snap.data!.docs[index].data()["statusReport"]}' ==
                                      '0'
                                  ? const Icon(Icons.timelapse_outlined)
                                  : '${snap.data!.docs[index].data()["statusReport"]}' ==
                                          '1'
                                      ? const Icon(
                                          Icons.check_circle_outline_rounded)
                                      : const Icon(Icons.clear),
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
