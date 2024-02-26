import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:task2/database_service.dart';
import 'package:task2/homePage.dart';
import 'package:task2/models/models.dart';


class ToDoPage extends StatelessWidget {
  const ToDoPage({super.key,required this.todoId});
  
  final String todoId;

  @override
  Widget build(BuildContext context) {
    final DatabaseService databaseService=DatabaseService();
    TextEditingController _textEditingController = TextEditingController();

    return Scaffold(
        body: Container(
            color: Color.fromARGB(255, 234, 232, 232),
            padding: EdgeInsets.all(20.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      width: 400,
                      height: 100,
                      child: TextField(
                        controller: _textEditingController,
                        autofocus: true,
                        decoration: const  InputDecoration(
                            hintText: 'Your task',
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none),
                        style: const TextStyle(
                          fontSize: 25.0,
                        ),
                        maxLines: 10,
                      ),
                    
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(onPressed: (){
                    Todo todo = Todo( task:_textEditingController.text,
                    isDone: false,
                    createdOn: Timestamp.now(),
                    updatedOn: Timestamp.now());
                    databaseService.updateTodo(todoId,todo);
                    Navigator.pop(context);
                    _textEditingController.clear();
                  }
                  , child: Text("Add", style: TextStyle(fontSize: 24)))
                  // )
                ]
                 )));
  }
}
