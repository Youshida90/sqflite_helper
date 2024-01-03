import 'package:collection/collection.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class SqflitehelperNew {
  late final Database database;

  SqflitehelperNew() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  Future<Database> createDatabase({
    required String databasefilename,
    required String tablename,
    required List<Map<String, String>> columns,
    required int version,
  }) async {
    database = await openDatabase(
      databasefilename,
      version: version,
      onCreate: (database, version) {
        // ignore: avoid_print
        print('database created');
        String columnDefinitions = columns
            .map((column) => '${column['name']} ${column['type']}')
            .join(', ');
        database
            .execute('CREATE TABLE $tablename($columnDefinitions)')
            .then((value) {
          // ignore: avoid_print
          print('table created');
        }).catchError((error) {
          // ignore: avoid_print
          print('error when creating table ${error.toString()}');
        });
      },
      onOpen: (db) {
        // ignore: avoid_print
        print('database opened');
      },
    );
    return database;
  }

  Future<void> insert({
    required String tablename,
    required Map<String, dynamic> data,
  }) async {
    final keys = data.keys.join(', ');
    final values = data.values.map((value) => "'$value'").join(', ');
    await database
        .transaction(
      (txn) => txn.rawInsert('INSERT INTO $tablename('
          '$keys) VALUES($values)'),
    )
        .then((value) {
      // ignore: avoid_print
      print('$value inserted successfully');
    }).catchError((error) {
      // ignore: avoid_print
      print('error when inserting data ${error.toString()}');
    });
  }

  Future<List<Map>> getdatafromdatabase({
    required String tablename,
    String? columnname,
  }) async {
    try {
      String selectStatement = columnname != null
          ? 'SELECT $columnname FROM $tablename'
          : 'SELECT * FROM $tablename';
      List<Map> list = await database.rawQuery(selectStatement);
      // ignore: avoid_print
      print(list);
      bool isEqual = const DeepCollectionEquality().equals(list, []);
      // ignore: avoid_print
      print('Are the lists equal? $isEqual');
      return list;
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      return [];
    }
  }

  Future<int> countRecords(String tablename) async {
    try {
      int? count = Sqflite.firstIntValue(
          await database.rawQuery('SELECT COUNT(*) FROM $tablename'));
      // ignore: avoid_print
      print('Count: $count');
      return count ?? 0;
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      return 0;
    }
  }

  Future<int> deleteRecord(
      String tablename, String columnname, String value) async {
    try {
      int count = await database
          .rawDelete('DELETE FROM $tablename WHERE $columnname = ?', [value]);
      // ignore: avoid_print
      print('Deleted: $count');
      return count;
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      return 0;
    }
  }

  Future<int> updateRecord({
    required String tablename,
    required Map<String, dynamic> newData,
    required String whereColumn,
    required String oldValue,
  }) async {
    try {
      List<String> setClauses =
          newData.entries.map((e) => '${e.key} = ?').toList();
      String setClause = setClauses.join(', ');

      List<dynamic> values = newData.values.toList();
      values.add(oldValue);

      int count = await database.rawUpdate(
        'UPDATE $tablename SET $setClause WHERE $whereColumn = ?',
        values,
      );
      // ignore: avoid_print
      print('Updated: $count');
      return count;
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      return 0;
    }
  }
}
