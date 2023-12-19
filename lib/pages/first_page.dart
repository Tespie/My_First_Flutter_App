// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:My_First_Flutter_App/components/my_drawer_tile.dart';
import 'package:My_First_Flutter_App/components/my_list_tile.dart';
import 'package:My_First_Flutter_App/components/nice_text.dart';
import 'package:My_First_Flutter_App/helper/helper_functions.dart';
import 'package:My_First_Flutter_App/pages/practice_page.dart';
import 'package:My_First_Flutter_App/pages/second_page.dart';
import 'package:flutter/material.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("1st Page")),
        // drawer: TEST_ElevatedButton(),
        // body: TEST_ElevatedButton(),
        // body: Drawer(),
        drawer: Drawer(
          backgroundColor: Colors.green[400],
          child: Column(
            children: [
              // NiceTextLabel(text: "text")
              DrawerHeader(child: Icon(Icons.person, size: 100)),

              // MyDrawerTile(title: "HOME", icon: Icons.home, onTap: () {}),
              ListTile(
                leading: Icon(Icons.home_rounded),
                title: Text("HOME"),
                onTap: () {
                  popContext(context);
                  Navigator.pushNamed(context, 'home_page');
                },
              ),
              ListTile(
                leading: Icon(Icons.settings_applications_rounded),
                title: Text("SETTINGS"),
                onTap: () {
                  popContext(context);
                  Navigator.pushNamed(context, 'settings_page');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*
 * ELEVATED BUTTON -                                test widget 
 */
class TEST_ElevatedButton extends StatelessWidget {
  TEST_ElevatedButton({
    super.key,
  });

  ButtonStyle style = ElevatedButton.styleFrom(
      foregroundColor: Colors.red,
      textStyle: const TextStyle(
          fontSize: 40,
          backgroundColor: Colors.black,
          decorationColor: Colors.green));

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      // style: ElevatedButton.styleFrom(
      // textStyle: const TextStyle(fontSize: 20, color: Colors.amber)),
      style: style,
      onPressed: () {
        // navigate to second page
        /**
         * THIS WILL ONLY WORK IF YOU HAVE PROVIDED ROUTES IN main.dart page
         */
        // Navigator.pushNamed(context, 'second_page');

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SecondPage()));
      },
      child: Text("Go to 2nd Page"),
    );
  }
}
