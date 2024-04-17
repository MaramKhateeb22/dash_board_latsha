import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_board_mopidati/screens/Instructions/add/NewInstraction.dart';
import 'package:dash_board_mopidati/shared/constant.dart';
import 'package:dash_board_mopidati/widget/buttonwidget.dart';
import 'package:dash_board_mopidati/widget/my_Text.dart';
import 'package:flutter/material.dart';

class AllInsractions extends StatefulWidget {
  const AllInsractions({super.key});

  @override
  State<AllInsractions> createState() => _AllInsractionsState();
}

class _AllInsractionsState extends State<AllInsractions> {
  Future<QuerySnapshot<Map<String, dynamic>>> initInstraction() async {
    return await FirebaseFirestore.instance
        .collection("Instractions")
        .orderBy('createdAt', descending: true)
        .get();
  }

  Future<void> deleteInstraction(String instractiontId) async {
    FirebaseFirestore.instance
        .collection('Instractions')
        .doc(instractiontId)
        .delete()
        .then((_) => message(context, 'تم حذف الارشاد بنجاح'))
        .catchError((error) => print("Failed to delete Report: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الارشادات '),
        // leading: const Icon(Icons.menu_book_outlined),
      ),
      body: FutureBuilder(
        future: initInstraction(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.hasError) return const Text("Something has error");
          if (snap.data == null) {
            print('empty data');
            return const Text("لم يتم إضافة إرشادات ");
          }
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 7),
            itemCount: snap.data?.docs.length ?? 0,
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 0.0, vertical: 10),
                child: Card(
                  color: backgroundColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          // mainAxisAlignment: MainAxisAlignment,
                          children: [
                            Container(
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                color: pColor,
                                // color: cardbackground,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              // width: 130,
                              // height: 130,
                              child: Image.network(
                                  width: 120,
                                  height: 150,
                                  fit: BoxFit.cover,
                                  "${snap.data!.docs[index].data()["imageLink"]}"),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomInkWell(
                                  style: const TextStyle(
                                    height: 1.2,
                                    fontSize: 23,
                                    color: pColor,
                                  ),
                                  // maxLines: 3,
                                  snap: snap,
                                  index: index,
                                  adress: 'Adress',
                                ),
                                CustomInkWell(
                                  maxLines: 3,
                                  snap: snap,
                                  adress: 'Details Instraction',
                                  index: index,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ],
                            ),
                          ],
                        ),
                        // const SizedBox(
                        //   height: 5,
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ButtonWidget(
                              side: const BorderSide(
                                  color: pendingColor,
                                  style: BorderStyle.solid),
                              icon: Icons.edit,
                              colorIcon: pendingColor,
                              colorText: pendingColor,
                              child: "تعديل  ",
                              onPressed: () async {
                                await Navigator.pushNamed(
                                  context,
                                  '/EditInstarctionScreen',
                                  arguments: [
                                    '${snap.data!.docs[index].data()["id"]}',
                                    '${snap.data!.docs[index].data()["Adress"]}',
                                    '${snap.data!.docs[index].data()["Details Instraction"]}',
                                    '${snap.data!.docs[index].data()["imageLink"]}'
                                  ],
                                );
                                print('${snap.data!.docs[index].data()["id"]}');
                              },
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            ButtonWidget(
                              side: const BorderSide(
                                  style: BorderStyle.solid, color: rejectColor),
                              icon: Icons.delete,
                              colorIcon: rejectColor,
                              colorText: rejectColor,
                              child: "حذف ",
                              onPressed: () {
                                setState(() {});
                                deleteInstraction(
                                    '${snap.data!.docs[index].data()["id"]}');
                                print('${snap.data!.docs[index].data()["id"]}');
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20),
        child: ButtonWidget(
          side: const BorderSide(color: pColor),
          backgroundColors: cardbackground,
          widthFactor: 1,
          child: 'إضافة إرشاد',
          icon: Icons.addchart_outlined,
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                  builder: (context) => const NewInstarctionScreen()),
            );
          },
        ),
      ),
    );
  }
}
