import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task2/changetasksPage.dart';
import 'package:task2/database_service.dart';
import 'package:task2/models/models.dart';
import 'package:task2/tasksPage.dart';
import 'package:intl/intl_browser.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  final DatabaseService databaseService = DatabaseService();
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color.fromARGB(255, 235, 233, 233),
      appBar: AppBar(
        backgroundColor: Colors.grey,
        centerTitle: true,
        title: const Text("TO DO LIST"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ToDoView()));
        },
        child: const Icon(Icons.add),backgroundColor: Color.fromARGB(255, 154, 178, 246),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.80,
              width: MediaQuery.sizeOf(context).width,
              child: StreamBuilder(
                stream: databaseService.getTodos(),
                builder: (context, snapshot) {
                  List todos = snapshot.data?.docs ?? [];
                  if (todos.isEmpty) {
                    return const Center(
                      child: Text("Add tasks", style: TextStyle(fontSize: 26,  ),),
                    );
                  }
                  return ListView.builder(
                      itemCount: todos.length,
                      itemBuilder: (context, index) {
                        print(index);
                        Todo todo = todos[index].data();
                        String todoId = todos[index].id;
                        return Padding(
                          padding:const  EdgeInsets.symmetric(
                              vertical: 10, horizontal: 30),
                          child: ListTile(
                              tileColor: Color.fromARGB(255, 216, 216, 215), 
                              
                              title: Text(todo.task),
                              subtitle:
                                  Text(DateFormat("dd-MM-yyyy h:m a").format(
                                todo.updatedOn.toDate(),
                              )),
                              leading: Checkbox(
                                value: todo.isDone,
                                onChanged: (value) {
                                  Todo updateTodo = todo.copyWith(
                                      isDone: !todo.isDone,
                                      updatedOn: Timestamp.now());
                                  databaseService.updateTodo(
                                      todoId, updateTodo);
                                },
                              ),
                              trailing:SizedBox(
                        width: 100,
                        child: Row(
                          children: [ 
                            IconButton(
                                onPressed: () {Navigator.push(
              context, MaterialPageRoute(builder: (context) => ToDoPage(todoId: todoId,todo: todo,)));},
                                icon: const Icon(Icons.edit)),
                                IconButton(
                                  onPressed: () {
                                    databaseService.deleteTodo(todoId);
                                  },
                                  icon:const Icon(Icons.delete))]))),
                        );
                      });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
