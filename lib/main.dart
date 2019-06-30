import 'package:clerk/actions.dart';
import 'package:clerk/reducer.dart';
import 'package:clerk/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

void main() {
  final store = Store<AppState>(reduce, initialState: AppState());
  runApp(MyApp(store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;

  MyApp(this.store);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
        store: store,
        child: MaterialApp(
          title: 'Clerk',
          theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primarySwatch: Colors.blue,
          ),
          home: MyHomePage(title: 'Clerk'),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: StoreConnector<AppState, String>(
              converter: (store) => store.state.todos
                  .map((todo) => todo.checked ? 1 : 0)
                  .fold(0, (a, b) => a + b)
                  .toString(),
              builder: (context, num) => Text(widget.title + num))),
      body: StoreConnector<AppState, List<Todo>>(
          converter: (store) => store.state.todos.toList(),
          builder: (context, list) => Center(child: ListView.builder(
                itemBuilder: (context, index) {
                  if (index < list.length) {
                    return buildTodoItem(list[index]);
                  }
                },
              ))),
      floatingActionButton: StoreConnector<AppState, VoidCallback>(
        converter: (store) => () => store.dispatch(
            AddTodoAction("Hello " + store.state.todos.length.toString())),
        builder: (context, callback) => FloatingActionButton(
            onPressed: callback,
            child: Icon(Icons.add),
          ),
      ),
    );
  }

  Widget buildTodoItem(Todo todo) => StoreConnector<AppState, VoidCallback>(
      converter: (store) => () => store.dispatch(CheckTodoAction(todo)),
      builder: (context, callback) => Card(
          child: CheckboxListTile(
              title: Text(todo.name),
              value: todo.checked,
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (b) => callback())));
}
