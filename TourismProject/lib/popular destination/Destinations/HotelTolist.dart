import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'hotel.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HotelListItem extends StatefulWidget {
  final Hotel hotel;
  final int activeIndex;
  final List<String> imagePaths;

  HotelListItem(this.hotel, this.activeIndex, this.imagePaths);

  @override
  _HotelListItemState createState() => _HotelListItemState();
}

class _HotelListItemState extends State<HotelListItem> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.activeIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
          items: widget.hotel.imagePaths
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
            onPageChanged: (index,reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
        SizedBox(height: 10),
        buildIndicator(_currentIndex, widget.imagePaths.length),
        SizedBox(height: 10),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                SizedBox(width: 8),
                Text(
                  widget.hotel.name,
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
                SizedBox(
                  width: 8,
                ),
                GestureDetector(
                  onTap: () {
                    FirebaseFirestore.instance
                .collection('Hotels')
                .doc(widget.hotel.name)
                .update({'isFavourite': false})
                .then((_) {
                  // Snackbar to show the update is successful
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Removed from Favorites'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                })
                .catchError((error) {
                  // Handle the error
                  print('Error updating document: $error');
                });
                  },
                  child: Icon(
                    Icons.remove,
                    color: Color.fromARGB(255, 13, 16, 74),
                  ),
                )
              ],
            )),
        SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            widget.hotel.description,
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
              if (widget.hotel.price != 0)
                Text(
                  widget.hotel.price.toString(),
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 5, 59, 107),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              if (widget.hotel.price != 0) SizedBox(width: 8),
              if (widget.hotel.price != 0)
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
