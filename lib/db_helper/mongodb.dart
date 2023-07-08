import 'dart:developer';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:open_mongos/db_helper/constant.dart';
import 'package:open_mongos/model/user_model.dart';

class MongoDatabase {
  static var db, userCollection;

  static connect() async {
    db = await Db.create(MONO_CONNECT_URL);
    await db.open();
    inspect(db);
    userCollection = db.collection(USER_COLLECTION);
  }

  static Future<List<Map<String,dynamic>>> getData() async {
    var arrData = await userCollection.find().toList();
    return arrData;
  }

  static Future<String> insert({required UserModel data}) async {
    try {
      var result = await userCollection.insertOne(data.toJson());
      if(result.isSucess){
        return "Data Inserted";
      }
      return "Something wrong while inserting data";
    } catch (e) {
      log("error: $e");
      return e.toString();
    }
  }
}
