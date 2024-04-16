import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_board_mopidati/screens/Insects/add/AddInsects.dart';
import 'package:dash_board_mopidati/shared/constant.dart';
import 'package:dash_board_mopidati/widget/buttonwidget.dart';
import 'package:flutter/material.dart';

class AllInsectPriceScreen extends StatefulWidget {
  const AllInsectPriceScreen({super.key});

  @override
  State<AllInsectPriceScreen> createState() => _AllInsectPriceScreenState();
}

class _AllInsectPriceScreenState extends State<AllInsectPriceScreen> {
  Future<QuerySnapshot<Map<String, dynamic>>?>? initDataInsect() async {
    return FirebaseFirestore.instance
        .collection("insects")
        .orderBy("createdAt", descending: true)
        .get();
  }

  Future<void> deleteInsect(context, String insectId) async {
    FirebaseFirestore.instance
        .collection('insects')
        .doc(insectId)
        .delete()
        .then((_) => message(context, 'تم الحذف  بنجاح'))
        .catchError(
          (error) => print("Failed to delete Report: $error"),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('كل الاسعار'),
      ),
      body: FutureBuilder(
        future: initDataInsect(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.hasError) return const Text("Something has error");
          if (snap.data == null) {
            return const Text("لا يوجد عملاء ");
          }
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: snap.data?.docs.length ?? 0,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                child: Card(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.bug_report),
                                    Text('${snap.data!.docs[index]['name']}'),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.money),
                                    Text('${snap.data!.docs[index]['price']}'
                                        'ل.س'
                                        ' لل كم '),
                                  ],
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ButtonWidget(
                                  side: const BorderSide(
                                      style: BorderStyle.solid,
                                      color: Colors.orange),
                                  child: 'تعديل',
                                  icon: Icons.delete,
                                  colorIcon: Colors.orange,
                                  colorText: Colors.orange,
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      '/edit_insect',
                                      arguments: [
                                        '${snap.data!.docs[index].data()["id"]}',
                                        '${snap.data!.docs[index].data()["name"]}',
                                        '${snap.data!.docs[index].data()["price"]}',
                                      ],
                                    );
                                  },
                                ),
                                ButtonWidget(
                                  side: const BorderSide(
                                      style: BorderStyle.solid,
                                      color: Colors.red),
                                  child: 'حذف',
                                  icon: Icons.delete,
                                  colorIcon: Colors.red,
                                  colorText: Colors.red,
                                  onPressed: () {
                                    setState(() {});
                                    deleteInsect(context,
                                        '${snap.data!.docs[index]['id']}');
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ButtonWidget(
          side: const BorderSide(color: pColor),
          child: 'إضافة حشرة ',
          icon: Icons.add,
          backgroundColors: cardbackground,
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const AddInsectsScreen(),
              ),
            );
            // Navigator.pushNamed(context, '/add_insect');
          },
        ),
      ),
    );
  }
}
