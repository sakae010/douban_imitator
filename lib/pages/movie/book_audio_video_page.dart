import 'package:flutter/material.dart';

class BookAudioVideoPage extends StatefulWidget {
  const BookAudioVideoPage({Key? key}) : super(key: key);

  @override
  State<BookAudioVideoPage> createState() => _BookAudioVideoPageState();
}

class _BookAudioVideoPageState extends State<BookAudioVideoPage> {
  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.center,
      child: Text(
        "BookAudioVideoPage",
        style: TextStyle(
          fontSize: 30.0,
        ),
      ),
    );
  }
}
