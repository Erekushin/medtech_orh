import 'package:flutter/material.dart';

Widget eachHospital(){
  return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      child: const Center(
        child: Text('эмнэлэг',style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),),
      ),
    );
}

Widget hospitalsResultList(){
  return SizedBox(
                height: 400,
                child: ListView.builder(
                    itemCount: 50,
                    itemBuilder: (context, index){
                      return eachHospital();
                    }),
              );
}

