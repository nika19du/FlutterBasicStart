
import 'package:flutter/material.dart';
import 'package:flutter_demo/Authentication/signup.dart';
import 'package:flutter_demo/SQLite/sqlite.dart';

import '../JsonModels/users.dart';
import '../Views/notes.dart';

class LoginScreen extends StatefulWidget{
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => LoginScreenState();

}

class LoginScreenState extends State<LoginScreen>{
  bool hidePassword = false;
  bool isLoginTrue = false;
  // TextEditing controller to control the text when we enter into it
  final username = TextEditingController();
  final password = TextEditingController();

  // creating global key for login form
  final formKey = GlobalKey<FormState>();

  final db = DatabaseHelper();

  login(){
   var response= db.login(Users(userName: username.text,userPassword: password.text));
   if(response == true){//getting notes
     Navigator.push(context,MaterialPageRoute(builder: (context)=>Notes()));
   } else{
     setState(() {
       isLoginTrue = true;
     });
   }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
                child:Form(
                  key: formKey,
                  child: Column(
                  children: [
                    // Username field
                    Image.asset("lib/assets/login.png", width: 210),
                    const SizedBox(height: 15,),
                    Container(
                      margin: EdgeInsets.all(8),
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.deepPurple.withOpacity(.2)),
                    child: TextFormField(
                      controller: username,
                      validator: (value){
                        if(value!.isEmpty){
                          return "username is required";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        icon: Icon(Icons.person),
                        border:InputBorder.none,
                        hintText: "Username",
                    ),
                    ),

                ),
                   // Password Field
                    Container(
                      margin: const EdgeInsets.all(8),
                      padding:const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.deepPurple.withOpacity(.3)),
                      child: TextFormField(
                        controller: password,
                        validator: (value){
                          if(value!.isEmpty){
                            return "password is required";
                          }
                          return null;
                        },
                        obscureText: hidePassword,
                        decoration:  InputDecoration(
                          icon: const Icon(Icons.lock),
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
                      )),

                    const SizedBox(height: 10,),
                    // Login button
                    Container(
                      height: 55,
                      width: MediaQuery.of(context).size.width *.9,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.deepPurple
                      ) ,
                    child:
                      TextButton(
                          onPressed: (){
                            Navigator.push(context,MaterialPageRoute(builder: (context)=>const SignUp()));
                          },
                          child: Text("LOGIN",style:TextStyle(color: Colors.white)))

                      ),

                    // Sign up button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account?"),
                        TextButton(onPressed: ()
                        {
                          // Navigate to sign up
                          if(formKey.currentState!.validate()){
                            // Login here
                            login();
                          }

                        }, child: const Text("SIGN UP"))
                      ],
                  ),
                  // dissabling this message in default, when user and pass is icorrect we will trigger this message
                  isLoginTrue ?
                    const Text("Username or password is incorrect",style: TextStyle(color: Colors.red))
                    : const SizedBox()

                ]))

      )),
    ));
  }
}



















