import 'package:flutter/cupertino.dart';
import 'package:goalkeeper/Models/Goal.dart';
import 'package:goalkeeper/Pages/CreateGoal.dart';
import 'package:goalkeeper/Pages/EditGoal.dart';
import 'package:goalkeeper/pages/GoalDetail.dart';
import 'package:goalkeeper/Services/Factory.dart';

void goToCreateGoal(context) async {
  await Navigator.push(
    context,
    CupertinoPageRoute(
      builder: (context) {
        return CreateGoal(
          repository: Factory().repository,
          notificationCenter: Factory().notificationCenter,
        );
      },
    ),
  );
}

void goToGoalDetail(context, Goal goal) async {
  await Navigator.push(
    context,
    CupertinoPageRoute(
      builder: (context) {
        return GoalDetail(goal,
            notificationCenter: Factory().notificationCenter,
            repository: Factory().repository);
      },
    ),
  );
}

void goToEditGoal(context, Goal goal) async {
  await Navigator.push(
    context,
    CupertinoPageRoute(
      builder: (context) {
        return EditGoal(goal,
            notificationCenter: Factory().notificationCenter,
            repository: Factory().repository);
      },
    ),
  );
}
