import 'package:clerk/state.dart';

abstract class Action {}

//@immutable
class AddTodoAction extends Action {
  final String todo;

  AddTodoAction(
    this.todo,
  );
}

//@immutable
class CheckTodoAction extends Action {
  final Todo todo;

  CheckTodoAction(
    this.todo,
  );
}

//@immutable
class ReorderAction {
  final int oldI;
  final int newI;

  ReorderAction(this.oldI, this.newI);
}

//@immutable
class SaveTodoAction {
  final String text;

  SaveTodoAction(this.text);
}
