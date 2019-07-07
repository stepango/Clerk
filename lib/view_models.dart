import 'actions.dart';
import 'state.dart';
import 'package:redux/redux.dart';

//@immutable
class TodoListViewModel {
  final Store<AppState> store;

  TodoListViewModel(this.store);

  Function(Todo) get checkAction =>
          (todo) => store.dispatch(CheckTodoAction(todo));

  Function(int, int) get reorderAction =>
          (a, b) => store.dispatch(ReorderAction(a, b));

  Function(String) get addTodo =>
          (text) => store.dispatch(AddTodoAction(text));

  Function(String) get saveText =>
          (text) => store.dispatch(SaveTodoAction(text));

  List<Todo> get todos => store.state.todos.toList();

  String get todoText => store.state.todoText;

  String get todoAmount => todos.length.toString();

}
