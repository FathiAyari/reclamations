import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:reclamations/models/snack_bar_types.dart';
import 'package:reclamations/presentation/components/InputField.dart';
import 'package:reclamations/presentation/components/snack_bar.dart';
import 'package:reclamations/presentation/ressources/colors.dart';
import 'package:reclamations/presentation/ressources/dimensions/constants.dart';
import 'package:reclamations/presentation/ressources/routes/router.dart';
import 'package:reclamations/services/AuthServices.dart';


class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool loading = false;
  String role = 'client';
  final _formkey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passWordController = TextEditingController();

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
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Container(
                          height: Constants.screenHeight * 0.2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(90),
                            ),
                            color: AppColors.primary,
                          ),
                          child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Lottie.asset("assets/lotties/login.json", height: Constants.screenHeight * 0.2),
                                ],
                              )),
                        ),
                      ),
                      Inputfield(
                        label: "Nom ",
                        controller: nameController,
                        textInputType: TextInputType.text,
                        prefixIcon: Icon(
                          Icons.account_circle_outlined,
                          color: Colors.indigo,
                        ),
                      ),
                      Inputfield(
                        label: "Prénom ",
                        controller: lastNameController,
                        textInputType: TextInputType.text,
                        prefixIcon: Icon(
                          Icons.account_circle_outlined,
                          color: Colors.indigo,
                        ),
                      ),
                      Inputfield(
                        label: "Email",
                        controller: emailcontroller,
                        textInputType: TextInputType.emailAddress,
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.indigo,
                        ),
                      ),
                      Inputfield(
                        label: "Numéro portable",
                        controller: phoneNumberController,
                        textInputType: TextInputType.phone,
                        prefixIcon: Icon(
                          Icons.phone,
                          color: Colors.indigo,
                        ),
                      ),
                      Inputfield(
                        label: "Mot de passe",
                        controller: passWordController,
                        textInputType: TextInputType.visiblePassword,
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.indigo,
                        ),
                      ),
                      loading
                          ? CircularProgressIndicator()
                          : Container(
                          padding:  EdgeInsets.symmetric(vertical: Constants.screenHeight* 0.01,horizontal: Constants.screenWidth * 0.01),
                          child: Row(
                            children: [
                              Expanded(
                                  child: ElevatedButton(
                                      child: Text(
                                        'S\'inscrire',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontStyle: FontStyle.italic, // fontWeight: FontWeight.bold )
                                        ),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.primary,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(10), // Adjust the value to change the border radius
                                        ),
                                      ),
                                      onPressed: () async {
                                        if (_formkey.currentState!.validate()) {
                                          setState(() {
                                            loading = true;
                                          });
                                          bool check = await AuthServices().signUp(
                                              email: emailcontroller.text,
                                              name: nameController.text,
                                              lastName: lastNameController.text,
                                              phoneNumber: phoneNumberController.text,
                                              password: passWordController.text);

                                          if (check) {
                                            setState(() {
                                              loading = false;
                                            });
                                            AuthServices().getUserData().then((value) {
                                              AuthServices().saveUserLocally(value);

                                              if (value.role == 'client') {
                                                //client
                                              } else if (value.role == 'admin') {
                                                //admin
                                              }
                                            });
                                          } else {
                                            setState(() {
                                              loading = false;
                                            });
                                            SnackBars(
                                                label: "Email deja existe",
                                                type: SnackBarsTypes.alert,
                                                onTap: () {},
                                                actionLabel: "Fermer",
                                                context: context)
                                                .showSnackBar();

                                          }
                                        }
                                      }))
                            ],
                          )),
                    ],
                  )))),
    );
  }
}
