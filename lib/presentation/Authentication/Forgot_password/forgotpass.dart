import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:reclamations/presentation/components/InputField.dart';

import '../../../models/snack_bar_types.dart';
import '../../../services/AuthServices.dart';
import '../../components/snack_bar.dart';
import '../../ressources/colors.dart';
import '../../ressources/dimensions/constants.dart';


//import 'homescreen.dart';

final _formkey = GlobalKey<FormState>();

class ForgotPassScreen extends StatefulWidget {
  const ForgotPassScreen({Key? key}) : super(key: key);

  @override
  _ForgotPassScreenState createState() => _ForgotPassScreenState();
}

class _ForgotPassScreenState extends State<ForgotPassScreen> {
  TextEditingController emailController = TextEditingController();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.primary,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ), // Change this icon to your desired back button icon
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Form(
                  child: Column(children: [
                Container(
                  height: Constants.screenHeight * 0.4,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
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
                        child: Text(
                          'Restaurer votre mot de passe ',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              //  fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic),
                        ),
                      )
                    ],
                  )),
                ),
                SizedBox(height: 30),
                Form(
                  key: _formkey,
                  child: Inputfield(
                      label: 'Email',
                      controller: emailController,
                      textInputType: TextInputType.emailAddress,
                      prefixIcon: Icon(Icons.email)),
                ),
                SizedBox(
                  height: 30,
                ),
                loading
                    ? CircularProgressIndicator()
                    : Container(
                    padding:  EdgeInsets.symmetric(vertical: Constants.screenHeight* 0.01,horizontal: Constants.screenWidth * 0.01),

                    child: Row(
                          children: [
                            Expanded(
                                child: ElevatedButton(
                                    child: Text('Envoyer', style: TextStyle(color: Colors.white, fontStyle: FontStyle.italic)),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blueAccent,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                    ),
                                    onPressed: () {
                                      if (_formkey.currentState!.validate()) {
                                        setState(() {
                                          loading = true;
                                        });
                                        AuthServices().resetPassword(emailController.text).then((value) {
                                          setState(() {
                                            loading = false;
                                          });
                                          if (value) {
                                            SnackBars(
                                                    label: "Consulter votre mail",
                                                    type: SnackBarsTypes.success,
                                                    onTap: () {},
                                                    actionLabel: "Fermer",
                                                    context: context)
                                                .showSnackBar();
                                          } else {
                                            SnackBars(
                                                    label: "compte n'existe pas",
                                                    type: SnackBarsTypes.alert,
                                                    onTap: () {},
                                                    actionLabel: "Fermer",
                                                    context: context)
                                                .showSnackBar();
                                          }
                                        });
                                      }
                                    }))
                          ],
                        )),
              ])))),
    );
  }
}
