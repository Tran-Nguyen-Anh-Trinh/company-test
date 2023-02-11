import 'package:firebase_database/firebase_database.dart';

class Activity {
  String? idActivity;
  String? nameActivity;
  String? descriptionActivity;
  String? timeStart;
  String? timeEnd;
  String? minNumber;
  String? maxNumber;
  String? timeRegister;
  String? status;
  String? idMember;
  String? reason;
  Activity({
    this.idActivity,
    this.nameActivity,
    this.descriptionActivity,
    this.timeStart,
    this.timeEnd,
    this.minNumber,
    this.maxNumber,
    this.timeRegister,
    this.status,
    this.idMember,
    this.reason,
  });

  factory Activity.fromSnapshot(Map<String, dynamic> json) {
    return Activity(
      idActivity: json['idActivity'],
      nameActivity: json['nameActivity'],
      descriptionActivity: json['description'],
      maxNumber: json['maxNumber'],
      minNumber: json['minNumber'],
      reason: json['reason'],
      status: json['status'],
      timeEnd: json['timeEnd'],
      timeRegister: json['timeRegister'],
      timeStart: json['timeStart'],
      idMember: json['idMember']
    );
  }
}
