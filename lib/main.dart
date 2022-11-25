import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Todo {
  final String title;
  final String description;

  const Todo(this.title, this.description);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Todo? todoo;
  _handleSelectTodo(Todo todoo){
    setState(() {
      this.todoo = todoo;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Navigator(pages: [
          MaterialPage(child: ListTodoScreen(_handleSelectTodo)),
          if (todoo != null)
            MaterialPage(child: DetailTodoScreen(todoo))
        ],
          onPopPage: (route,result)=>route.didPop(result),
        ));
  }
}

class ListTodoScreen extends StatelessWidget{

  var onTaped;
  ListTodoScreen(this.onTaped) : super (key: ValueKey(onTaped));
  List<Todo> todos = List.generate(20, (index) =>
      Todo('Todo $index',
          'A description of what needs to be done for Todo $index'));
  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      appBar: AppBar(title: Text('ListTodo')),
      body: ListView(
        children: [
          for(var todoo in todos)
            ListTile(title: Text(todoo.title),
                subtitle: Text(todoo.description),
                onTap:()=> this.onTaped(todoo)),
        ],
      ),
    ));
  }
}

class DetailTodoScreen extends StatelessWidget{
  var todoo;
  DetailTodoScreen(this.todoo) : super(key: ValueKey(todoo));
  @override
  Widget build(BuildContext context) {
    return (Scaffold(
        appBar: AppBar(title: Text('detail')),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(todoo.title + '     ' + todoo.description),
        )));
  }

}
