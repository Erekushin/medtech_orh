import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import 'Controllers/image_controller.dart';

class RecipeBaseTest extends StatefulWidget {
  const RecipeBaseTest({ Key? key }) : super(key: key);

  @override
  State<RecipeBaseTest> createState() => _RecipeBaseTestState();
}

class _RecipeBaseTestState extends State<RecipeBaseTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text('recipe base test'),
        ),
      ),
    );
  }
}


class MlearningTest extends StatefulWidget {
  const MlearningTest({ Key? key }) : super(key: key);

  @override
  State<MlearningTest> createState() => _MlearningTestState();
}

class _MlearningTestState extends State<MlearningTest> {
  var imageCont = Get.find<ImageController>();
  Random randomN = Random();
  var searchController = TextEditingController();
  choseGirls(){
    int hotkeyCount = 0;
    int hotterkeyCount = 0;
    int hotCount = 0;
    int hotterCount = 0;
    for(int a = 0; a<keyword.length; a++){
      switch(keyword[a]){
        case 'my-X':
        hotkeyCount++;
        break;
        case 'apple':
        hotterkeyCount++;
        break;
      }
    }
    hotCount = ((10/100)*(hotkeyCount * (100/keyword.length))).truncate();
    hotterCount = ((10/100)*(hotterkeyCount * (100/keyword.length))).truncate();
    keyword.add(searchController.text);
    switch(searchController.text){
      case '':
         for(int i = 0; i<hotCount; i++){
      int randomIndex = randomN.nextInt(12);
      imageCont.randomImageList.add(imageListMyx[randomIndex]);
    }
     for(int i = 0; i<hotterCount; i++){
      int randomIndex = randomN.nextInt(12);
      imageCont.randomImageList.add(imageListApple[randomIndex]);
    }
      break;
      case 'my-X':
      for(int i = 0; i<10; i++){
      int randomIndex = randomN.nextInt(12);
      imageCont.randomImageList.add(imageListMyx[randomIndex]);
    }
      break;
      case 'apple':
      for(int i = 0; i<10; i++){
      int randomIndex = randomN.nextInt(12);
      imageCont.randomImageList.add(imageListApple[randomIndex]);
    }
      break;

    }
  }
    List<String> imageListMyx = [
  'https://pbs.twimg.com/media/EUj1VojXQAEL9Og.jpg',
  'https://i.pinimg.com/736x/07/d9/aa/07d9aa0fe08cad477e8d3bb4adfe1de2.jpg',
  'https://64.media.tumblr.com/a1e399009b27bfcd0036c6a5b3b976c7/c97734e9ca66ce39-74/s1280x1920/cb952c12415dbb8901548d89624796e94e368356.jpg',
  'https://images.squarespace-cdn.com/content/v1/58404f45579fb31c9d8d3236/1495487733438-5P75SCPEM6LAQXWAW1UV/You%E2%80%99re+Pretty%2C+for+a+Black+Girl_headerimage.jpg?format=1000w',
  'https://resize.img.allw.mn/thumbs/l2/ak/zbnr34un59942cf80a67c190618276_1002x1002.jpg?width=1200&height=900',
  'https://i.pinimg.com/736x/16/0c/b9/160cb9705769521aa3cd36fbd7ebca3c.jpg',
  'https://orlandosolution.com/wp-content/uploads/2020/03/origienal.jpg',
  'https://ak.picdn.net/shutterstock/videos/31227436/thumb/1.jpg',
  'https://orlandosolution.com/wp-content/uploads/2020/03/3a0fb041481839effb5c57b493a74af32.jpg',
   'https://i.pinimg.com/474x/b8/8b/63/b88b6339bf31451a11bd732210265386.jpg',
  'https://i.pinimg.com/736x/f7/e2/2b/f7e22bd2663a25698fffbbb0c3de7574.jpg',
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT6J4c-6fAjGIfBLs40bXk812rIlU2VDW1qHuhqQ1HZKobJI4FKJhiJl-vcnVYF4ivKcOA&usqp=CAU',
];

  List<String> imageListApple = [
  'https://wallpaperaccess.com/full/1259314.jpg',
  'https://www.teahub.io/photos/full/5-54275_wallpaper-apples-fruit-ripe-red-apple-fruit-wallpaper.jpg',
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTsVSL9JIqXE0fZ8Crg9K3pQ44qRxIF6eeOG65bbggozEOAJBswGO4g0gsKVQ-32tK-lhM&usqp=CAU',
  'https://image.winudf.com/v2/image/Y29tLkxpdmVXYWxscGFwZXJzVUEuYXBwMDU5Ml9zY3JlZW5fMF9ybGF2Z25pdQ/screen-0.jpg?fakeurl=1&type=.jpg',
  'https://img5.goodfon.com/wallpaper/nbig/e/c7/cut-fruit-apple.jpg',
  'https://i.pinimg.com/originals/0d/37/89/0d378911c3837ff3eb579d8f894860ca.jpg',
  'https://www.wallpaperflare.com/static/944/986/519/apple-surface-drops-red-wallpaper.jpg',
  'https://images6.alphacoders.com/434/434575.jpg',
  'https://wallpaperboat.com/wp-content/uploads/2021/04/05/73372/apple-fruit-06.jpg',
  'http://images2.fanpop.com/images/photos/7000000/Apple-Wallpaper-fruit-7004640-1024-768.jpg',
  'https://r1.ilikewallpaper.net/ipad-wallpapers/download/11171/Apple-Fruit-ipad-wallpaper-ilikewallpaper_com.jpg',
  'https://www.itl.cat/pngfile/big/83-839601_red-apples-and-berries-fresh-fruit-wallpaper-apple.jpg'

  ];

  
  List<String> keyword = ['my-X', 'apple'];
  @override
  void initState() {
    super.initState();
    imageCont.randomImageList.clear();
    choseGirls();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
           Align(
             alignment: Alignment.topCenter,
             child: Container(
               padding: const EdgeInsets.only(left: 30),
               margin: const EdgeInsets.only(top: 20, bottom: 10, left: 30, right: 30),
               decoration: const BoxDecoration(
                 borderRadius: BorderRadius.all(Radius.circular(15)),
                 color: Colors.white
               ),
               child: TextField(
                 controller: searchController,
                 decoration: InputDecoration(
                   suffixIcon: IconButton(
                     onPressed: (){
                       setState(() {
                         imageCont.randomImageList.clear();
                         choseGirls();
                       });
                     },
                     icon: const Icon(Icons.arrow_circle_right)),
                   hintText: 'Search...',
                   disabledBorder: InputBorder.none,
                   enabledBorder: InputBorder.none,
                   focusedBorder: InputBorder.none
                 ),
               ),
             ),
           ),
           Container(
             margin: const EdgeInsets.only(top: 80, bottom: 10),
             child: GetX<ImageController>(builder: (imageController){
               return MasonryGridView.count(
               crossAxisCount: 2,
               crossAxisSpacing: 10,
               mainAxisSpacing: 12,
               itemCount: imageController.randomImageList.length,
               itemBuilder: (context, index){
                 return Container(
                  decoration: const BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.all(
                          Radius.circular(15))
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(
                        Radius.circular(15)),
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/images/loading.jpg',
                      image: imageController.randomImageList[index],fit: BoxFit.cover,),
                  ),
                );
               }
               );
             })
           )

        ],),
      ),
      );
  }
}