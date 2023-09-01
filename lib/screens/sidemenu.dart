import 'package:flutter/material.dart';
import 'package:thelast/screens/config.dart';
import 'package:thelast/screens/home.dart';
import 'package:thelast/screens/login.dart';
import 'package:thelast/screens/users.dart';


class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    // String accountName = "Fatimah Wongsontham";
    String accountName = "N/A";
    // String accountEmail = "fatimah.wo@mail.wu.ac.th";
    String accountEmail = "N/A";
    String accountUrl = "https://scontent-sin6-4.xx.fbcdn.net/v/t39.30808-6/285075127_3063697487275497_6585605355569584394_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=174925&_nc_eui2=AeGHZeHic1DaNst04xlMr31h07wnKBV7CDrTvCcoFXsIOsXhbues4KZHZoh8yqAQj7VuS-aa8tmF8PwXQAPcAgCt&_nc_ohc=HfFTNUw6GJMAX-209UR&_nc_ht=scontent-sin6-4.xx&oh=00_AfBNn3Nj-iasHUhtQ0GZ0hXyx7GSyYMx-QIYjm5sEP5wsQ&oe=64F463D5";

    Users user = Configure.login;
    // print(user.toJson().toString());
    if (user.id != null){
      accountName = user.fullname!;
      accountEmail = user.email!;
    }
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(accountName), 
            accountEmail: Text(accountEmail),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(accountUrl),
              backgroundColor: Colors.white,
            ),),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Home"),
            onTap: () {
              Navigator.pushNamed(context, Home.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.login),
            title: Text("Login"),
            onTap: () {
              Navigator.pushNamed(context, Login.routeName);
            },
          )
        ],
      ),
    );
  }
}