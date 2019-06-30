import 'package:clerk/state.dart';

abstract class Action {}

class AddTodoAction extends Action {
  String todo;

  AddTodoAction(
    this.todo,
  );
}

class CheckTodoAction extends Action {
  Todo todo;
  bool checked;

  CheckTodoAction(this.todo, this.checked);
}
