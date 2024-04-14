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
            // if (snap.data == null) {
            //   print('empty data');
            //   // return const Text("Empty data");
            //   return const Text('لايوجد بلاغات قيد الانتظار');
            // }
            if (snap.data == null) {
              const Center(child: Text('لا يوجد بيانات للعرض'));
              print('لايوجد حجوزات منتظرة');
              message(context, 'لا يوجد حجوزات منتظرة');
            }
            return ReverseListView(
              snap: snap,
              futureBuilder: (index) {
             
                return FutureBuilder(
                  future: displayUserNamesPendingReverse(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      return Row(
                        children: [
                          const Icon(Icons.person, color: pendingColor),
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
            // return ListView.builder(
            //   padding: const EdgeInsets.symmetric(horizontal: 16),
            //   itemCount: snap.data?.docs.length ?? 0,
            //   itemBuilder: (context, index) {
            //     return Card(
            //       margin: const EdgeInsets.symmetric(vertical: 4),
            //       child: Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             Column(
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 mainAxisAlignment: MainAxisAlignment.center,
            //                 children: [
            //                   FutureBuilder<List<String>>(
            //                     future: displayUserNamesPendingReverse(),
            //                     builder: (context, snapshot) {
            //                       if (snapshot.connectionState ==
            //                           ConnectionState.waiting) {
            //                         return const CircularProgressIndicator();
            //                       } else if (snapshot.hasError) {
            //                         return Text('Error: ${snapshot.error}');
            //                       } else if (snapshot.hasData) {
            //                         return Text(
            //                             'اسم المستخدم: ${snapshot.data![index]}');
            //                       } else {
            //                         return const Text('No data available');
            //                       }
            //                     },
            //                   ),
            //                   Text(
            //                     "نوع الحشرة: ${snap.data!.docs[index].data()["Type Insect"]}",
            //                     // style: Theme.of(context).textTheme.titleMedium,
            //                   ),
            //                   Text(
            //                     "عنوان المكان الذي نتنشر فيه الحشرة \n: ${snap.data!.docs[index].data()["Adress"]}",
            //                     // style: Theme.of(context).textTheme.titleMedium,
            //                   ),
            //                   const Row(
            //                     children: [
            //                       Icon(Icons.timelapse_outlined),
            //                       Text('في انتظار قبول البلاغ'),
            //                     ],
            //                   )
            //                 ]),
            //           ],
            //         ),
            //       ),
            //     );
            //   },
            // );
          }),
    );
  }
}
