import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:reclamations/presentation/components/InputField.dart';
import 'package:reclamations/presentation/ressources/dimensions/constants.dart';
import 'package:reclamations/presentation/ressources/routes/router.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(

      child: Scaffold(

        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Container(
                height: Constants.screenHeight * 0.9,

                child: Column(
                  children: [
                    Container(
                        height: Constants.screenHeight * 0.25,
                        alignment: Alignment.center,
                        child: Lottie.asset("assets/lotties/login.json",
                            repeat: false)),
                    Inputfield(
                      controller: emailController,
                      label: "Email",
                      prefixIcon: Icon(Icons.email),
                      textInputType: TextInputType.emailAddress,
                    ),
                    Inputfield(
                      controller: passwordController,
                      label: "Mot de passe",
                      prefixIcon: Icon(Icons.lock),
                      textInputType: TextInputType.visiblePassword,
                    ),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5))),
                          onPressed: () {
                            if(formKey.currentState!.validate()){
                              Navigator.pushNamed(context, AppRouting.clientHome);
                            }
                          },
                          child: Text(
                            "Connecter",
                            style: TextStyle(color: Colors.white,fontFamily: "Raleway-medium"),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(

                          onTap: () {
                            Navigator.pushNamed(context, AppRouting.resetPassword);
                          },
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: Text(

                              "Mot de passe oublié ?",
                              style: TextStyle(color: Colors.blueAccent,fontFamily: "Raleway-medium"),

                            ),
                          )),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.bottomCenter,
                          child: GestureDetector(
                              onTap: (){
                                Navigator.pushNamed(context, AppRouting.signUp);

                              },
                              child: Text("Créer un compte",style: TextStyle(color: Colors.blueAccent,fontFamily: "Raleway-medium")))),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
