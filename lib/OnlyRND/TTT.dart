import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';


class MyApp1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Carousel Slider Demo',
      home: CarouselExample(),
    );
  }
}

class CarouselExample extends StatelessWidget {
  final List<String> imageList = [
    'https://picsum.photos/800/400?img=1',
    'https://picsum.photos/800/400?img=2',
    'https://picsum.photos/800/400?img=3',
    'https://picsum.photos/800/400?img=4',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Carousel Slider Example')),
      body: Center(
        child: CarouselSlider(
          options: CarouselOptions(
            height: 200.0,
            autoPlay: true,
            enlargeCenterPage: true,
            aspectRatio: 16 / 9,
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: Duration(seconds: 1),
            viewportFraction: 0.8,
          ),
          items: imageList.map((item) => Container(
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(item, fit: BoxFit.cover, width: 1000),
            ),
          )).toList(),
        ),
      ),
    );
  }
}
