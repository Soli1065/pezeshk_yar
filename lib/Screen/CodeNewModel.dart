import 'dart:convert';

CodeNew codeNewFromJson(String str) {
  final jsonData = json.decode(str);
  return CodeNew.fromMap(jsonData);
}

String codeNewToJson(CodeNew data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class CodeNew {
  int id;
  String codeId;
  String data;
  String date;
  bool blocked;
  String day;
  String month;
  String year;
  String time;
  String name;
  String caseNum;
  String proRate;
  String techRate;
  String valueRate;

  CodeNew({
    this.id,
    this.data,
    this.date,
    this.blocked,
    this.codeId,
    this.year,
    this.time,
    this.month,
    this.day,
    this.name,
    this.caseNum,
    this.proRate,
    this.valueRate,
    this.techRate
  });

  factory CodeNew.fromMap(Map<String, dynamic> json) => new CodeNew(
    id: json["id"],
    data: json["data"],
    date: json["date"],
    blocked: json["blocked"] == 1,
    codeId: json["codeId"],
    name: json["name"],
    caseNum: json["caseNum"],
    proRate: json["proRate"],
    techRate: json["techRate"],
    valueRate: json["valueRate"],
    time: json["time"]
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "data": data,
    "date": date,
    "blocked": blocked,
    "codeId": codeId,
    "name": name,
    "caseNum": caseNum,
    "proRate": proRate,
    "techRate": techRate,
    "valueRate": valueRate,
    "time": time
  };
}
