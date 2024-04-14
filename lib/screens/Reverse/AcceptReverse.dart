import 'package:dash_board_mopidati/screens/Reverse/function.dart';
import 'package:dash_board_mopidati/shared/constant.dart';
import 'package:dash_board_mopidati/widget/Reverse_Listview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AcceptReverseScreen extends StatefulWidget {
  const AcceptReverseScreen({super.key});

  @override
  State<AcceptReverseScreen> createState() => _AcceptReverseScreenState();
}

class _AcceptReverseScreenState extends State<AcceptReverseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(' الحجوزات المفبولة'),
      ),
      body: FutureBuilder(
          future: initDataAcceptReveres(),
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snap.hasError) return const Text("Something has error");
            if (snap.data == null) {
              print('empty data');
              return const Text("Empty data");
            }
            return ReverseListView(
              snap: snap,
              futureBuilder: (index) {
                return FutureBuilder(
                  future: displayUserNamesAcceptReverse(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      return Row(
                        children: [
                          const Icon(Icons.person, color: acceptColor),
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
            //                     future: displayUserNamesAcceptReverse(),
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
            //                   Text(
            //                     "مساحة  المكان المطلوب للرش \n: ${snap.data!.docs[index].data()["space"]}",
            //                     // style: Theme.of(context).textTheme.titleMedium,
            //                   ),
            //                   const Row(
            //                     children: [
            //                       Icon(Icons.check_circle_outline_rounded),
            //                       Text('تم قبول البلاغ'),
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
