import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Test(),
    );
  }
}

class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Insert Record'),
      ),
      body: Column(children: [
        Container(
          margin: EdgeInsets.all(10),
          child: TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(), label: Text('Enter the Name')
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(10),
          child: TextFormField(
            decoration: InputDecoration(
                border: OutlineInputBorder(), label: Text('Enter the Email')
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(10),
          child: TextFormField(
            decoration: InputDecoration(
                border: OutlineInputBorder(), label: Text('Enter the Password')
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(10),
          child: ElevatedButton(onPressed: (){},child:Text('Insert')),
        )
      ]),
    );
  }
}