class Join {
  String? idMemberJoin;
  String? idActivity;
  String? dateTimeRegister;
  String? pointLead;
  String? point1;
  String? point2;
  String? point3;
  String? comment;
  String? idJoin;

  Join(
      {this.idMemberJoin,
      this.idActivity,
      this.dateTimeRegister,
      this.point1,
      this.point2,
      this.point3,
      this.pointLead,
      this.comment,
      this.idJoin});

  Map<String, dynamic> toJson() {
    return {
      'idMemberJoin': idMemberJoin,
      'idActivity': idActivity,
      'dateTimeRegister': dateTimeRegister,
      'point1': point1,
      'point2': point2,
      'point3': point3,
      'pointLead': pointLead,
      'comment': comment,
      'idJoin': idJoin
    };
  }

  factory Join.fromSnapshot(Map<String, dynamic> json) {
    return Join(
      idActivity: json['idActivity'],
      comment: json['comment'],
      idMemberJoin: json['idMemberJoin'],
      point1: json['point1'],
      point2: json['point2'],
      point3: json['point3'],
      pointLead: json['pointLead'],
      dateTimeRegister: json['dateTimeRegister'],
      idJoin: json['idJoin'],
    );
  }
}
