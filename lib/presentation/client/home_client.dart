import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reclamations/presentation/client/screens/dashboard.dart';
import 'package:reclamations/presentation/client/screens/notification.dart';
import 'package:reclamations/presentation/client/screens/profil.dart';
import 'package:reclamations/presentation/client/screens/reclamations.dart';

class HomeClient extends StatefulWidget {
  const HomeClient({super.key});

  @override
  State<HomeClient> createState() => _HomeClientState();
}

class _HomeClientState extends State<HomeClient> {
  List<BottomNavigationBarItem> items=[
    BottomNavigationBarItem(icon: Icon(Icons.home),label: "Acceuil"),
    BottomNavigationBarItem(icon: Icon(Icons.data_exploration_outlined),label: "Reclamations"),
    BottomNavigationBarItem(icon: Icon(Icons.notifications),label: "Notifications"),
    BottomNavigationBarItem(icon: Icon(Icons.account_circle),label: "Profil"),
  ];
  List<Widget> pages=[Dashboard(),Reclamations(),Notifications(),Profil(),];
  int selectedItem=0;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: pages[selectedItem],
      bottomNavigationBar:BottomNavigationBar(
        items: items,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.cyan,
        backgroundColor: Colors.blueAccent,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        currentIndex: selectedItem,
        onTap: (index){
          setState(() {
            selectedItem=index;
          });
        },


      ) ,
    );
  }
}
