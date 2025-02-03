import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:reclamations/models/snack_bar_types.dart';
import 'package:reclamations/presentation/components/InputField.dart';
import 'package:reclamations/presentation/components/snack_bar.dart';
import 'package:reclamations/presentation/ressources/colors.dart';
import 'package:reclamations/presentation/ressources/dimensions/constants.dart';
import 'package:reclamations/presentation/ressources/routes/router.dart';
import 'package:reclamations/services/AuthServices.dart';


class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<SignInScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final _formkey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<bool> avoidReturnButton() async {
    showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            content: Text("vous etes sur de sortir ?"),
            actions: [Negative(context), Positive()],
          );
        });
    return true;
  }

  Widget Positive() {
    return Container(
      decoration: BoxDecoration(color: Colors.blueAccent),
      child: TextButton(
          onPressed: () {
            exit(0);
          },
          child: const Text(
            " Oui",
            style: TextStyle(
              color: Color(0xffEAEDEF),
            ),
          )),
    );
  }

  Widget Negative(BuildContext context) {
    return TextButton(
        onPressed: () {
          Navigator.pop(context); // fermeture de dialog
        },
        child: Text(" Non"));
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: avoidReturnButton,
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Form(
                key: _formkey,
                child: SizedBox(
                  height: Constants.screenHeight * 0.95,
                  child: Column(
                      children: [
                    Container(
                      height: Constants.screenHeight * 0.4,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent.withOpacity(0.5),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(90),
                        ),
                      ),
                      child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Lottie.asset("assets/lotties/login.json", height: Constants.screenHeight * 0.2),
                              Container(
                                margin: EdgeInsets.only(top: 20),
                                child: Text(
                                  'Se Connecter ',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      //  fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic),
                                ),
                              )
                            ],
                          )),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: Constants.screenHeight * 0.1),
                      child: Inputfield(
                        label: "Email",
                        controller: emailController,
                        textInputType: TextInputType.emailAddress,
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                    Inputfield(
                      label: "Mot de passe",
                      controller: passwordController,
                      textInputType: TextInputType.visiblePassword,
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.blueAccent,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(

                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: (){
                            Navigator.pushNamed(context, "jjd");
                          },
                          child: Text(
                            "mot de passe oublié?",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.black54,
                                //fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    isLoading
                        ? CircularProgressIndicator()
                        : Container(
                        padding:  EdgeInsets.symmetric(vertical: Constants.screenHeight* 0.01,horizontal: Constants.screenWidth * 0.01),

                        child: Row(
                          children: [
                            Expanded(
                                child: ElevatedButton(
                                    child:
                                    Text('Connexion', style: TextStyle(color: Colors.white, fontStyle: FontStyle.italic)),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blueAccent,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                    ),
                                    onPressed: () {
                                      if (_formkey.currentState!.validate()) {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        AuthServices()
                                            .signIn(emailController.text, passwordController.text)
                                            .then((value) async {
                                          if (value) {
                                            AuthServices().getUserData().then((value) {
                                              AuthServices().saveUserLocally(value).then((value2) {
                                                if (value.role == 'client') {
                                                  if (value.status != 1) {
                                                    //deleted account
                                                  } else {
                                                    print("client here");
                                                    // client screen
                                                  }
                                                } else {
                                                  print("admin here");
                                                  // admin screen
                                                }
                                                setState(() {
                                                  isLoading = false;
                                                });
                                              });
                                            });
                                          } else {
                                            SnackBars(
                                                label: "Verifier l'email et le mot de passe",
                                                type: SnackBarsTypes.alert,
                                                onTap: () {},
                                                actionLabel: "Fermer",
                                                context: context)
                                                .showSnackBar();
                                            setState(() {
                                              print('set value');
                                              isLoading = false;
                                            });
                                          }
                                        });
                                      }
                                    }))
                          ],
                        )),

                    Expanded(
                      child: Container(
                        alignment: Alignment.bottomCenter,
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          child: Row(
                            children: [
                              Expanded(
                                  child: TextButton(
                                    style: ButtonStyle(
                                      overlayColor: MaterialStateProperty.all(Colors.transparent),
                                    ),
                                    child: Text("Besoin d'un nouveau compte?",
                                        style: TextStyle(color:  Colors.blueAccent, fontSize: 14, fontStyle: FontStyle.italic)),
                                    onPressed: () {
                                      Navigator.pushNamed(context, AppRouting.signUp);
                                    },
                                  ))
                            ],
                          )),
                    ),
                  ]),
                )),
          )),
    );
  }
}
