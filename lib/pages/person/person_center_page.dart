import 'package:flutter/material.dart';

class PersonCenterPage extends StatelessWidget {
  const PersonCenterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.center,
      child: Text(
        "PersonCenterPage",
        style: TextStyle(
          fontSize: 30.0,
        ),
      ),
    );
  }
}
