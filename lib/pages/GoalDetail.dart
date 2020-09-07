import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_progress_bar/flutter_icon_rounded_progress_bar.dart';
import 'package:flutter_rounded_progress_bar/flutter_rounded_progress_bar.dart';
import 'package:flutter_rounded_progress_bar/rounded_progress_bar_style.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:goalkeeper/Models/Goal.dart';
import 'package:goalkeeper/Services/Interfaces/IRepository.dart';
import 'package:goalkeeper/Services/NotificationCenter.dart';
import 'package:goalkeeper/Utils/HelperUtils.dart';
import 'package:goalkeeper/Utils/ThemeUtils.dart';
import 'package:goalkeeper/Utils/colors.dart';
import 'package:goalkeeper/Utils/pickers.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class GoalDetail extends StatefulWidget {
  final Goal goal;
  final NotificationCenter notificationCenter;
  final IRepository repository;

  GoalDetail(this.goal,
      {@required this.repository,
      @required this.notificationCenter}); //constructor

  @override
  State<StatefulWidget> createState() {
    return GoalDetailState(this.goal, this.notificationCenter, this.repository);
  }
}

class GoalDetailState extends State<GoalDetail> {
  final IRepository repository;
  final NotificationCenter notificationCenter;

  Goal goal;
  Color invertColor;

  TextEditingController _bodyTextController;
  TextEditingController _titleTextController;

  GoalDetailState(this.goal, this.notificationCenter, this.repository) {
    this._titleTextController =
        new TextEditingController(text: this.goal.title);
    this._bodyTextController = new TextEditingController(text: this.goal.body);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    this.invertColor = invertColors(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5.0,
        backgroundColor: MyColors.green,
        title: Text(
          'Goal Details',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22.0),
        ),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: 40.0,
                ),
                Hero(
                  tag: 'dartIcon${goal.id}',
                  child: Container(
                    width: 70.0,
                    height: 70.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/icon/icon-legacy.png'),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Center(
                  child: Text(
                    'Goal Detail',
                    style: TextStyle(
                        color: this.invertColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 22.0),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Text(this.goal.title),
                SizedBox(
                  height: 15.0,
                ),
                Text(this.goal.body),
                SizedBox(
                  height: 15.0,
                ),
                CircularPercentIndicator(
                  radius: 60.0,
                  lineWidth: 5.0,
                  percent: this.goal.percent,
                  center:
                      Text((this.goal.percent * 100).round().toString() + "%"),
                  progressColor: Colors.green,
                ),
                CircularPercentIndicator(
                  radius: 100.0,
                  lineWidth: 10.0,
                  percent: this.goal.percent,
                  header: new Text("Icon header"),
                  center: new Icon(
                    Icons.person_pin,
                    size: 50.0,
                    color: Colors.blue,
                  ),
                  backgroundColor: Colors.grey,
                  progressColor: Colors.blue,
                ),
                CircularPercentIndicator(
                  radius: 120.0,
                  lineWidth: 13.0,
                  animation: true,
                  percent: this.goal.percent,
                  center: new Text(
                    (this.goal.percent * 100).round().toString() + "%",
                    style: new TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                  footer: new Text(
                    "Sales this week",
                    style: new TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 17.0),
                  ),
                  circularStrokeCap: CircularStrokeCap.round,
                  progressColor: Colors.purple,
                ),
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: new LinearPercentIndicator(
                    width: 140.0,
                    lineHeight: 14.0,
                    percent: this.goal.percent,
                    center: Text(
                      (this.goal.percent * 100).round().toString() + "%",
                      style: new TextStyle(fontSize: 12.0),
                    ),
                    trailing: Icon(Icons.mood),
                    linearStrokeCap: LinearStrokeCap.roundAll,
                    backgroundColor: Colors.grey,
                    progressColor: Colors.blue,
                  ),
                ),
                IconRoundedProgressBar(
                  widthIconSection: 70,
                  icon: Padding(
                      padding: EdgeInsets.all(8),
                      child:
                          Icon(Icons.airline_seat_flat, color: Colors.white)),
                  style: RoundedProgressBarStyle(
                      colorBackgroundIcon: Color(0xffc0392b),
                      colorProgress: Color(0xffe74c3c),
                      colorProgressDark: Color(0xffc0392b),
                      colorBorder: Color(0xff2c3e50),
                      backgroundProgress: Color(0xff4a627a),
                      borderWidth: 4,
                      widthShadow: 6),
                  margin: EdgeInsets.symmetric(vertical: 16),
                  borderRadius: BorderRadius.circular(6),
                  percent: this.goal.percent * 80,
                ),
                IconRoundedProgressBar(
                  icon: Padding(
                      padding: EdgeInsets.all(8), child: Icon(Icons.person)),
                  theme: RoundedProgressBarTheme.green,
                  margin: EdgeInsets.symmetric(vertical: 16),
                  borderRadius: BorderRadius.circular(6),
                  percent: this.goal.percent * 80,
                ),

                Theme(
                  data: Theme.of(context).copyWith(
                      primaryColor: MyColors.purple,
                      accentColor: MyColors.yellow),
                  child: Builder(
                    builder: (context) => OutlineButton(
                      child: Text(
                        "+ percent",
                        style: TextStyle(
                          color: this.invertColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          if (goal.percent < 0.91) {
                            goal.percent += 0.1;
                          }
                        });
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      borderSide: BorderSide(color: MyColors.purple),
                      highlightedBorderColor: MyColors.yellow,
                      splashColor: MyColors.yellow,
                    ),
                  ),
                ),
                Theme(
                  data: Theme.of(context).copyWith(
                      primaryColor: MyColors.purple,
                      accentColor: MyColors.yellow),
                  child: Builder(
                    builder: (context) => OutlineButton(
                      child: Text(
                        "- percent",
                        style: TextStyle(
                          color: this.invertColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          if (goal.percent > 0.01) {
                            goal.percent -= 0.1;
                          }
                        });
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      borderSide: BorderSide(color: MyColors.purple),
                      highlightedBorderColor: MyColors.yellow,
                      splashColor: MyColors.yellow,
                    ),
                  ),
                )
                // Theme(
                //   data: Theme.of(context).copyWith(
                //       primaryColor: MyColors.purple,
                //       accentColor: MyColors.yellow),
                //   child: Builder(
                //     builder: (context) => OutlineButton(
                //       child: Text(
                //         goal.deadLine == null
                //             ? 'ADD DEADLINE'
                //             : 'EDIT DEADLINE',
                //         style: TextStyle(
                //           color: this.invertColor,
                //           fontWeight: FontWeight.w500,
                //         ),
                //       ),
                //       onPressed: () {
                //         this.editDeadLine(context);
                //       },
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(5.0),
                //       ),
                //       borderSide: BorderSide(color: MyColors.purple),
                //       highlightedBorderColor: MyColors.yellow,
                //       splashColor: MyColors.yellow,
                //     ),
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        heroTag: 'fab',
        closeManually: false,
        foregroundColor: MyColors.light,
        backgroundColor: MyColors.pink,
        elevation: 3.0,
        children: [
          SpeedDialChild(
            child: Icon(Icons.save),
            foregroundColor: MyColors.light,
            backgroundColor: MyColors.blue,
            label: 'Save',
            labelStyle:
                TextStyle(color: MyColors.dark, fontWeight: FontWeight.w500),
            onTap: this.saveGoal,
          ),
          SpeedDialChild(
            child: Icon(Icons.delete_forever),
            foregroundColor: MyColors.light,
            backgroundColor: MyColors.red,
            label: 'Delete',
            labelStyle:
                TextStyle(color: MyColors.dark, fontWeight: FontWeight.w500),
            onTap: this.deleteGoal,
          ),
        ],
      ),
    );
  }

  void updateTitle(String newTitle) {
    this.setState(() {
      goal.title = newTitle;
    });
  }

  void updateBody(String newBody) {
    this.setState(() {
      goal.body = newBody;
    });
  }

  void saveGoal() async {
    Navigator.pop(context);

    if (goal.title.trim().isNotEmpty) {
      if (goal.id == null) {
        repository.insert(goal);
      } else {
        repository.update(goal);
      }
    }

    notificationCenter.updateGoalNotification(goal);
  }

  void deleteGoal() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          title: Text(
            'Done with \'${goal.title}\'?',
            style:
                TextStyle(color: this.invertColor, fontWeight: FontWeight.w600),
          ),
          content: Text(
            'This goal will be deleted!',
            style: TextStyle(
              color: this.invertColor,
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'CANCEL',
                style: TextStyle(
                    color: this.invertColor, fontWeight: FontWeight.w500),
              ),
              onPressed: Navigator.of(context).pop,
            ),
            FlatButton(
              child: Text(
                'DELETE',
                style:
                    TextStyle(color: MyColors.red, fontWeight: FontWeight.w500),
              ),
              onPressed: () async {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                repository.delete(goal);
              },
            ),
          ],
        );
      },
    );
  }

  void editDeadLine(context) async {
    DateTime dueDate = await pickDate(context);
    if (dueDate == null) return;

    TimeOfDay dueTime = await pickTime(context);
    if (dueTime == null) return;

    DateTime deadLine = DateTime(
        dueDate.year, dueDate.month, dueDate.day, dueTime.hour, dueTime.minute);

    setState(() {
      goal.deadLine = deadLine;
    });

    showSnackBar(context, 'Deadline set for ${getFormattedDate(deadLine)}!');
  }
}
