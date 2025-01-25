import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../ressources/colors.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        centerTitle: true,
        title: Text("Créer un compte",style: TextStyle(color: Colors.white,fontFamily: "Raleway-medium"),),
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios,color: Colors.white,)),

      ),
      body: Column(
        children: [
          Expanded(
              flex: 4,
              child: Box()),
          Expanded(
              flex: 2,
              child: Box()),
          Expanded(child: Box()),
          Expanded(child: Box()),

        ],
      ),
    );
  }
}




class Box extends StatelessWidget {
  const Box({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
      decoration:BoxDecoration(
          color: Colors.red,
        borderRadius: BorderRadius.all(Radius.circular(5))
      ) ,
      height: 70,width: double.infinity,),
    );
  }
}
