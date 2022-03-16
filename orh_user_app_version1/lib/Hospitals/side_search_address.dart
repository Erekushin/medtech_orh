import 'package:flutter/material.dart';

import 'created_widgets.dart';

class SidePageForAddress extends StatefulWidget {
  const SidePageForAddress({Key? key}) : super(key: key);
  final padding = const EdgeInsets.symmetric(horizontal: 20);
  @override
  _SidePageForAddress createState() => _SidePageForAddress();
}

class _SidePageForAddress extends State<SidePageForAddress> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFFEAE9ED),
      child: Container(
        margin: const EdgeInsets.only(top: 50, left: 5, right: 5, bottom: 50),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                child: const TextField(
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide:  BorderSide(color: Colors.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:  BorderSide(color: Colors.white),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Эмнэлэгийн нэр',
                    labelText: 'Эмнэлэгийн нэр',
                  ),
                ),
              ),

              hospitalsResultList()
            ],
          ),
        ),
      ),
    );
  }
}

