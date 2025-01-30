import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:reclamations/presentation/client/home_client.dart';
import 'package:reclamations/presentation/ressources/routes/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(); // initialize firebase app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Reclamations',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      //onGenerateRoute: AppRouting.generateRoute,
      //initialRoute: AppRouting.clientHome
      home: HomeClient(),



    );
  }
}


//TODO
/*
* 1) create admin screens like the client
* Dashboard
* Reclamations
* Utilisateurs
* Profil
* TIP => start with the HomeAdmin screen in the project
* */