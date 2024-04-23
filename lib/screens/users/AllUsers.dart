import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_board_mopidati/shared/constant.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AllUsers extends StatefulWidget {
  const AllUsers({super.key});

  @override
  State<AllUsers> createState() => _AllUsersState();
}

class _AllUsersState extends State<AllUsers> {
  Future<QuerySnapshot<Map<String, dynamic>>?>? initData() async {
    return FirebaseFirestore.instance
        .collection("users")
        .orderBy("createdAt", descending: true)
        .get();
  }

  @override
  void initState() {
    initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('عملاؤنا '),
        // leading: const Icon(Icons.people),
      ),
      body: FutureBuilder(
        future: initData(),
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
                  color: backgroundColor,
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.,
                      children: [
                        CircleAvatar(
                          radius: 40,
                          child: Image.asset('assets/images/images.png'),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "${snap.data!.docs[index].data()["name"]}",
                              style:
                                  const TextStyle(fontWeight: FontWeight.w900),
                              // style: Theme.of(context).textTheme.titleMedium,
                            ),
                            TextButton(
                              child: Text(
                                "${snap.data!.docs[index].data()["email"]}",
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 134, 134, 134),
                                    fontSize: 20),
                              ),
                              // style: Theme.of(context).textTheme.titleMedium,
                              onPressed: () async {
                                final Uri emailUri = Uri(
                                  scheme: 'mailto',
                                  path:
                                      ':${snap.data!.docs[index].data()["email"]}', // أضف البريد الإلكتروني هنا
                                );
                                if (await canLaunch(emailUri.toString())) {
                                  await launch(emailUri.toString());
                                } else {
                                  throw 'لا تمتلك بطيق ال email';
                                }
                              },
                            ),
                            TextButton(
                              child: Text(
                                "${snap.data!.docs[index].data()["numberphone"]}",
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 134, 134, 134),
                                    fontSize: 20),
                              ),
                              // style: Theme.of(context).textTheme.titleMedium,
                              onPressed: () async {
                                final Uri phoneUri = Uri(
                                  scheme: 'tel',
                                  path:
                                      "${snap.data!.docs[index].data()["numberphone"]}", // أضف رقم الهاتف هنا
                                );
                                launch(phoneUri.toString());
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
    );
  }
}
