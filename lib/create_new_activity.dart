import 'package:company_test/app_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

class CreateNewActivity extends StatefulWidget {
  const CreateNewActivity({super.key});

  @override
  State<CreateNewActivity> createState() => _CreateNewActivityState();
}

class _CreateNewActivityState extends State<CreateNewActivity> {
  final _textName = TextEditingController();
  final _textDescription = TextEditingController();
  final _textTimeStart = TextEditingController();
  final _textTimeEnd = TextEditingController();
  final _textNumberMin = TextEditingController();
  final _textNumberMax = TextEditingController();
  final _textTimeRegister = TextEditingController();
  final _textStatus = TextEditingController();
  final _textReason = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _textName,
                decoration: const InputDecoration(
                  labelText: 'Ten hoat dong',
                ),
              ),
              TextField(
                controller: _textDescription,
                decoration: const InputDecoration(
                  labelText: 'Mo ta hoat dong',
                ),
              ),
              TextField(
                controller: _textTimeStart,
                decoration: const InputDecoration(
                  labelText: 'Ngay gio bat dau',
                ),
              ),
              TextField(
                controller: _textTimeEnd,
                decoration: const InputDecoration(
                  labelText: 'Ngay gio ket thuc',
                ),
              ),
              TextField(
                controller: _textNumberMin,
                decoration: const InputDecoration(
                  labelText: 'So luong toi thieu yeu cau',
                ),
              ),
              TextField(
                controller: _textNumberMax,
                decoration: const InputDecoration(
                  labelText: 'So luong toi da yeu cau',
                ),
              ),
              TextField(
                controller: _textTimeRegister,
                decoration: const InputDecoration(
                  labelText: 'Thoi han dang ki',
                ),
              ),
              // TextField(
              //   controller: _textStatus,
              //   decoration: const InputDecoration(
              //     labelText: 'Trang thai',
              //   ),
              // ),
              // TextField(
              //   controller: _textReason,
              //   decoration: const InputDecoration(
              //     labelText: 'Ly do huy hoat dong',
              //   ),
              // ),
              const SizedBox(height: 50),
              CupertinoButton(
                color: Colors.blueAccent,
                child: const Text('Tao moi'),
                onPressed: () {
                  DateTime now = DateTime.now();
                  String formattedDate = DateFormat('yyyy-MM-dd-HH:mm:ssss').format(now);
                  String path = '${AppConstant.activity}/$formattedDate';
                  AppConstant.ref.child(path).set({
                    "idActivity": formattedDate,
                    "nameActivity": _textName.text.trim(),
                    "description": _textDescription.text.trim(),
                    "timeStart": _textTimeStart.text.trim(),
                    "timeEnd": _textTimeEnd.text.trim(),
                    "minNumber": _textNumberMin.text.trim(),
                    "maxNumber": _textNumberMax.text.trim(),
                    "timeRegister": _textTimeRegister.text.trim(),
                    "status": "Dang moi dang ky",
                    "idMember": AppConstant.userMember.idMember,
                    "reason": "",
                  });
                },
              )
            ],
          ),
        ),
      ),
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
