import 'package:cake_factory/services/cake.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class DB {
  //List<Cake> cakes = [];

  DB(){
    // cakes.add(Cake(name: 'Tort de ciocolata', cream: 'mouse', sponge: 'pandispan',
    //     topping: 'ciocolata topita', dimension: Dimension.large, shape: Shape.rectangular));
    // cakes.add(Cake(name: 'Tiramisu', cream: 'mascarpone', sponge: 'piscoturi',
    //     topping: 'cacao', dimension: Dimension.medium, shape: Shape.rectangular));
  }
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'identifier.sqlite'),
      version: 1,
    );
  }
  Future<int> insertCake(List<Cake> cakes) async {
    int result = 0;
    final Database db = await initializeDB();
    for(var cake in cakes){
      try{
        result = await db.insert('cakes', cake.toMap());
      }catch(e){
        result = 0;
      }
    }
    return result;
  }

  Future<int> addCakes() async {
    Cake firstCake = Cake(id : 1, name : 'Tort de ciocolata', cream : 'mousse de ciocolata neagra', sponge : 'cu ciocolata',
        topping : 'ciocolata topita', dimension : Dimension.medium, shape : Shape.round);
    Cake secondCake = Cake(id : 2, name : 'Tiramisu', cream : 'frisca + mascarpone', sponge : 'piscoturi',
        topping : 'cacao', dimension : Dimension.large, shape : Shape.rectangular);
    Cake thirdCake = Cake(id : 3, name : 'Briosa', cream : 'nu are', sponge : 'pandispan',
        topping : 'bomboane', dimension : Dimension.small, shape : Shape.round);
    Cake fourthCake = Cake(id : 4, name : 'Tort cu fructe', cream : 'de vanilie', sponge : 'vanilie si fistic',
        topping : 'martipan', dimension : Dimension.weddingSized, shape : Shape.round);

    List<Cake> listOfUsers = [firstCake, secondCake, thirdCake, fourthCake];

    return await insertCake(listOfUsers);
  }

  Future<List<Cake>> retrieveCakes() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query('cakes');
    return queryResult.map((e) => Cake.fromMap(e)).toList();
  }

  Future<String> retrieveLastCakeId() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query('cakes');
    return queryResult[queryResult.length - 1]['id'].toString();
  }

  Future<void> deleteCake(int id) async {
    final db = await initializeDB();
    await db.delete(
      'cakes',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<void> updateCake(Cake cake) async {
    final db = await initializeDB();
    await db.update(
      'cakes',
      cake.toMap(),
      where: 'id = ?',
      whereArgs: [cake.id],
    );
  }

  Future<void> createCakeTable() async {
    final db = await initializeDB();
    try{
      await db.execute(
        "CREATE TABLE cakes(id INTEGER PRIMARY KEY AUTOINCREMENT, " +
            "name TEXT NOT NULL, cream INTEGER NOT NULL, sponge TEXT NOT NULL, " +
            "topping TEXT NOT NULL, dimension TEXT NOT NULL, shape TEXT NOT NULL)",
      );
      await addCakes();
    // ignore: empty_catches
    }catch(e){
    }
  }
}