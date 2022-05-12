import 'package:flutter/material.dart';

/// 文本搜索框
class SearchTextFieldWidget extends StatelessWidget {

  final EdgeInsetsGeometry? margin;

  final String? hintText;

  final ValueChanged<String>? onSubmitted;

  final VoidCallback? onTap;

  const SearchTextFieldWidget({Key? key, this.margin, this.hintText, this.onSubmitted, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.all(0.0),
      width: MediaQuery.of(context).size.width,
      alignment: AlignmentDirectional.center,
      height: 40.0,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 237, 236, 237),
        borderRadius: BorderRadius.circular(24.0)
      ),
      child: TextField(
        onSubmitted: onSubmitted,
        onTap: onTap,
        cursorColor: const Color.fromARGB(255, 0, 189, 96),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(top: 3.0),
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: const TextStyle(
            fontSize: 17.0,
            color: Color.fromARGB(255, 192, 191, 191),
          ),
          prefixIcon: const Icon(
            Icons.search,
            size: 25.0,
            color: Color.fromARGB(255, 128, 128, 128),
          )
        ),
        style: const TextStyle(fontSize: 17.0),
      ),
    );
  }
}
