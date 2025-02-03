import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reclamations/exercices/model/to_do_list.dart';
import 'package:reclamations/exercices/view/edit_element.dart';
import 'package:reclamations/presentation/ressources/dimensions/constants.dart';

class ToDoListServices {
  var toDoListCollection = FirebaseFirestore.instance.collection('list');
  // use streambuilder to get data and visualize real time changes

  Widget getToDoLists() {
    return StreamBuilder<QuerySnapshot>(
        stream: toDoListCollection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<ToDoList> data = [];
            var fireBaseData = snapshot.data!.docs.toList();
            for (var line in fireBaseData) {
              data.add(ToDoList.fromJson(line.data() as Map<String, dynamic>));
            }
            // use listview builder to display data from data source dynamicly
            if (data.isEmpty) {
              return Center(
                child: Text("no data"),
              );
            } else {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: Constants.screenHeight * 0.02, horizontal: Constants.screenWidth * 0.03),
                child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(color: Colors.pink.withOpacity(0.2), borderRadius: BorderRadius.circular(20)),
                        child: ListTile(
                          subtitle: Text("${DateFormat("yyyy/MM/dd").format(data[index].date!)}"),
                          trailing: Container(
                            width: Constants.screenWidth * 0.5,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context, MaterialPageRoute(builder: (context) => EditElementView(toDoList: data[index])));
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    deleteElement(data[index].id!);
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          title: Text("${data[index].label}"),
                        ),
                      );
                    }),
              );
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

 addToDoElement(ToDoList toDoList) async {
    //creation
    var doc = toDoListCollection.doc();

    //fromjson tab3Th data mel front lel base firebase wel tojson nesta3mloha bch njibo data mel firebase
    toDoListCollection.doc(doc.id).set(toDoList.toJson());
    toDoListCollection.doc(doc.id).update({"id": doc.id});
  }

   deleteElement(String elementId) async {
    await toDoListCollection.doc(elementId).delete();
  }

  Future editElement(ToDoList toDoList) async {
    await toDoListCollection.doc(toDoList.id).update(toDoList.toJson());
  }
}

class FutureBuilderExample extends StatelessWidget {
  // Simulated function that fetches data asynchronously
  Future<String> fetchData() async {
    await Future.delayed(Duration(seconds: 3)); // Simulate network delay ta3tila lel execution
    return "Data loaded successfully!";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("FutureBuilder Example")),
      body: Center(
        child: FutureBuilder<String>(
          future: fetchData(), // The future to be resolved
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(); // Show loading indicator
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else if (snapshot.hasData) {
              return Text(snapshot.data!, style: TextStyle(fontSize: 20));
            } else {
              return Text("No data available");
            }
          },
        ),
      ),
    );
  }
}