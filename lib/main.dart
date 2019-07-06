import 'package:clerk/reducer.dart';
import 'package:clerk/state.dart';
import 'package:clerk/view_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

void main() {
  final store = Store<AppState>(reduce, initialState: AppState());
  runApp(MyApp(store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;
  final String appName = "Todoken";

  MyApp(this.store);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
        store: store,
        child: MaterialApp(
          title: appName,
          theme: ThemeData(primarySwatch: Colors.blue),
          home: MyHomePage(title: appName),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FocusNode focusNode;
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                widget.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ),
            ListTile(
              title: Text("Inbox"),
            )
          ],
        ),
      ),
      appBar: AppBar(title: Text(widget.title)),
      body: StoreConnector<AppState, TodoListViewModel>(
          converter: (store) => TodoListViewModel(store),
          builder: (context, vm) {
            controller.value = controller.value.copyWith(text: vm.todoText);
            return SafeArea(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: ReorderableListView(
                      children: vm.todos
                          .map((todo) => buildTodoItem(todo, vm.checkAction))
                          .toList(),
                      onReorder: vm.reorderAction,
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextField(
                        focusNode: focusNode,
                        maxLines: 1,
                        controller: controller,
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: "New Todo"),
                        onSubmitted: (msg) {
                          vm.addTodo(msg);
                          FocusScope.of(context).requestFocus(focusNode);
                        },
                        onChanged: vm.saveText,
                      ),
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }

  Widget buildTodoItem(Todo todo, Function(Todo) callback) => Card(
      key: Key(todo.name),
      child: CheckboxListTile(
          title: Text(todo.name),
          value: todo.checked,
          controlAffinity: ListTileControlAffinity.leading,
          onChanged: (b) => callback(todo)));
}
