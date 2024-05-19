
import 'package:flutter/material.dart';

class MainChat extends StatefulWidget {
  const MainChat({Key? key}) : super(key: key);

  @override
  State<MainChat> createState() => _MainChatState();
}

class _MainChatState extends State<MainChat> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text("Chat"),
    );
  }
}
