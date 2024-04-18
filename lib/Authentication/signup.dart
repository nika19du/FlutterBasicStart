


import 'package:flutter/material.dart';
import 'package:flutter_demo/Authentication/login.dart';
import 'package:flutter_demo/SQLite/sqlite.dart';

import '../JsonModels/users.dart';

class SignUp extends StatefulWidget{
  const SignUp({super.key});

  @override
  State<StatefulWidget> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  bool hidePassword = false;

  final username = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context){
    return  Scaffold(
      // SingleChildScrollView to have an scrol in the screen
      body: SingleChildScrollView(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // prev textfields:

            const ListTile(
                title:Text("Register New Account", style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold))
            ),
            Container(
              margin: EdgeInsets.all(8),
              padding:const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
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
                )
            ),
            Container(
                margin: const EdgeInsets.all(8),
                padding:const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.deepPurple.withOpacity(.3)),
                child: TextFormField(
                  controller: confirmPassword,
                  validator: (value){
                    if(value!.isEmpty){
                      return "password is required";
                    } else if(password.text != confirmPassword.text){
                      return "Passwords don't match";
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
                )
            ),
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
                      if(formKey.currentState!.validate()){
                        final db=DatabaseHelper();

                        db.signup(Users(userName:username.text,userPassword: password.text))
                            .whenComplete(() {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                        });
                      }
                    },
                    child: Text("SIGN UP",style:TextStyle(color: Colors.white)))

            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account?"),
                TextButton(onPressed: ()
                {
                  // Navigate to sign up
                  if(formKey.currentState!.validate()){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context)=>const LoginScreen()));
                  }

                }, child: const Text("Login"))
              ],
            )
          ],
      )),
      ),
    );
  }
}