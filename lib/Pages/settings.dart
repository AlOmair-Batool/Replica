import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:sim/theme/colors.dart';
import '../pages/login_screen.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();
  // // editing Controller
  // final firstNameEditingController = new TextEditingController();
  // final secondNameEditingController = new TextEditingController();
  // final emailEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  // final confirmPasswordEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: secondary,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: ListView(
          children: [
            Text(
              "Settings",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Icon(
                  AntDesign.user,
                  color: secondary,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Account",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Divider(
              height: 15,
              thickness: 0.8,
            ),
            SizedBox(
              height: 10,
            ),
            buildAccountOptionRow(context, "Change password"),
            buildAccountOptionRow(context, "Language"),
            buildAccountOptionRow(context, "Privacy and security"),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Icon(
                  Icons.notifications_none_rounded,
                  color: secondary,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Notifications",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500), //
                ),
              ],
            ),
            Divider(
              height: 15,
              thickness: 0.8,
            ),
            SizedBox(
              height: 10,
            ),
            buildNotificationOptionRow("Updates", true),
            buildNotificationOptionRow("Daily encouragements", false),
            SizedBox(
              height: 50,
            ),
            Center(
              child: OutlineButton(
                padding: EdgeInsets.symmetric(horizontal: 40),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                child: Text("SIGN OUT",
                    style: TextStyle(
                        fontSize: 16, letterSpacing: 2.2, color: Colors.black)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Row buildNotificationOptionRow(String title, bool isActive) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: Colors.grey[600]),
        ),
        Transform.scale(
            scale: 0.7,
            child: CupertinoSwitch(
              value: isActive,
              onChanged: (bool val) {},
            ))
      ],
    );
  }
  //change passward
  Widget textForm(){
    return TextFormField(
      validator: (val){
        if(val!.length <6){
          return 'Please enter password with min 6 char length!';
        }else{
          return null;
        }
      },
      key: _formKey,
      controller: passwordEditingController, ///////////////////////////////////////////////////////////////////////////////
      decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black, width: 0.0),),
          isDense: true,
          label: Text("Reset password")
      ),
    );
  }
  // Button
  // Widget alertDialog(String title, String message) {
  //   return AlertDialog(
  //     title: Text("$title") ,
  //     content: Text("$message"),
  //   );
  // }
  // void check() async{
  //   DocumentReference ref = (await FirebaseFirestore.instance.collection('users')) as DocumentReference<Object?>;
  //
  //   setState(() {
  //     ref.update(
  //         { 'password': passwordEditingController.value.text}
  //     );
  //
  //   });
  //
  // }

  GestureDetector buildAccountOptionRow(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (_){
              return AlertDialog(

                title: Text("New Passward"),
                content: Container(
                  width: 250,
                  height: 250,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                        textForm(),
                        ElevatedButton(
                            onPressed: (){
                              setState(() {
                                passwordEditingController.clear();
                              });
                              // Navigator.pop(context);
                            },
                            child: Text("Update"),
                        )
                      ]),
                ),
              );
            });


      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors.grey[600],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 15,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
