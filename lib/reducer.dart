import 'package:clerk/actions.dart';
import 'package:clerk/state.dart';

AppState reduce(AppState state, dynamic action) {
  if (action is AddTodoAction) {
    return addTodo(state, action);
  } else if (action is CheckTodoAction) {
    return state
        .rebuild((stateBuilder) => stateBuilder.todos.update((update) => update
          ..map((it) => it == action.todo
              ? action.todo.rebuild((todoBuilder) => todoBuilder
                ..checked = !action.todo.checked
                ..build())
              : it)));
  }
  return state;
}

AppState addTodo(AppState state, AddTodoAction action) =>
    state.rebuild((stateBuilder) => stateBuilder.todos.update((update) {
          update.add(Todo((builder) => builder
            ..name = action.todo
            ..checked = false
            ..build()));
        }));
