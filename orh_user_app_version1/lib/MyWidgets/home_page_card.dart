import 'package:flutter/material.dart';
import '../global_constant.dart';


Widget homePageCard(Color color, IconData icon, String title, Function func) {
    return InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: () {
            func();
          },
          child: Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(15),
            height: GeneralMeasurements.deviceHeight/100*10,
            width: GeneralMeasurements.deviceWidth / 2.4,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xff040039).withOpacity(.15),
                  blurRadius: 99,
                ),
              ],
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(),
                Container(
                  height: GeneralMeasurements.deviceWidth / 10,
                  width: GeneralMeasurements.deviceWidth / 10,
                  decoration: BoxDecoration(
                    color: color.withOpacity(.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    color: color.withOpacity(.6),
                  ),
                ),
                SizedBox(
                  width: GeneralMeasurements.deviceWidth/100*25,
                  child: Text(
                    title,
                    maxLines: 4,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black.withOpacity(.5),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(),
              ],
            ),
          ),
        );
  }