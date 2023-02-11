import 'package:company_test/app_constant.dart';
import 'package:company_test/model/activity.dart';
import 'package:company_test/model/join.dart';
import 'package:company_test/review_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';

class DetailActivity extends StatefulWidget {
  DetailActivity({super.key, required this.activity});

  Activity activity;

  @override
  State<DetailActivity> createState() => _DetailActivityState();
}

class _DetailActivityState extends State<DetailActivity> {
  final _textName = TextEditingController();
  final _textDescription = TextEditingController();
  final _textTimeStart = TextEditingController();
  final _textTimeEnd = TextEditingController();
  final _textNumberMin = TextEditingController();
  final _textNumberMax = TextEditingController();
  final _textTimeRegister = TextEditingController();
  final _textStatus = TextEditingController();
  final _textReason = TextEditingController();

  late final enableEditText;

  Join? object;

  List<Join> listJoin = [];
  bool isShowReviewButton = false;
  bool isStatusEnd = false;

  @override
  void initState() {
    super.initState();
    _textName.text = widget.activity.nameActivity ?? '';
    _textDescription.text = widget.activity.descriptionActivity ?? '';
    _textTimeStart.text = widget.activity.timeStart ?? '';
    _textTimeEnd.text = widget.activity.timeEnd ?? '';
    _textNumberMin.text = widget.activity.minNumber ?? '';
    _textNumberMax.text = widget.activity.maxNumber ?? '';
    _textTimeRegister.text = widget.activity.timeRegister ?? '';
    _textStatus.text = widget.activity.status ?? '';
    _textReason.text = widget.activity.reason ?? '';

    enableEditText = widget.activity.idMember == AppConstant.userMember.idMember;

    doSomeAsyncStuff();
  }

  Future<void> doSomeAsyncStuff() async {
    final snapshot = await AppConstant.ref.child('join').get();
    Map<dynamic, dynamic> values = Map.from(snapshot.value as Map);
    values.forEach((key, values) {
      listJoin.add(Join.fromSnapshot(Map.from(values as Map)));
    });
    isStatusEnd = widget.activity.status == 'Da ket thuc';
    print(enableEditText);
    object = listJoin.firstWhereOrNull((element) =>
        (element.idMemberJoin == AppConstant.userMember.idMember) &&
        (element.idActivity == widget.activity.idActivity));
    if (object != null) {
      if (isStatusEnd) {
        isShowReviewButton = true;
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _textName,
                enabled: enableEditText,
                decoration: const InputDecoration(
                  labelText: 'Ten hoat dong',
                ),
              ),
              TextField(
                enabled: enableEditText,
                controller: _textDescription,
                decoration: const InputDecoration(
                  labelText: 'Mo ta hoat dong',
                ),
              ),
              TextField(
                enabled: enableEditText,
                controller: _textTimeStart,
                decoration: const InputDecoration(
                  labelText: 'Ngay gio bat dau',
                ),
              ),
              TextField(
                enabled: enableEditText,
                controller: _textTimeEnd,
                decoration: const InputDecoration(
                  labelText: 'Ngay gio ket thuc',
                ),
              ),
              TextField(
                enabled: enableEditText,
                controller: _textNumberMin,
                decoration: const InputDecoration(
                  labelText: 'So luong toi thieu yeu cau',
                ),
              ),
              TextField(
                enabled: enableEditText,
                controller: _textNumberMax,
                decoration: const InputDecoration(
                  labelText: 'So luong toi da yeu cau',
                ),
              ),
              TextField(
                enabled: enableEditText,
                controller: _textTimeRegister,
                decoration: const InputDecoration(
                  labelText: 'Thoi han dang ki',
                ),
              ),
              TextField(
                enabled: enableEditText,
                controller: _textStatus,
                decoration: const InputDecoration(
                  labelText: 'Trang thai',
                ),
              ),
              TextField(
                enabled: enableEditText,
                controller: _textReason,
                decoration: const InputDecoration(
                  labelText: 'Ly do huy hoat dong',
                ),
              ),
              const SizedBox(height: 50),
              if (enableEditText)
                CupertinoButton(
                  color: Colors.blueAccent,
                  child: const Text('Cap nhat'),
                  onPressed: () {
                    String path = '${AppConstant.activity}/${widget.activity.idActivity}';
                    AppConstant.ref.child(path).update({
                      "idActivity": widget.activity.idActivity,
                      "nameActivity": _textName.text.trim(),
                      "description": _textDescription.text.trim(),
                      "timeStart": _textTimeStart.text.trim(),
                      "timeEnd": _textTimeEnd.text.trim(),
                      "minNumber": _textNumberMin.text.trim(),
                      "maxNumber": _textNumberMax.text.trim(),
                      "timeRegister": _textTimeRegister.text.trim(),
                      "status": _textStatus.text.trim(),
                      "idMember": AppConstant.userMember.idMember,
                      "reason": _textReason.text.trim(),
                    });
                  },
                ),
              if (!enableEditText)
                Column(
                  children: [
                    if (object == null)
                      CupertinoButton(
                          color: Colors.blueAccent,
                          child: const Text('Tham gia'),
                          onPressed: () {
                            DateTime now = DateTime.now();
                            String formattedDate = DateFormat('yyyy-MM-dd-HH:mm:ssss').format(now);
                            String path = 'join/$formattedDate';
                            final join = Join(
                              idJoin: formattedDate,
                              idMemberJoin: AppConstant.userMember.idMember,
                              idActivity: widget.activity.idActivity,
                              dateTimeRegister: formattedDate,
                              point1: '',
                              point2: '',
                              point3: '',
                              pointLead: '',
                              comment: '',
                            );
                            AppConstant.ref.child(path).set(join.toJson());
                          }),
                    if (isShowReviewButton)
                      CupertinoButton(
                          color: Colors.blueAccent,
                          child: const Text('Danh gia'),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ReviewPage(join: object!)),
                            );
                          })
                  ],
                )
            ],
          ),
        ),
      ),
      floatingActionButton: (enableEditText)
          ? FloatingActionButton(
              onPressed: () {
                AppConstant.ref
                    .child(AppConstant.activity)
                    .child(widget.activity.idActivity ?? '')
                    .remove()
                    .then((value) => Navigator.pop(context));
              },
              tooltip: 'Delete',
              child: const Icon(Icons.delete),
            )
          : null,
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _textName.dispose();
    _textDescription.dispose();
    _textNumberMax.dispose();
    _textReason.dispose();
    _textNumberMin.dispose();
    _textStatus.dispose();
    _textTimeEnd.dispose();
    _textTimeStart.dispose();
    super.dispose();
  }
}
