import 'package:company_test/app_constant.dart';
import 'package:company_test/detail_activity.dart';
import 'package:company_test/model/activity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'create_new_activity.dart';

class ListActivity extends StatefulWidget {
  const ListActivity({super.key});

  @override
  State<ListActivity> createState() => _ListActivityState();
}

class _ListActivityState extends State<ListActivity> {
  List<Activity> listActivity = [];
  @override
  void initState() {
    super.initState();
    doSomeAsyncStuff();
  }

  Future<void> doSomeAsyncStuff() async {
    final snapshot = await AppConstant.ref.child(AppConstant.activity).get();
    Map<dynamic, dynamic> values = Map.from(snapshot.value as Map);
    values.forEach((key, values) {
      listActivity.add(Activity.fromSnapshot(Map.from(values as Map)));
    });
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Text(
              'Danh sach hoat dong',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 50),
            ListView.builder(
                shrinkWrap: true,
                itemCount: listActivity.length,
                itemBuilder: ((context, index) {
                  return CupertinoButton(
                    child: ItemActivity(activity: listActivity[index]),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DetailActivity(activity: listActivity[index])),
                      );
                    },
                  );
                })),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateNewActivity()),
          );
        },
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ItemActivity extends StatelessWidget {
  ItemActivity({super.key, required this.activity});
  Activity activity;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(color: Colors.grey),
          Text('Ten hoat dong: ${activity.nameActivity}'),
          Text('Mo ta hoat dong: ${activity.descriptionActivity}'),
          Text('Trang thai: ${activity.status}'),
          const Divider(color: Colors.grey)
        ],
      ),
    );
  }
}
