import 'state.dart';

class TodoListViewModel{
  final List<Todo> todos;
  final Function(Todo) callback;

  TodoListViewModel(this.todos, this.callback);

}
