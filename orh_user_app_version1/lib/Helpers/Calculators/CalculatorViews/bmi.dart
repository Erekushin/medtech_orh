import 'package:flutter/material.dart';

class BMI extends StatelessWidget {
  const BMI({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {  //60/(174*174)*10000 jin/(ondor*ondor)*10000
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            children: [
              Text('Биеийн жин (kg)'),
              TextField(),
              Text('Өндөр'),
              TextField()
            ],
          ),
        ),
      ),
    );
  }
}