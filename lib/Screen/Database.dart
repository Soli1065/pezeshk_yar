import 'dart:async';
import 'dart:io';
import 'package:jalali_date/jalali_date.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

//import 'CodeNewModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:date_format/date_format.dart';
import 'package:pezeshk_yar/Screen/CodeNewModel.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database _database;

  Future<Database> get database async {
    //if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "TestDB.db");
    return await openDatabase(path, version: 4, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE CodeNew ("
          "id INTEGER PRIMARY KEY,"
          "codeId TEXT,"
          "data TEXT,"
          "date TEXT,"
          "blocked BIT,"
          "day TEXT,"
          "month TEXT,"
          "year TEXT,"
          "name TEXT,"
          "caseNum TEXT,"
          "proRate TEXT,"
          "techRate TEXT,"
          "valueRate TEXT,"
          "time TEXT"
          ")");
    });
  }

  newCodeNew(CodeNew newCodeNew) async {
    final db = await database;
    //get the biggest id in the table
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM CodeNew");
    int id = table.first["id"];
    //insert to the table using the new id
    var raw = await db.rawInsert(
        "INSERT Into CodeNew (id,codeId,data,date,blocked,day,month,year,name,caseNum,proRate,techRate,valueRate,time)"
        " VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?)",
        [
          id,
          newCodeNew.codeId,
          newCodeNew.data.toString(),
          newCodeNew.date.toString(),
          newCodeNew.blocked,
          newCodeNew.day,
          newCodeNew.month,
          newCodeNew.year,
          newCodeNew.name,
          newCodeNew.caseNum,
          newCodeNew.proRate,
          newCodeNew.techRate,
          newCodeNew.valueRate,
          newCodeNew.time
        ]);
    return raw;
  }

  blockOrUnblock(CodeNew codeNew) async {
    final db = await database;
    CodeNew blocked = CodeNew(
        id: codeNew.id,
        codeId: codeNew.codeId,
        data: codeNew.data.toString(),
        date: codeNew.date.toString(),
        blocked: !codeNew.blocked);
    var res = await db.update("CodeNew", blocked.toMap(),
        where: "id = ?", whereArgs: [codeNew.id]);
    return res;
  }

  updateCodeNew(CodeNew newCodeNew) async {
    final db = await database;
    var res = await db.update("CodeNew", newCodeNew.toMap(),
        where: "id = ?", whereArgs: [newCodeNew.id]);
    return res;
  }

  getCodeNew(int id) async {
    final db = await database;
    var res = await db.query("CodeNew", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? CodeNew.fromMap(res.first) : null;
  }

  Future<List<CodeNew>> getBlockedCodeNews() async {
    final db = await database;

    print("works");
    // var res = await db.rawQuery("SELECT * FROM CodeNew WHERE blocked=1");
    var res = await db.query("CodeNew", where: "blocked = ? ", whereArgs: [1]);

    List<CodeNew> list =
        res.isNotEmpty ? res.map((c) => CodeNew.fromMap(c)).toList() : [];
    return list;
  }

  Future<List<CodeNew>> getAllCodeNews() async {
    final db = await database;
    var res = await db.query("CodeNew");
    List<CodeNew> list1 =
        res.isNotEmpty ? res.map((c) => CodeNew.fromMap(c)).toList() : [];

    List<CodeNew> list = list1.reversed.toList();
    return list;
  }

  deleteCodeNew(int id) async {
    final db = await database;
    return db.delete("CodeNew", where: "id = ?", whereArgs: [id]);
  }

  deleteAll() async {
    final db = await database;
    db.rawDelete("Delete * from CodeNew");
  }

  Future<List<CodeNew>> getTodayCodeNews() async {
    final db = await database;

    var _date = new PersianDate.now();
    var _day = _date.day.toString();
    var _month = _date.month.toString();
    var _year = _date.year.toString();
    //String _finalDate = _day + " " + _month + " " + _year;

    //var currentDate = formatDate(DateTime.now(),
    //  [dd, '/', mm, '/', yyyy, ' ', HH, ':', nn]);

    //var res = await db.query("CodeNew", where: "day = ?", whereArgs: [_day],);
    var res = await db.rawQuery(
        'SELECT * FROM CodeNew WHERE day = $_day AND month = $_month AND year = $_year ');
    List<CodeNew> list1 =
        res.isNotEmpty ? res.map((c) => CodeNew.fromMap(c)).toList() : [];

    //List<CodeNew> _today = [];

    List<CodeNew> list = list1.reversed.toList();
    return list;
  }

  Future<List<CodeNew>> getMonthCodeNews() async {
    final db = await database;

    var _date = new PersianDate.now();
    var _day = _date.day.toString();
    var _month = _date.month.toString();
    var _year = _date.year.toString();
    //String _finalDate = _day + " " + _month + " " + _year;

    var currentDate =
        formatDate(DateTime.now(), [dd, '/', mm, '/', yyyy, ' ', HH, ':', nn]);

    //var res = await db.query("CodeNew", where: "month = ?", whereArgs: [_month]);
    var res = await db.rawQuery(
        'SELECT * FROM CodeNew WHERE month = $_month AND year = $_year ');

    List<CodeNew> list1 =
        res.isNotEmpty ? res.map((c) => CodeNew.fromMap(c)).toList() : [];

    //List<CodeNew> _today = [];

    List<CodeNew> list = list1.reversed.toList();
    return list;
  }

  Future<List<CodeNew>> getSearchedCodes(
      String name,
      String caseNum,
      String codeId,
//      String fromDate,
      String yearDate,
      String monthDate,
      String dayDate) async {
    final db = await database;
    String _name = name;
    String _caseNum = caseNum;
    String _codeId = codeId;
//    String _toDate = toDate;
//    String _fromDate = fromDate;
    String _yearDate = yearDate;
    String _monthDate = monthDate;
    String _dayDate = dayDate;
//    String finalDate =
//    var res;








    if (_yearDate.length != 0) {
      if (_name.length == 0) {
        if (_caseNum.length == 0) {
          if (_codeId.length == 0) {
            print(_yearDate + "fromdate");
//            final db = await dayDate;
            final db = await database;
            print(db.rawQuery(_yearDate));
            var res = await db.rawQuery('SELECT * FROM CodeNew WHERE month = $_monthDate AND year = $_yearDate AND day = $_dayDate ');

            List<CodeNew> list1 =
            res.isNotEmpty ? res.map((c) => CodeNew.fromMap(c)).toList() : [];

            List<CodeNew> list = list1.reversed.toList();
            return list;
          }
        }
      }
    }

    if (_yearDate.length == 0) {
      if (_name.length != 0) {
        if (_caseNum.length == 0) {
          if (_codeId.length == 0) {
//            final db = await dayDate;
            final db = await database;
            var res = await db.query(
                "CodeNew", where: "name = ?", whereArgs: [_name]);
            List<CodeNew> list1 =
            res.isNotEmpty ? res.map((c) => CodeNew.fromMap(c)).toList() : [];

            List<CodeNew> list = list1.reversed.toList();
            return list;
          }
        }
      }
    }
    if (_yearDate.length == 0) {
      if (_name.length == 0) {
        if (_caseNum.length != 0) {
          if (_codeId.length == 0) {
//            final db = await dayDate;
            final db = await database;
            var res = await db.query(
                "CodeNew", where: "caseNum = ?", whereArgs: [_caseNum]);
            List<CodeNew> list1 =
            res.isNotEmpty ? res.map((c) => CodeNew.fromMap(c)).toList() : [];

            List<CodeNew> list = list1.reversed.toList();
            return list;
          }
        }
      }
    }
    if (_yearDate.length == 0) {
      if (_name.length == 0) {
        if (_caseNum.length == 0) {
          if (_codeId.length != 0) {
//            final db = await dayDate;
            final db = await database;
            var res = await db.query(
                "CodeNew", where: "codeId = ?", whereArgs: [_codeId]);
            List<CodeNew> list1 =
            res.isNotEmpty ? res.map((c) => CodeNew.fromMap(c)).toList() : [];

            List<CodeNew> list = list1.reversed.toList();
            return list;
          }
        }
      }
    }

    if (_yearDate.length == 0) {
      if (_name.length == 0) {
        if (_caseNum.length != 0) {
          if (_codeId.length != 0) {
//            final db = await dayDate;
            final db = await database;
            var res = await db.rawQuery(
                'SELECT * FROM CodeNew WHERE codeId = $_codeId AND caseNum = $_caseNum  ');
            List<CodeNew> list1 =
            res.isNotEmpty ? res.map((c) => CodeNew.fromMap(c)).toList() : [];

            List<CodeNew> list = list1.reversed.toList();
            return list;
          }
        }
      }
    }

    if (_yearDate.length == 0) {
      if (_name.length != 0) {
        if (_caseNum.length == 0) {
          if (_codeId.length != 0) {
//            final db = await dayDate;
            final db = await database;
            var res = await db.rawQuery(
                'SELECT * FROM CodeNew WHERE codeId = $_codeId AND name = "$_name"');
            List<CodeNew> list1 =
            res.isNotEmpty ? res.map((c) => CodeNew.fromMap(c)).toList() : [];

            List<CodeNew> list = list1.reversed.toList();
            return list;
          }
        }
      }
    }


    if (_yearDate.length == 0) {
      if (_name.length != 0) {
        if (_caseNum.length != 0) {
          if (_codeId.length == 0) {
//            final db = await dayDate;
            final db = await database;
            var res = await db.rawQuery(
                'SELECT * FROM CodeNew WHERE name = "$_name"  AND caseNum = $_caseNum  ');
            List<CodeNew> list1 =
            res.isNotEmpty ? res.map((c) => CodeNew.fromMap(c)).toList() : [];

            List<CodeNew> list = list1.reversed.toList();
            return list;
          }
        }
      }
    }

    if (_yearDate.length == 0) {
      if (_name.length != 0) {
        if (_caseNum.length != 0) {
          if (_codeId.length != 0) {
//            final db = await dayDate;
            final db = await database;
            var res = await db.rawQuery(
                'SELECT * FROM CodeNew WHERE codeId = $_codeId AND caseNum = $_caseNum AND name = "$_name" ');
            List<CodeNew> list1 =
            res.isNotEmpty ? res.map((c) => CodeNew.fromMap(c)).toList() : [];

            List<CodeNew> list = list1.reversed.toList();
            return list;
          }
        }
      }
    }

    if (_yearDate.length != 0) {
      if (_name.length == 0) {
        if (_caseNum.length == 0) {
          if (_codeId.length != 0) {
//            final db = await dayDate;
            final db = await database;
            var res = await db.rawQuery(
                'SELECT * FROM CodeNew WHERE codeId = $_codeId AND year = $_yearDate AND month = $_monthDate AND day = $_dayDate  ');
            List<CodeNew> list1 =
            res.isNotEmpty ? res.map((c) => CodeNew.fromMap(c)).toList() : [];

            List<CodeNew> list = list1.reversed.toList();
            return list;
          }
        }
      }
    }

    if (_yearDate.length != 0) {
      if (_name.length == 0) {
        if (_caseNum.length != 0) {
          if (_codeId.length == 0) {
//            final db = await dayDate;
            final db = await database;
            var res = await db.rawQuery(
                'SELECT * FROM CodeNew WHERE caseNum = $_caseNum AND year = $_yearDate AND month = $_monthDate AND day = $_dayDate  ');
            List<CodeNew> list1 =
            res.isNotEmpty ? res.map((c) => CodeNew.fromMap(c)).toList() : [];

            List<CodeNew> list = list1.reversed.toList();
            return list;
          }
        }
      }
    }


    if (_yearDate.length != 0) {
      if (_name.length == 0) {
        if (_caseNum.length != 0) {
          if (_codeId.length != 0) {
//            final db = await dayDate;
            final db = await database;
            var res = await db.rawQuery(
                'SELECT * FROM CodeNew WHERE codeId = $_codeId AND caseNum = $_caseNum AND year = $_yearDate AND month = $_monthDate AND day = $_dayDate  ');
            List<CodeNew> list1 =
            res.isNotEmpty ? res.map((c) => CodeNew.fromMap(c)).toList() : [];

            List<CodeNew> list = list1.reversed.toList();
            return list;
          }
        }
      }
    }

    if (_yearDate.length != 0) {
      if (_name.length != 0) {
        if (_caseNum.length == 0) {
          if (_codeId.length == 0) {
//            final db = await dayDate;
            final db = await database;
            var res = await db.rawQuery(
                'SELECT * FROM CodeNew WHERE year = $_yearDate AND month = $_monthDate AND day = $_dayDate AND name = "$_name"  ');
            List<CodeNew> list1 =
            res.isNotEmpty ? res.map((c) => CodeNew.fromMap(c)).toList() : [];

            List<CodeNew> list = list1.reversed.toList();
            return list;
          }
        }
      }
    }

    if (_yearDate.length != 0) {
      if (_name.length != 0) {
        if (_caseNum.length == 0) {
          if (_codeId.length != 0) {
//            final db = await dayDate;
            final db = await database;
            var res = await db.rawQuery(
                'SELECT * FROM CodeNew WHERE codeId = $_codeId AND name = "$_name" AND year = $_yearDate AND month = $_monthDate AND day = $_dayDate  ');
            List<CodeNew> list1 =
            res.isNotEmpty ? res.map((c) => CodeNew.fromMap(c)).toList() : [];

            List<CodeNew> list = list1.reversed.toList();
            return list;
          }
        }
      }
    }

    if (_yearDate.length != 0) {
      if (_name.length != 0) {
        if (_caseNum.length != 0) {
          if (_codeId.length == 0) {
//            final db = await dayDate;
            final db = await database;
            var res = await db.rawQuery(
                'SELECT * FROM CodeNew WHERE nqme = "$_name" AND caseNum = $_caseNum  AND year = $_yearDate AND month = $_monthDate AND day = $_dayDate ');
            List<CodeNew> list1 =
            res.isNotEmpty ? res.map((c) => CodeNew.fromMap(c)).toList() : [];

            List<CodeNew> list = list1.reversed.toList();
            return list;
          }
        }
      }
    }

    if (_yearDate.length != 0) {
      if (_name.length != 0) {
        if (_caseNum.length != 0) {
          if (_codeId.length != 0) {
//            final db = await dayDate;
            final db = await database;
            var res = await db.rawQuery(
                'SELECT * FROM CodeNew WHERE codeId = $_codeId AND caseNum = $_caseNum AND name = "$_name" AND year = $_yearDate AND month = $_monthDate AND day = $_dayDate  ');
            List<CodeNew> list1 =
            res.isNotEmpty ? res.map((c) => CodeNew.fromMap(c)).toList() : [];

            List<CodeNew> list = list1.reversed.toList();
            return list;
          }
        }
      }
    }
  }

//    if (_fromDate.length != 0) {
//      if (_name.length != 0) {
//        if (_caseNum.length != 0) {
//          if (_codeId.length != 0) {
//            var res = await db.rawQuery(
//                'SELECT * FROM CodeNew WHERE codeId = $_codeId AND name = $_name AND caseNum = $_caseNum AND date = $_fromDate ');
//            List<CodeNew> list1 = res.isNotEmpty
//                ? res.map((c) => CodeNew.fromMap(c)).toList()
//                : [];
//
//            //List<CodeNew> _today = [];
//            List<CodeNew> list = list1.reversed.toList();
//
//            return list;
//          } else {
//            var res = await db.rawQuery(
//                'SELECT * FROM CodeNew WHERE  name = $_name AND caseNum = $_caseNum  AND date = $_fromDate ');
//            List<CodeNew> list1 = res.isNotEmpty
//                ? res.map((c) => CodeNew.fromMap(c)).toList()
//                : [];
//
//            //List<CodeNew> _today = [];
//            List<CodeNew> list = list1.reversed.toList();
//
//            return list;
//          }
//        } else {
//          var res = await db.rawQuery(
//              'SELECT * FROM CodeNew WHERE name = $_name AND date = $_fromDate');
//          List<CodeNew> list1 =
//              res.isNotEmpty ? res.map((c) => CodeNew.fromMap(c)).toList() : [];
//
//          //List<CodeNew> _today = [];
//
//          List<CodeNew> list = list1.reversed.toList();
//
//          return list;
//        }
//      }
//
//      if (_caseNum.length != 0) {
//        if (_codeId.length != 0) {
//          var res = await db.rawQuery(
//              'SELECT * FROM CodeNew WHERE codeId = $_codeId AND  caseNum = $_caseNum AND date = $_fromDate  ');
//          List<CodeNew> list1 =
//              res.isNotEmpty ? res.map((c) => CodeNew.fromMap(c)).toList() : [];
//
//          //List<CodeNew> _today = [];
//          List<CodeNew> list = list1.reversed.toList();
//
//          return list;
//        } else {
//          var res = await db.rawQuery(
//              'SELECT * FROM CodeNew WHERE caseNum = $_caseNum AND date = $_fromDate ');
//          List<CodeNew> list1 =
//              res.isNotEmpty ? res.map((c) => CodeNew.fromMap(c)).toList() : [];
//
//          //List<CodeNew> _today = [];
//          List<CodeNew> list = list1.reversed.toList();
//
//          return list;
//        }
//      }
//      if (_codeId.length != 0) {
//        var res = await db.rawQuery(
//            'SELECT * FROM CodeNew WHERE codeId = $_codeId AND date = $_fromDate ');
//        List<CodeNew> list1 =
//            res.isNotEmpty ? res.map((c) => CodeNew.fromMap(c)).toList() : [];
//
//        //List<CodeNew> _today = [];
//
//        List<CodeNew> list = list1.reversed.toList();
//
//        return list;
//      }
//      if (_name.length != 0) {
//        if (_codeId.length != 0) {
//          var res = await db.rawQuery(
//              'SELECT * FROM CodeNew WHERE codeId = $_codeId AND  caseNum = $_name AND date = $_fromDate  ');
//          List<CodeNew> list1 =
//              res.isNotEmpty ? res.map((c) => CodeNew.fromMap(c)).toList() : [];
//
//          //List<CodeNew> _today = [];
//          List<CodeNew> list = list1.reversed.toList();
//
//          return list;
//        }
//      }
//
//      if (_name.length != 0) {
//        if (_caseNum.length != 0) {
//          var res = await db.rawQuery(
//              'SELECT * FROM CodeNew WHERE codeId = $_caseNum AND  caseNum = $_name AND date = $_fromDate  ');
//          List<CodeNew> list1 =
//              res.isNotEmpty ? res.map((c) => CodeNew.fromMap(c)).toList() : [];
//
//          //List<CodeNew> _today = [];
//          List<CodeNew> list = list1.reversed.toList();
//
//          return list;
//        }
//      }
//    } else {
//      if (_name.length != 0) {
//        if (_caseNum.length != 0) {
//          if (_codeId.length != 0) {
//            var res = await db.rawQuery(
//                'SELECT * FROM CodeNew WHERE codeId = $_codeId AND name = $_name AND caseNum = $_caseNum  ');
//            List<CodeNew> list1 = res.isNotEmpty
//                ? res.map((c) => CodeNew.fromMap(c)).toList()
//                : [];
//
//            //List<CodeNew> _today = [];
//            List<CodeNew> list = list1.reversed.toList();
//
//            return list;
//          } else {
//            var res = await db.rawQuery(
//                'SELECT * FROM CodeNew WHERE  name = $_name AND caseNum = $_caseNum  ');
//            List<CodeNew> list1 = res.isNotEmpty
//                ? res.map((c) => CodeNew.fromMap(c)).toList()
//                : [];
//
//            //List<CodeNew> _today = [];
//            List<CodeNew> list = list1.reversed.toList();
//
//            return list;
//          }
//        } else {
//          var res =
//              await db.query('CodeNew', where: "name = ?", whereArgs: [_name]);
//          List<CodeNew> list1 =
//              res.isNotEmpty ? res.map((c) => CodeNew.fromMap(c)).toList() : [];
//
//          //List<CodeNew> _today = [];
//
//          List<CodeNew> list = list1.reversed.toList();
//
//          return list;
//        }
//      }
//
//      if (_caseNum.length != 0) {
//        if (_codeId.length != 0) {
//          var res = await db.rawQuery(
//              'SELECT * FROM CodeNew WHERE codeId = $_codeId AND  caseNum = $_caseNum  ');
//          List<CodeNew> list1 =
//              res.isNotEmpty ? res.map((c) => CodeNew.fromMap(c)).toList() : [];
//
//          //List<CodeNew> _today = [];
//          List<CodeNew> list = list1.reversed.toList();
//
//          return list;
//        } else {
//          var res = await db
//              .rawQuery('SELECT * FROM CodeNew WHERE caseNum = $_caseNum  ');
//          List<CodeNew> list1 =
//              res.isNotEmpty ? res.map((c) => CodeNew.fromMap(c)).toList() : [];
//
//          //List<CodeNew> _today = [];
//          List<CodeNew> list = list1.reversed.toList();
//
//          return list;
//        }
//      }
//      if (_codeId.length != 0) {
//        var res = await db
//            .rawQuery('SELECT * FROM CodeNew WHERE codeId = $_codeId  ');
//        List<CodeNew> list1 =
//            res.isNotEmpty ? res.map((c) => CodeNew.fromMap(c)).toList() : [];
//
//        //List<CodeNew> _today = [];
//
//        List<CodeNew> list = list1.reversed.toList();
//
//        return list;
//      }
//    }
//  }
}
