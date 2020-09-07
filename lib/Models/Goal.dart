class Goal {
  int id;
  String title;
  String body;
  DateTime deadLine;
  double percent;

  int get index => id;
  String get goalTitle => title;
  String get goalBody => body;
  DateTime get goalDeadLine => deadLine;
  double get goalPercent => percent;

  set goalTitle(String newTitle) {
    this.title = newTitle;
  }

  set goalBody(String newBody) {
    this.body = newBody;
  }

  set goalDeadLine(DateTime deadline) {
    this.deadLine = deadline;
  }

  Goal(this.title, this.body, this.percent, [this.deadLine]);
  Goal.withId(this.id, this.title, this.body, this.percent, [this.deadLine]);

  Goal.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    body = map['body'];
    percent = double.parse(map['percent']);
    if (map['deadLine'] != null) deadLine = DateTime.parse(map['deadLine']);
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) map['id'] = id;
    if (deadLine != null) map['deadLine'] = deadLine.toString();

    map['title'] = title;
    map['body'] = body;
    map['percent'] = percent.toString();

    return map;
  }

  @override
  String toString() {
    return '[$id] - $title: $body (${deadLine.toString()})';
  }
}
