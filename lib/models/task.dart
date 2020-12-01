class Task {
  int id;
  String name;

  Task(this.name);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{ 'name': name };

    if (id != null) {
      map['id'] = id;
    }

    return map;
  }

  Task.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
  }
}