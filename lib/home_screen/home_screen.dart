import 'package:animations/home_screen/bread_screen.dart';
import 'package:animations/home_screen/card_animation_2_screen.dart';
import 'package:animations/home_screen/card_animation_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Animations"),
      ),
      body: Column(
        children: [
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, CardAnimationScreen.name);
            },
            title: Text("Card Animation"),
            leading: Icon(Icons.card_membership),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          // ListTile(
          //   onTap: () {
          //     Navigator.pushNamed(context, BreadScreen.name);
          //   },
          //   title: Text("Breathe Animation"),
          //   leading: Icon(Icons.generating_tokens),
          //   trailing: Icon(Icons.arrow_forward_ios),
          // ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, CardAnimation2Screen.name);
            },
            title: Text("Card Animation 2.0"),
            leading: Icon(Icons.card_membership),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
    );
  }
}
