import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/Views/add-page.dart';
import 'package:http/http.dart' as http;

class Notes extends StatefulWidget {
  const Notes({super.key});

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {

  bool isLoading = true;
  List items = [];

  @override
  void initState(){

    super.initState();

    fetchTodo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: Visibility(
        visible: isLoading,
        child: Center(child: CircularProgressIndicator()),
          replacement: RefreshIndicator(
          onRefresh: fetchTodo,
          child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context,index) {
                final item = items[index] as Map;
                final id = item['_id'] as String;
                return ListTile(
                  leading: CircleAvatar(child: Text('${index+1}')),
                    title: Text(item['title']),
                    subtitle: Text(item['description']),
                  trailing: PopupMenuButton(
                    onSelected: (value){
                      if (value == 'edit'){
                        // open Edit Paage
                        navigateToAddPage();
                      }else if(value == 'delete'){
                        // delete and remove the item
                        deleteById(id);
                      }
                    },
                    itemBuilder: (context){
                      return [
                        PopupMenuItem(
                          child: Text('Edit'),
                          value: 'edit',
                        ),
                        PopupMenuItem(
                            child: Text('Delete'),
                            value:'delete'
                        ),
                      ];
                    },
                  ),
                );
            }
          )
        )
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: navigateToAddPage,
          label: Text('Add Todo')
      ),
    );
  }

  void navigateToAddPage(){
    final route = MaterialPageRoute(
        builder: (context)=> AddTodoPage()
    );

    Navigator.push(context, route);
  }

  void navigateToEditPage(){
    final route = MaterialPageRoute(
        builder: (context)=> AddTodoPage()
    );

    Navigator.push(context, route);
  }


  /* Uri.parse(url) се използва, за да се преобразува обикновен низ (string), който представлява
   уеб адрес (URL), в обект от тип Uri, който е специален тип данни в Dart, предназначен за работа
    с уеб адреси */
  Future<void> deleteById(String id) async{
    // Delete the item
    final url = 'https:/api.nstack.in/v1/todos/$id';
    final uri = Uri.parse(url);
    final response = await http.delete(uri);
    // Remove item from the list
    if (response.statusCode == 200){
      // remove item from the list
      final filtered = items.where((x)=>x('_id') != id).toList();
      setState(() {
        items = filtered;
      });
    } else{
      // show error
        showErrorMessage('Deletion Failed');
    }
  }

  // get all api
  Future<void> fetchTodo() async {
    setState(() {
      isLoading = true;
    });
    final url = 'https://api.nstack.in/v1/todos?page=1&limit=10';
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if(response.statusCode==200){
      final json = jsonDecode(response.body) as Map;
      final result = json['items'] as List;
      setState(() {
        items = result;
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  void showErrorMessage(String message){
    final snackBar = SnackBar(content: Text(
      message,
      style: TextStyle(color: Colors.white),
    ),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

}