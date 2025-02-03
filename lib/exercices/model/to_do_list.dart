class ToDoList {
  String? id;
  String? label;
  DateTime? date;

  ToDoList({this.id, this.label, this.date});

  factory ToDoList.fromJson(Map<String, dynamic> json) {
    return ToDoList(id: json['id'], label: json['label'], date: json['date'].toDate());
  }
  // fromJson is used to get data from json and convert it into a specific object

  Map<String, dynamic> toJson() => {
        'label': this.label,
        'date': this.date,
      };


  void main() {
    Map<String,dynamic> map={
      "age":12,
      "heigh":1.80,
      "skills":{
        "soft_skills":{
          "name":"test skills",
          "duration":2,
        },
        "hard_skills":{
          "name":"test skills 2",
          "duration":1,
        },
      }
    };
    print("my hard skills's duration is ${map['skills']["hard_skills"]["duration"]}");
  }

}
/*
* A factory constructor in Dart is a special constructor that does not necessarily
* create a new instance every time it is called. Instead,
*  it can return an existing instance or perform additional logic before creating an object
* */