import 'state.dart';

class TodoListViewModel {
  final List<Todo> todos;
  final Function(Todo) checkAction;
  final Function(int, int) reorderAction;

  TodoListViewModel(this.todos, this.checkAction, this.reorderAction);
}
