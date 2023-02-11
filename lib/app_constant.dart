import 'package:company_test/model/member.dart';
import 'package:firebase_database/firebase_database.dart';

class AppConstant {
  static DatabaseReference ref = FirebaseDatabase.instance.ref();
  static String activity = 'activity';
  static Member userMember = Member('002', 'trinhtna', '01/09/2001', 'trinhtrandoi10@gmail.com', '0343440509');
}
