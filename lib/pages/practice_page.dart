// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:async';
import 'dart:ffi';
import 'dart:math';

import 'package:My_First_Flutter_App/components/my_button.dart';
import 'package:My_First_Flutter_App/components/my_textfield.dart';
import 'package:My_First_Flutter_App/helper/helper_functions.dart';
import 'package:My_First_Flutter_App/pages/first_page.dart';
import 'package:My_First_Flutter_App/pages/home_page.dart';
import 'package:My_First_Flutter_App/pages/profile_page.dart';
import 'package:My_First_Flutter_App/pages/settings_page.dart';
import 'package:My_First_Flutter_App/pages/tabs/home_tab.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class PracticePage extends StatefulWidget {
  PracticePage({super.key});

  @override
  State<PracticePage> createState() => _PracticePageState();
}

class _PracticePageState extends State<PracticePage> {
  List<int> colorShadesList = [50, 100, 200, 300, 400, 600, 700, 800, 900];

  int selectedTabIndex = 0;

  final List _pages = [
    // home
    // HomePage(),
    HomeTab(),
    //profile
    ProfilePage(),
    // settings
    SettingsPage()
  ];

  /*
   * CHANGE THE A 
   */
  void changeTab(int currentIndex) {
    setState(() {
      selectedTabIndex = currentIndex;
    });
  }

  String time = "";

  int bgColor = 0;

  @override
  void initState() {
    Timer mytimer = Timer.periodic(Duration(seconds: 1), (timer) {
      DateTime timenow = DateTime.now(); //get current date and time
      time = "${timenow.hour}:${timenow.minute}:${timenow.second}";
      bgColor = Random().nextInt(colorShadesList.length);
      setState(() {});
    });
    mytimer.cancel();

    // super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List tejasNames = [
      'tejas',
      'teju',
      'TP',
      "bavo",
      "Kaliyo",
      'TC',
      "Lalu",
      "Bhailu",
      "Bittu",
      "Kalu"
    ];
    return Scaffold(
      /**
       * APP BAR - where TITLE and OTHER BUTTONS can be configured
       */
      appBar: AppBar(
        title: const Text("Lets Learn"),
        backgroundColor: Colors.deepPurple,
        elevation: 10,

        /**
         * Icon before Title,
         * By default , BACK BUTTON is there with working
         * if you are not providing this attribute
         * 
         */
        // leading: Icon(
        //   Icons.menu,
        // ),

        /**
         * Icon before Title,
         * By default , working BACK BUTTON is there
         * and TYPICALLY, Icon or IconButton
         */
        // leading: Row(
        //   children: [
        //     Icon(
        //       Icons.menu,
        //     ),
        //     IconButton(
        //       onPressed: () {},
        //       icon: Icon(Icons.play_arrow),
        //     ),
        //   ],
        // ),

        /**
         * Icon after Title,
         * 
         * YOU CAN GIVE MORE THAN 1 ICON / ICON BUTTONS
         * 
         */
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.power_settings_new),
          ),
          Icon(
            Icons.favorite,
            color: Colors.pink,
            size: 30,
            semanticLabel: 'Text to announce in accessibility modes',
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.audiotrack),
            color: Colors.green,
          ),
        ],
      ),

      /**
       * Scaffold full layer background color 
       */
      // backgroundColor: Colors.red,
      // backgroundColor: Colors.green[colorShadesList[bgColor]],

      /**
       * ACTUAL SCREEN DESIGN for this Scaffold 
       */
      // body: AboutDialog(),
      // body: MyTestContainer(),
      // body: MyTestColumn(),
      // body: TestColumnWithColorBoxes(),
      // body: Test_ListView_Vertical(),
      // body: Test_ListView_Horizontal(),
      // body: Test_ListView_With_Builder(tejasNames: tejasNames),
      // body: Test_GridView_With_Builder(),                      // DOC Style Comment tried
      // body: Test_STACK(),
      // body: Test_GestureDetector(),
      // body: Test_ButtonWithFirstPageButton(),      // button with first page navigation button click
      // body: ActionChip(label: Text("this is chip >> $time")),
      // body: FirstPage(),
      // body: Test_CustomAlertShowBaji(),

      /**
       * BOTTOM NAVIGATION TAB BAR
       */
      // body: _pages[selectedTabIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedTabIndex,
        // onTap: (currentIndex) => {selectedTabIndex = currentIndex},
        onTap: changeTab,
        items: [
          //home
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),

          // profile
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: "Profile",
          ),

          // settings
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
      ),
    );
  }
}

/*
 * SHOW DIFFERENT ALERT DIALOG 
 */
class Test_CustomAlertShowBaji extends StatelessWidget {
  const Test_CustomAlertShowBaji({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: NiceTextLabel(text: "Tap me to open Alert"),
      onTap: () {
        showCustomDialog(context, "title", "first tap with cancel button",
            onOkPressed: () {
          showCustomDialog(context, "OK",
              "alert dialog without cancel button and \n 🤡 You Can't dismiss me on Outer Touch ⚠️",
              canDismissed: false);
        }, showCancel: true);
      },
    );
  }
}

class Test_ButtonWithFirstPageButton extends StatelessWidget {
  const Test_ButtonWithFirstPageButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 25),
        Test_GestureDetector(),
        SizedBox(height: 25),
        MyButton(
            text: "Go to First Page",
            onTap: () {
              Navigator.pushNamed(context, 'first_page');
            }),
      ],
    );
  }
}

/*
 * GESTURE DETECTOR -               test componenent
 * 
 */
class Test_GestureDetector extends StatelessWidget {
  const Test_GestureDetector({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          // popContext(context);
          showAlert(context, "Ohhhh",
              "You Touched Me... \nBut Why?\n\nHow Dare you to Touch me ? 😡");
        },
        // onTapUp: (TapUpDetails details) {
        //   showAlert(context, 'Tap position', '${details.globalPosition}');
        //   // Add your onTapUp logic here
        // },
        child: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 187, 210, 9),
            borderRadius: BorderRadius.vertical(
                // top: Radius.circular(MediaQuery.of(context).size.width),
                top: Radius.circular(70),
                bottom: Radius.elliptical(-10.5, -90)),
          ),
          // color: Colors.brown,
          child: Center(
            child: NiceTextLabel(text: "Don't Touch\n Me 😜"),
          ),
        ),
      ),
    );
  }
}

/// 😎 TEXT Label created by Tejas Patel 🎯
///  To display text with good color and fontsize
///
/// You can use it anywhere with just a text string you want.
/// [text] is MANDATORY param
/// [colorName] is OPTIONAL param
///
class NiceTextLabel extends StatelessWidget {
  final String text;
  //  final Color colorName = Colors.red;
  final Color? colorName;
  const NiceTextLabel({super.key, required this.text, this.colorName});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: colorName ?? Colors.red,
        fontSize: 25,
      ),
    );
  }
}

/*
 * STACK -               test componenent
 * 
 */
class Test_STACK extends StatelessWidget {
  const Test_STACK({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        // big box
        Container(height: 300, width: 300, color: Colors.teal[200]),

        // medium box
        Container(height: 200, width: 200, color: Colors.teal[400]),

        // small box
        Container(height: 100, width: 100, color: Colors.teal[900]),
      ],
    );
  }
}

/*
 * GRID VIEW with BUILDER -               test componenent
 * 
 */
/// Hello to Library Lok 😜
///
/// Agar Kabhi CHESS game bana rhe ho to Ye use kar sakte ho ... bhai
///
/// ![Look at the sample PNG.](C:\Projects\Flutter\My_First_Flutter_App\lib\dummyData\tj.png)
///
/// ![DEMO.](https://flutter.github.io/assets-for-api-docs/assets/painting/text_style_italics.png)
///
/// You can create tiles easily with [SliverGridDelegateWithFixedCrossAxisCount]
/// [itemcount] and [crossAxisCount] params
///
class Test_GridView_With_Builder extends StatelessWidget {
  const Test_GridView_With_Builder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 60,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 8),
      itemBuilder: (context, item) => Container(
        color: Colors.cyan,
        margin: EdgeInsets.all(5),
      ),
    );
  }
}

/*
 * LIST VIEW with BUILDER -               test componenent
 * 
 */
class Test_ListView_With_Builder extends StatelessWidget {
  const Test_ListView_With_Builder({
    super.key,
    required this.tejasNames,
  });

  final List tejasNames;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: tejasNames.length,
        itemBuilder: (context, index) => ListTile(
              title: Text((index + 1).toString()),
              subtitle: Text(
                tejasNames[index],
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                    color: Colors.amber),
              ),
            ));
  }
}

/*
 * LIST VIEW - horizontal scroll              test componenent
 * 
 */
class Test_ListView_Horizontal extends StatelessWidget {
  const Test_ListView_Horizontal({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      dragStartBehavior: DragStartBehavior.start,
      clipBehavior: Clip.antiAlias,
      children: [
        Container(width: 300, color: Colors.lime[200]),
        Container(width: 300, color: Colors.lime[400]),
        Container(width: 300, color: Colors.lime[800]),
      ],
    );
  }
}

/*
 * LIST VIEW - vertical scroll              test componenent
 * 
 */
class Test_ListView_Vertical extends StatelessWidget {
  const Test_ListView_Vertical({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(30),
      scrollDirection: Axis.vertical,
      children: [
        Container(height: 300, color: Colors.red[100]),
        IconButton.filled(
          onPressed: () {},
          icon: Icon(
            Icons.car_repair,
            size: 50,
          ),
          style: ButtonStyle(alignment: Alignment.center),
        ),
        Container(height: 300, color: Colors.red[300]),
        Container(height: 300, color: Colors.red),
      ],
    );
  }
}

/*
 * COLUMN - with BOXES having Overlowded Issue on Bottom 
 */
class TestColumnWithColorBoxes extends StatelessWidget {
  const TestColumnWithColorBoxes({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(height: 300, color: Colors.green[100]),
        Container(height: 300, color: Colors.green[300]),
        Container(height: 300, color: Colors.green),
      ],
    );
  }
}

/*
 * CONTAINER -              test componenent
 * 
 */
class MyTestContainer extends StatelessWidget {
  const MyTestContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      width: 300,
      // color: Colors.purple,
      // padding: EdgeInsets.symmetric(horizontal: 25, vertical: 50),
      padding: EdgeInsets.all(25),
      margin: EdgeInsets.only(left: 25, top: 30),
      decoration: BoxDecoration(
        color: Colors.deepPurple,
        borderRadius: BorderRadius.circular(12),
      ),
      child: MyTestColumn(),
    );
  }
}

/*
 * COLUMN -              test componenent
 *  
 */
class MyTestColumn extends StatelessWidget {
  const MyTestColumn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final testcontroller = TextEditingController();
    return Column(
      children: [
        Text(
          "Tejas Patel",
          style: TextStyle(
              color: Colors.black, fontSize: 28, fontWeight: FontWeight.bold),
        ),

        SizedBox(
          height: 25,
        ),

        // Icon
        Icon(
          Icons.favorite,
          color: Colors.white,
          size: 50,
        ),

        SizedBox(
          height: 25,
        ),

        MyTextField(
            hintText: "kuch b enter karo",
            obscureText: false,
            controller: testcontroller)
      ],
    );
  }
}
