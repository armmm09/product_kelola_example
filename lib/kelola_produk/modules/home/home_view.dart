import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:lazyui/lazyui.dart';

import '../../providers/product/product_provider.dart';
import '../../providers/transaction/transaction_provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final List<Widget> imageSliders = [
    // Debit Card 1
    Container(
      width: 400, // Lebar kartu
      height: 200, // Tinggi kartu
      margin: EdgeInsets.symmetric(horizontal: 8.0), // Spasi antara kartu
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey,
      ),
      child: Center(
        child: Text(
          'Total Customer = 3',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    ),

    // Debit Card 2
    Container(
      width: 400, // Lebar kartu
      height: 200, // Tinggi kartu
      margin: EdgeInsets.symmetric(horizontal: 8.0), // Spasi antara kartu
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey,
      ),
      child: Center(
        child: Text(
          'Banyak Product =  ${daftarProducts.length}'
,
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    ),
    // Debit Card 3
    Container(
      width: 400, // Lebar kartu
      height: 200, // Tinggi kartu
      margin: EdgeInsets.symmetric(horizontal: 8.0), // Spasi antara kartu
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey,
      ),
      child: Center(
        child: Text(
          'Transaksi Hari Ini =  ${daftarPay.length}',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    ),
  ];

  int _currentCard = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LzListView(
        padding: Ei.sym(v: 70, h: 10),
        children: [
          Text(
            '  Hello',
            style: gfont.bold.fsize(18.0).black,
          ),
          Row(
            mainAxisAlignment: Maa.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '  Yuta Okkotsu  ',
                      style: gfont.bold.fsize(25.0).black,
                    ),
                  ],
                ),
              ),
              Container(
                width: 40.0, // Atur lebar foto sesuai kebutuhan Anda
                height: 40.0, // Atur tinggi foto sesuai kebutuhan Anda
                child: LzImage('yuta.jpg'),
              ),
            ],
          ),
          SizedBox(height: 25),
          Row(
            mainAxisAlignment: Maa.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '   My Card ',
                      style: gfont.fsize(20.0).black.bold,
                    ),
                  ],
                ),
              ),
              Container(
                width: 50.0, // Atur lebar foto sesuai kebutuhan Anda
                height: 50.0, // Atur tinggi foto sesuai kebutuhan Anda
                child: Icon(Ti.arrowRight, color: Colors.blue, size: 30),
              ),
            ],
          ),

          CarouselSlider(
            options: CarouselOptions(
              autoPlay: false,

              enlargeCenterPage: false,
              aspectRatio: 2.2,
              enlargeStrategy: CenterPageEnlargeStrategy.height,
              viewportFraction: 0.79,
              padEnds: false,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentCard = index;
                });
              },
              // Hapus viewportFraction
              // itemHeight dan itemWidth sekarang akan berfungsi tanpa konflik
              // Spasi antara kartu
            ),
            items: imageSliders,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imageSliders.map((item) {
              int index = imageSliders.indexOf(item);
              return Container(
                width: 8.0,
                height: 8.0,
                margin: Ei.sym(v: 15, h: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentCard == index ? Colors.lightBlue : Colors.grey,
                ),
              );
            }).toList(),
          ),
          
          SizedBox(height: 30.0), //
          
        ],
      ),
    );
  }
}



