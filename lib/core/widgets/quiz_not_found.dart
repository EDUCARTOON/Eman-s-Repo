import 'package:flutter/material.dart';

class QuizNotFound extends StatelessWidget {
  const QuizNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QuizApp',style: TextStyle(
          fontSize: 25,fontWeight: FontWeight.bold
        ),),
        centerTitle: true,
      ),
      body: Center(
        child: Text('Not Quiz yet?',style: TextStyle(
            fontSize: 25,fontWeight: FontWeight.bold
        ),),
      ),
    );
  }
}
