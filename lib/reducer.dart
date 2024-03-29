import 'package:clerk/actions.dart';
import 'package:clerk/state.dart';

AppState reduce(AppState state, dynamic action) {
  if (action is AddTodoAction) {
    return addTodo(state, action);
  } else if (action is CheckTodoAction) {
    return checkTodo(state, action);
  } else if (action is ReorderAction) {
    return reorderTodo(state, action);
  } else if (action is SaveTodoAction) {
    return updateTodoText(state, action);
  }
  return state;
}

AppState updateTodoText(AppState state, SaveTodoAction action) =>
    state.rebuild((builder) => builder
      ..todoText = action.text
      ..build());

AppState reorderTodo(AppState state, ReorderAction action) =>
    state.rebuild((stateBuilder) {
      var list = state.todos.toList();
      var fromOld = list.removeAt(action.oldI);
      if (action.newI >= list.length)
        list.add(fromOld);
      else
        list.insert(action.newI, fromOld);
      return stateBuilder
        ..todos.update((listBuilder) => listBuilder.replace(list))
        ..build();
    });

AppState checkTodo(AppState state, CheckTodoAction action) =>
    state.rebuild((stateBuilder) => stateBuilder.todos.update((update) => update
      ..map((it) => it.name == action.todo.name
          ? action.todo.rebuild((todoBuilder) => todoBuilder
            ..checked = !action.todo.checked
            ..build())
          : it)));

AppState addTodo(AppState state, AddTodoAction action) =>
    state.rebuild((stateBuilder) => stateBuilder
      ..todos.update((update) {
        var todo = Todo((builder) => builder
          ..name = action.todo
          ..checked = false
          ..build());
        update.remove(todo);
        return update.add(todo);
      })
      ..todoText = "");
