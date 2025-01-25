import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reclamations/presentation/ressources/dimensions/constants.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.red,
          width: Constants.screenWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                icon: Icon(Icons.password,color: Colors.white,),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)
                  ),
                  ),
                  onPressed: (){
                Navigator.pushNamed(context, "/reset_password");
              }, label: Text("Go To RESET PASSWORD",style: TextStyle(color: Colors.white),)),
              ElevatedButton.icon(
                icon: Icon(Icons.password,color: Colors.white,),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)
                  ),
                  ),
                  onPressed: (){
                Navigator.pushNamed(context, "/sign_up");
              }, label: Text("Sign up",style: TextStyle(color: Colors.white),)),
            ],
          ),
        ),
      ),
    );
  }
}
