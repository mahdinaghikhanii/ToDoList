import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NotFound extends StatelessWidget {
  const NotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LottieBuilder.asset('assets/lottie/task.json', width: 250),
          Center(
              child: Text(
            "Your task list is empty",
            style: Theme.of(context).textTheme.titleLarge,
          ))
        ],
      ),
    );
  }
}
