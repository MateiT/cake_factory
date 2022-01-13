import 'package:cake_factory/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:cake_factory/services/cake.dart';


class MakeCake extends StatefulWidget {
  const MakeCake({Key? key}) : super(key: key);

  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<MakeCake> {

  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController spongeController = TextEditingController();
  TextEditingController creamController = TextEditingController();
  TextEditingController toppingController = TextEditingController();

  Cake cake = Cake();

  @override
  Widget build(BuildContext context) {
    if (cake.name == '') {
      dynamic data = ModalRoute.of(context)?.settings.arguments as Map;
      cake = data['cake'];
    }

    nameController.text = cake.name;
    spongeController.text = cake.sponge;
    creamController.text = cake.cream;
    toppingController.text = cake.topping;

    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: AppColors.darkBackground,
        title: Text('Choose a Location', style: TextStyle(color: AppColors.text),),
        centerTitle: true,
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: nameController,
                style: TextStyle(color: AppColors.text),
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Cake name',
                ),
                onChanged: (String? value) {
                  cake.name = value!;
                },
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              SizedBox(height: 28.0,),
              TextFormField(
                controller: creamController,
                style: TextStyle(color: AppColors.text),
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Cream',
                ),
                onChanged: (String? value) {
                  cake.cream = value!;
                },
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              SizedBox(height: 28.0,),
              TextFormField(
                controller: spongeController,
                style: TextStyle(color: AppColors.text),
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Sponge',
                ),
                onChanged: (String? value) {
                  cake.sponge = value!;
                },
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              SizedBox(height: 28.0,),
              TextFormField(
                controller: toppingController,
                style: TextStyle(color: AppColors.text),
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Topping',
                ),
                onChanged: (String? value) {
                  cake.topping = value!;
                },
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              SizedBox(height: 28.0,),
              Row(
                children: <Widget>[
                  DropdownButton<Dimension>(
                    value: cake.dimension,
                    dropdownColor: AppColors.darkBackground,
                    items: <Dimension>[Dimension.small, Dimension.medium, Dimension.large, Dimension.weddingSized].map((Dimension value) {
                      return DropdownMenuItem<Dimension>(
                        value: value,

                        child: Text(value.toString().split('.')[1], style: TextStyle(color: AppColors.text),),
                      );
                    }).toList(),
                    onChanged: (Dimension? newValue) {
                      setState(() {
                        cake.dimension = newValue!;
                      });
                    },
                  ),
                  const Spacer(), // use Spacer
                  DropdownButton<Shape>(
                    value: cake.shape,
                    dropdownColor: AppColors.darkBackground,
                    items: <Shape>[Shape.round, Shape.rectangular].map((Shape value) {
                      return DropdownMenuItem<Shape>(
                        value: value,
                        child:Text(value.toString().split('.')[1], style: TextStyle(color: AppColors.text),),
                      );
                    }).toList(),
                    onChanged: (Shape? newValue) {
                      setState(() {
                        cake.shape = newValue!;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 28.0,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: AppColors.darkBackground,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                ),
                onPressed: () {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState!.validate()) {
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    Navigator.pop(context, {
                      'type': 'add',
                      'cake': Cake(name: nameController.text, cream: creamController.text, sponge: spongeController.text,
                        topping: toppingController.text, dimension: cake.dimension, shape: cake.shape),
                    });
                  }else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Invalid data')),
                    );
                  }
                },
                child: Text('Add', style: TextStyle(color: AppColors.text),),
              ),
              SizedBox(height: 28.0,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: AppColors.darkBackground,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                ),
                onPressed: () {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState!.validate()) {
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    Navigator.pop(context, {
                      'type': 'update',
                      'cake': Cake(name: nameController.text, cream: creamController.text, sponge: spongeController.text,
                          topping: toppingController.text, dimension: cake.dimension, shape: cake.shape),
                    });
                  }else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Invalid data')),
                    );
                  }
                },
                child: Text('Update', style: TextStyle(color: AppColors.text),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
