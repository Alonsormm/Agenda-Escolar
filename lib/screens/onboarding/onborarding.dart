import 'package:flutter/material.dart';

class Onboarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: 4,
      itemBuilder: (context, index){
        return Center(child: Text('page $index')); 
      },
    );
  }
}