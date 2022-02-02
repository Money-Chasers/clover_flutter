import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<String> images = [
    "https://firebasestorage.googleapis.com/v0/b/clover-650d4.appspot.com/o/carousel_imgs%2FC0.png?alt=media&token=bc76ea05-5a45-40d5-a476-3141efe92b1d",
"https://firebasestorage.googleapis.com/v0/b/clover-650d4.appspot.com/o/carousel_imgs%2FC1.jfif?alt=media&token=76dc3b36-e8f6-4168-a1cc-e63037f7e019",
    ""
  ];

  int activePage = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            carouselPlugin(images),
            Positioned(
              top: 180,
              left: 150,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: indicators(images.length, activePage),
              ),
            )
          ],
        ),
      ],
    );
  }

  carouselPlugin(images) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200.0,
        enlargeCenterPage: true,
        onPageChanged: (position, reason) {
          setState(() {
            activePage = position;
          });
        },
        enableInfiniteScroll: true,
      ),
      items: images.map<Widget>((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    image: DecorationImage(image: NetworkImage(i))));
          },
        );
      }).toList(),
    );
  }

  List<Widget> indicators(imagesLength, currentIndex) {
    return List<Widget>.generate(imagesLength, (index) {
      return Container(
        margin: const EdgeInsets.all(3),
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color: currentIndex == index ? Colors.black : Colors.black26,
            shape: BoxShape.circle),
      );
    });
  }
}
