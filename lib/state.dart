import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';

part 'state.g.dart';

abstract class AppState implements Built<AppState, AppStateBuilder> {

  AppState._();

  factory AppState([void Function(AppStateBuilder) updates]) = _$AppState;

  BuiltList<Todo> get todos;

  @nullable
  String get todoText;

}

abstract class Todo implements Built<Todo, TodoBuilder> {
  Todo._();

  factory Todo([void Function(TodoBuilder) updates]) = _$Todo;

  String get name;

  bool get checked;
}
