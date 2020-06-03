import 'package:factory2homes/repository/db_connection.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';

class Repository {
  DatabaseConnection _connection;
  String _baseUrl = 'https://androidapp.factory2homes.com/api';

  Repository() {
    _connection = DatabaseConnection();
  }

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _connection.initDatabase();

    return _database;
  }

  saveLocal(table, data) async {
    var conn = await database;
    return await conn.insert(table, data);
  }

  httpGet(String api) async {
    return http.get(_baseUrl + '/' + api);
  }

  httpGetById(String api, id) async {
    return await http.get(_baseUrl + "/" + api + "/" + id.toString());
  }

  httpGetBySliderId(String api, carouselSliderId) async {
    return await http
        .get(_baseUrl + "/" + api + "/" + carouselSliderId.toString());
  }

  getLocalByCondition(table, columnName, conditionalVale) async {
    var conn = await database;
    return await conn.rawQuery(
        'SELECT * FROM $table WHERE $columnName=?', ['$conditionalVale']);
  }

  updateLocal(table, columnName, data) async {
    var conn = await database;
    return await conn.update(table, data,
        where: "$columnName=?", whereArgs: [data['productId']]);
  }

  getAllLocal(table) async {
    var conn = await database;
    return await conn.query(table);
  }

  deleteLocalById(table, id) async {
    var conn = await database;
    return await conn.rawDelete("DELETE FROM $table WHERE id = $id");
  }

  deleteLocal(table) async {
    var conn = await database;
    return await conn.rawDelete("DELETE FROM $table");
  }

  httpPost(String api, data) async {
    return await http.post(_baseUrl + "/" + api, body: data);
  }


}
