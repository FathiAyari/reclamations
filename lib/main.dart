import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:reclamations/exercices/view/to_do_list_view.dart';
import 'package:reclamations/presentation/Authentication/SignIn/SignIn.dart';
import 'package:reclamations/presentation/client/home_client.dart';
import 'package:reclamations/presentation/ressources/routes/router.dart';
import 'package:get/get.dart';
Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp(); // initialize firebase app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Reclamations',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      onGenerateRoute: AppRouting.generateRoute,
      initialRoute: AppRouting.splashScreen



    );
  }
}

