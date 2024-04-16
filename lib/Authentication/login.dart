
import 'dart:html';

import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget{
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => LoginScreenState();

}

class LoginScreenState extends State<LoginScreen>{
  bool hidePassword = false;
  // TextEditing controller to control the text when we enter into it
  final username = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
                child: Column(
                children: [
                  // Username field
                //  Image.network('https://storage.googleapis.com/gweb-uniblog-publish-prod/images/PASSKEY_ILLUSTRATION-01.width-1200.format-webp.webp'),
                  Container(
                    margin: EdgeInsets.all(8),
                    padding:const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.deepPurple.withOpacity(.3)),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person),
                      border:InputBorder.none,
                      hintText: "Username",
                  ),
                  ),

              ),
                 // Password Field
                  Container(
                    margin: EdgeInsets.all(8),
                    padding:const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.deepPurple.withOpacity(.3)),
                    child: TextFormField(
                      obscureText: hidePassword,
                      decoration:  InputDecoration(
                        icon: Icon(Icons.lock),
                        border:InputBorder.none,
                        hintText: "Password",
                        suffixIcon: IconButton(
                          icon: Icon(
                            hidePassword ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              hidePassword = !hidePassword; // toggle button
                            });
                          },

                        ),

                    ),
                    ))
                ])
      )),
    ));
  }
}



















