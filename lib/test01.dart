import 'package:flutter/material.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  int _counter = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My page")),
      body: Container(child: Column(children: [_buildButton, _buildText])),
    );
  }

  Widget get _buildButton {
    return Expanded(
      child: Center(
        child: IconButton(
          onPressed: () {
            setState(() => _counter++);
          },
          icon: Icon(Icons.add_box_outlined, size: 30),
        ),
      ),
    );
  }

  Widget get _buildText {
    return Expanded(
      child: Center(child: Text("$_counter", style: TextStyle(fontSize: 50))),
    );
  }
}
