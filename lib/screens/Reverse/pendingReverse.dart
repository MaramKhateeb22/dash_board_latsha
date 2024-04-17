import 'package:dash_board_mopidati/screens/Reverse/function.dart';
import 'package:dash_board_mopidati/shared/constant.dart';
import 'package:dash_board_mopidati/widget/Reverse_Listview.dart';
import 'package:flutter/material.dart';

class PendingReverseScreen extends StatefulWidget {
  const PendingReverseScreen({super.key});

  @override
  State<PendingReverseScreen> createState() => _PendingReverseScreenState();
}

class _PendingReverseScreenState extends State<PendingReverseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(' الحجوزات المنتظرة'),
      ),
      body: FutureBuilder(
        future: initDataPendingReverse(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.hasError) return const Text("Something has error");
          if (snap.data?.docs.isEmpty ?? false) {
            print('empty data');
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.report,
                    size: 60,
                    color: Colors.yellow,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(" لايوجد حجوزات قيد الانتظار"),
                ],
              ),
            );
          }
          if (snap.data == null) {
            return const Center(
              child: Text('لايوجد بلاغات قيد الانتظار'),
            );
          }
          if (snap.data?.docs.isEmpty ?? false) {
            print('empty data');
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.report,
                    size: 60,
                    color: Colors.yellow,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(" لايوجد حجوزات قيد الانتظار"),
                ],
              ),
            );
          }
          return ReverseListView(
            snap: snap,
            futureBuilder: (index) {
              return FutureBuilder(
                future: displayUserNamesPendingReverse(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }

                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  if (snap.data?.docs.isEmpty ?? false) {
                    print('empty data');
                    return const Text('لا يوجد اسم');
                  }

                  if (snapshot.hasData) {
                    return Row(
                      children: [
                        const Icon(Icons.person, color: pendingColor),
                        SizedBox(
                          width: 5,
                        ),
                        Text('${snapshot.data![index]}'),
                      ],
                    );
                  } else {
                    return const Text('لا يوجد بيانات للعرض');
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
