import 'package:flutter/material.dart';

class ShopPageWidget extends StatelessWidget {
  const ShopPageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.center,
      child: Text(
        "ShopPage",
        style: TextStyle(
          fontSize: 30.0,
        ),
      ),
    );
  }
}
