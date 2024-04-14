import 'package:dash_board_mopidati/screens/Reverse/function.dart';
import 'package:dash_board_mopidati/shared/constant.dart';
import 'package:dash_board_mopidati/widget/Reverse_Listview.dart';
import 'package:flutter/material.dart';

class DoneReverseScreen extends StatefulWidget {
  const DoneReverseScreen({super.key});

  @override
  State<DoneReverseScreen> createState() => _DoneReverseScreenState();
}

class _DoneReverseScreenState extends State<DoneReverseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(' الحجوزات المنجزة'),
      ),
      body: FutureBuilder(
          future: initDataDoneReverse(),
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snap.hasError) return const Text("Something has error");
            if (snap.data == null) {
              print('لا يوجد بيانات للعرض');
              return const Text("لا يوجد بيانات للعرض");
            }
            return ReverseListView(
              snap: snap,
              futureBuilder: (index) {
                return FutureBuilder(
                  future: displayUserNamesDoneReverse(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      return Row(
                        children: [
                          const Icon(Icons.person, color: doneColor),
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
            //                     future: displayUserNamesDoneReverse(),
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
            //                   // Container(
            //                   //   width: 200,
            //                   //   height: 200,
            //                   //   decoration: BoxDecoration(
            //                   //       borderRadius: BorderRadius.circular(15)),
            //                   //   child: Image.network(
            //                   //       // width: 200,
            //                   //       // height: 150,
            //                   //       // fit: BoxFit.cover,
            //                   //       '${snap.data!.docs[index].data()["imageLink"]}'),
            //                   // ),
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
            //                       Text('تم الرش ✔')
            //                     ],
            //                   ),
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
