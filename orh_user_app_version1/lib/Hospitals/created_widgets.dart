import 'package:flutter/material.dart';
import '../global_constant.dart';

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

Widget searchBtn(String btntext, Color btncolor){
  return  Container(
            margin: const EdgeInsets.all(10),
            height: 180,
            width: GeneralMeasurements.deviceWidth/2 - 40,
            decoration: BoxDecoration(
              color: btncolor,
              boxShadow: [
                BoxShadow(color: btncolor.withOpacity(0.6), spreadRadius: 0.1, blurRadius: 10, offset: const Offset(0, 7))
                ],
              borderRadius: const BorderRadius.all(Radius.circular(30))
            ),
            child:  Center(
              child: Text(btntext,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),),
              )
          );
}

