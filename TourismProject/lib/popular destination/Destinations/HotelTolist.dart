import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/widgets.dart';
import 'hotel.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HotelListItem extends StatelessWidget {
  final Hotel hotel;
  final int activeIndex;
  final List<String> imagePaths;

  HotelListItem(this.hotel, this.activeIndex, this.imagePaths);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
          items: hotel.imagePaths
              .map((imagePath) => Container(
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(imagePath),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ))
              .toList(),
          options: CarouselOptions(
            height: 180,
            aspectRatio: 16 / 9,
            viewportFraction: 0.8,
            autoPlay: false,
            enlargeCenterPage: true,
          ),
        ),
        SizedBox(height: 10),
        buildIndicator(activeIndex, imagePaths.length),
        SizedBox(height: 10),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                SizedBox(width: 8),
                Text(
                  hotel.name,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'MadimiOne',
                    color: Color.fromARGB(255, 83, 137, 182),
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(width: 8),
                Icon(
                  Icons.location_on,
                  color: Color.fromARGB(255, 5, 59, 107),
                ),
                SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Added to Trip!'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  child: Icon(
                    Icons.add_circle_outline,
                    color: Color.fromARGB(255, 13, 16, 74),
                  ),
                ),
              ],
            )),
        SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            hotel.description,
            style: TextStyle(
              fontSize: 16,
              color: Color.fromARGB(255, 36, 108, 163),
              fontFamily: 'MadimiOne',
            ),
            textAlign: TextAlign.left,
          ),
        ),
        SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              if (hotel.price != 0)
                Text(
                  hotel.price.toString(),
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 5, 59, 107),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              if (hotel.price != 0) SizedBox(width: 8),
              if (hotel.price != 0)
                Text(
                  "EGP",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 5, 59, 107),
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  Widget buildIndicator(int activeIndex, int length) {
    return Center(
      child: AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: length,
        effect: WormEffect(
          dotWidth: 18,
          dotHeight: 18,
          activeDotColor: Colors.blue,
          dotColor: Color.fromARGB(255, 16, 65, 106),
        ),
      ),
    );
  }
}
