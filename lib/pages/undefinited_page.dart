import 'package:flutter/material.dart';

class UndefinitedPage extends StatelessWidget {
  final String? name;
  const UndefinitedPage({Key? key, this.name = ""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Undefinited View")),
      body: Center(
        child: Text("Route for $name is not defined"),
      ),
    );
  }
}
