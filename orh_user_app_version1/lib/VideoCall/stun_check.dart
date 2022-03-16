import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'dart:io';

class StunCheck extends StatefulWidget {
  const StunCheck({ Key? key }) : super(key: key);

  @override
  State<StunCheck> createState() => _StunCheckState();
}


void checkStunSta(){
     
  }

class _StunCheckState extends State<StunCheck> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: TextButton(
            onPressed: (){
              checkStunSta();
            },
            child: Text('Check stun server is working or not'),
          ),
        ),
      ),
    );
  }
}