import 'package:dash_board_mopidati/screens/Reports/function.dart';
import 'package:flutter/material.dart';

class RejectReportScreen extends StatefulWidget {
  const RejectReportScreen({super.key});

  @override
  State<RejectReportScreen> createState() => _RejectReportScreenState();
}

class _RejectReportScreenState extends State<RejectReportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('البلاغات المرفوضة '),
      ),
      body: FutureBuilder(
          future: initDataReject(),
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
                                future: displayUserNamesReject(),
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
                                // style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const Row(
                                children: [
                                  Icon(Icons.clear),
                                  Text('تم رفض البلاغ'),
                                ],
                              ),
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
