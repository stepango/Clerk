import 'package:clerk/actions.dart';
import 'package:clerk/state.dart';

AppState reduce(AppState state, dynamic action) {
  if (action is AddTodoAction) {
    return addTodo(state, action);
  } else if (action is CheckTodoAction) {
    return checkTodo(state, action);
  }
  return state;
}

AppState checkTodo(AppState state, CheckTodoAction action) =>
    state.rebuild((stateBuilder) => stateBuilder.todos.update((update) => update
      ..map((it) => it.name == action.todo.name
          ? action.todo.rebuild((todoBuilder) => todoBuilder
            ..checked = !action.todo.checked
            ..build())
          : it)));

AppState addTodo(AppState state, AddTodoAction action) =>
    state.rebuild((stateBuilder) => stateBuilder.todos
        .update((update) => update.add(Todo((builder) => builder
          ..name = action.todo
          ..checked = false
          ..build()))));
