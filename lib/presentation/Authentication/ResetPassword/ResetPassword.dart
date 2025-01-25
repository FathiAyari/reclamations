import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reclamations/presentation/ressources/colors.dart';

class Resetpassword extends StatefulWidget {
  const Resetpassword({super.key});

  @override
  State<Resetpassword> createState() => _ResetpasswordState();
}

class _ResetpasswordState extends State<Resetpassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        centerTitle: true,
        title: Text("Mot de passe oublié",style: TextStyle(color: Colors.white,fontFamily: "Raleway-medium"),),
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios,color: Colors.white,)),

      ),
    );
  }
}
