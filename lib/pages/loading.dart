import 'package:cake_factory/repo/db.dart';
import 'package:cake_factory/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cake_factory/services/cake.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  DB db = DB();
  void setupCakes() async  {
    await db.createCakeTable();
    await db.addCakes();
    List<Cake> cakes = await db.retrieveCakes();
    //print(await db.retrieveLastCakeId());
    await Future.delayed(const Duration(seconds: 3));
    //Navigator.pushReplacementNamed(context, '/home');
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'cakes': cakes,
      'db': db
    });
  }

  @override
  void initState() {
    super.initState();
    setupCakes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: Center(
        child: SpinKitRotatingCircle(
          color: AppColors.darkBackground,
          size: 50.0,
        )
      )
    );
  }
}

