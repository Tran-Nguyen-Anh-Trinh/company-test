import 'package:company_test/app_constant.dart';
import 'package:company_test/model/join.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

class ReviewPage extends StatefulWidget {
  ReviewPage({super.key, required this.join});
  Join join;

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  final _textDateTimeRegister = TextEditingController();
  final _textPointLead = TextEditingController();
  final _textPoint1 = TextEditingController();
  final _textPoint2 = TextEditingController();
  final _textPoint3 = TextEditingController();
  final _textComment = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _textDateTimeRegister.text = widget.join.dateTimeRegister ?? '';
    _textPointLead.text = widget.join.pointLead ?? '';
    _textPoint1.text = widget.join.point1 ?? '';
    _textPoint2.text = widget.join.point2 ?? '';
    _textPoint3.text = widget.join.point3 ?? '';
    _textComment.text = widget.join.comment ?? '';
    print(widget.join.dateTimeRegister);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                enabled: false,
                controller: _textDateTimeRegister,
                decoration: const InputDecoration(
                  labelText: 'Ngay gio dang ki',
                ),
              ),
              TextField(
                controller: _textPointLead,
                decoration: const InputDecoration(
                  labelText: 'Diem truong doan',
                ),
              ),
              TextField(
                controller: _textPoint1,
                decoration: const InputDecoration(
                  labelText: 'Diem tieu chi 1',
                ),
              ),
              TextField(
                controller: _textPoint2,
                decoration: const InputDecoration(
                  labelText: 'Diem tieu chi 2',
                ),
              ),
              TextField(
                controller: _textPoint3,
                decoration: const InputDecoration(
                  labelText: 'Diem tieu chi 3',
                ),
              ),
              TextField(
                controller: _textComment,
                decoration: const InputDecoration(
                  labelText: 'Nhan xet khac',
                ),
              ),
              const SizedBox(height: 50),
              CupertinoButton(
                color: Colors.blueAccent,
                child: const Text('Danh gia'),
                onPressed: () {
                  String path = 'join/${widget.join.idJoin}';
                  final join = Join(
                    idJoin: widget.join.idJoin,
                    idMemberJoin: widget.join.idMemberJoin,
                    idActivity: widget.join.idActivity,
                    dateTimeRegister: widget.join.dateTimeRegister,
                    point1: _textPoint1.text.trim(),
                    point2: _textPoint2.text.trim(),
                    point3: _textPoint3.text.trim(),
                    pointLead: _textPointLead.text.trim(),
                    comment: _textComment.text.trim(),
                  );
                  AppConstant.ref.child(path).update(join.toJson());
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
