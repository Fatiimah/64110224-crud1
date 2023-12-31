

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:thelast/screens/config.dart';
import 'package:thelast/screens/home.dart';
import 'package:thelast/screens/sidemenu.dart';
import 'package:http/http.dart' as http;

import 'users.dart';

class Login extends StatefulWidget {
  static const routeName = "/login";
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formkey = GlobalKey<FormState>();
  Users user = Users();

  Future<void> login(Users users) async{
    var params = {"email":user.email, "password": user.password};

    var url = Uri.http(Configure.server,"users", params);
    var resp = await http.get(url);
    print(resp.body);
    List<Users> login_result = usersFromJson(resp.body);
    print(login_result.length);
    
    if (login_result.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("username or password invalid"),));
    } else {
      Configure.login = login_result[0];
      Navigator.pushNamed(context, Home.routeName);
    }
    return;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              emailInputField(),
              passwordInputField(),
              SizedBox(height: 10.0,),
              Row(
                children: [
                  submitButton(),
                  SizedBox(width: 10.0,),
                  backButton(),
                  SizedBox(width: 10.0,),
                  registerLink(),
                ],
              )
            ],
          ) ,
        ),
      ),
      drawer: SideMenu(),
    );
  }
  Widget emailInputField() {
    return TextFormField(
      initialValue: "",
      decoration: InputDecoration(
        labelText: "Email:",
        icon: Icon(Icons.email),
      ),
      validator: (value) {
        if (value!.isEmpty){
          return "This field is required";
        }
        if (!EmailValidator.validate(value)){
          return "It is not email format";
        }
        return null;
      },
      onSaved: (newValue) => user.email = newValue,
    );
  }
  Widget passwordInputField() {
    return TextFormField(
      obscureText: true,
      initialValue: "",
      decoration: InputDecoration(
        labelText: "Password:",
        icon: Icon(Icons.lock)
      ),
      validator: (value) {
        if (value!.isEmpty){
          return "This field is required";
        }
        return null;
      },
      onSaved: (newValue) => user.password = newValue,
    );
  }
  Widget submitButton(){
    return ElevatedButton(onPressed: (){
      if (_formkey.currentState!.validate()){
        _formkey.currentState!.save();
        print(user.toJson().toString());
        login(user);
      }
      
    },
      child: Text("Login"));
  }
  Widget backButton() {
    return ElevatedButton(
      onPressed: (){
      }, 
      child: Text("Back"));
  }
  Widget registerLink(){
    return InkWell(
      child: const Text("Sign Up"),
      onTap: (){},
    );
  }
}