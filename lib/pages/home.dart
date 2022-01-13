import 'package:cake_factory/repo/db.dart';
import 'package:cake_factory/utils/colors.dart';
import 'package:flutter/material.dart';

import 'package:cake_factory/services/cake.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<Cake> cakes = [];
  DB db = DB();
  int runs = 0;

  void editCake(index) async {
      Cake instance = index == -1 ? Cake() : cakes[index];
      //push
      dynamic result = await Navigator.pushNamed(context, '/cake_factory', arguments: {
        'cake': instance
      });

      try{
        if(result['type'] == 'add'){
          await db.insertCake([result['cake']]);
          List<Cake> newCakes = await db.retrieveCakes();
          setState(() {
            cakes = newCakes;
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Added!')),
            );
          });
        }else if(result['type'] == 'update'){
          await db.updateCake(result['cake']);
          cakes[index] = result['cake'];
          List<Cake> newCakes = await db.retrieveCakes();
          setState(() {
            cakes[index] = result['cake'];
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Updated!')),
            );
          });
        }
      }catch(e){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Not set!')),
        );
        print(e.toString());
      }
  }
  Future<void> deleteCake(index) async {
    Cake instance = cakes[index];
    cakes.removeAt(index);
    await db.deleteCake(instance.id);//not the same as index -> the db id
    cakes = await db.retrieveCakes();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Deleted!')),
    );

  }

  @override
  Widget build(BuildContext context) {
     if (runs == 0) {
       dynamic data = ModalRoute.of(context)?.settings.arguments as Map;
       cakes = data['cakes'];
       db = data['db'];
     }
     runs += 1;

     return Scaffold(
       backgroundColor: AppColors.lightBackground,

       body: ListView.builder(
           itemCount: cakes.length,
           itemBuilder: (context, index) {
             return Padding(
               padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
               child: Card(
                 color: AppColors.darkBackground,
                 child: ListTile(
                   onTap: () {
                     editCake(index);
                   },
                   leading: CircleAvatar(
                     backgroundImage: AssetImage('assets/${cakes[index].dimension.toString().split('.')[1]}.png'),
                   ),
                   title: Text(cakes[index].name, style: TextStyle(color: AppColors.text),),
                   subtitle: Text(cakes[index].dimension.toString().split('.')[1],style: TextStyle(color: AppColors.text),),
                   trailing: IconButton(
                     icon: const Icon(Icons.delete_outline),
                     onPressed: () {
                       setState(() {
                         deleteCake(index);
                       });
                     },
                   ),
                 ),
               ),
             );
           }
       ),
       floatingActionButton: FloatingActionButton(
         onPressed: () {
           editCake(-1);
         },
         backgroundColor: AppColors.darkBackground,
         child: const Icon(Icons.add),
       ),
     );
  }
}
