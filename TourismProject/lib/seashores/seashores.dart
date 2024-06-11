import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class seashores {
  final String name;
  final List<String> imagePaths;
  final String description;
  bool isFavorite;
  int price;

  seashores({
    required this.name,
    required this.imagePaths,
    required this.description,
    this.isFavorite = false,
    this.price = 0,
  });
}

List<seashores> alexHotels = [
 seashores(
    name: "Marsa Matrouh shore",
    imagePaths: [
      'images/seashores/matroh1.jpg',
      'images/seashores/matroh2.jpg',
      'images/seashores/matroh3.jpg',
    ],
    description: "Marsa Matrouh shore is known for its clear turquoise waters and beautiful sandy beaches, offering a perfect tranquil escape.",
  ),
   seashores(
    name: "Marsa Alam shore",
    imagePaths: [
      'images/seashores/marsaalam1.jpg',
      'images/seashores/marsaalam2.jpg',
      'images/seashores/marsaalam3.jpg',
    ],
    description: "Marsa Alam is famed for its vibrant coral reefs and crystal-clear waters, making it a paradise for divers and nature lovers.",
  ),
  seashores(
    name: 'Alamein shore',
    imagePaths: [
      'images/seashores/alamein.jpg',
      'images/seashores/alamein2.jpg',
      'images/seashores/alamein3.jpg',
    ],
    description: "Alamein shore boasts pristine beaches and azure waters, providing a serene escape on the Mediterranean coast.",
  ),
   seashores(
    name: 'Ain elsokhna shore',
    imagePaths: [
      'images/seashores/ainsokhna1.jpg',
      'images/seashores/ainsokhna2.jpg',
      'images/seashores/ainsokhna3.jpg',
    ],
    description: "Ain El Sokhna shore offers a peaceful retreat with its clear waters and sandy beaches, perfect for relaxation and seaside enjoyment.",
  ),
   seashores(
    name: 'Hurghada shore',
    imagePaths: [
      'images/seashores/hurghada1.jpg',
      'images/seashores/hurghada2.jpg',
      'images/seashores/hurghada3.jpg',
    ],
    description: "Ain El Sokhna shore offers a peaceful retreat with its clear waters and sandy beaches, perfect for relaxation and seaside enjoyment.",
  ),
];

class shores extends StatefulWidget {
  shores({Key? key}) : super(key: key);

  static const screenRoute = '/shores';

  @override
  State<shores> createState() => _shoresState();
}

class _shoresState extends State<shores> {
  List<int> activeIndices = List.filled(alexHotels.length, 0);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Shores',
          style: TextStyle(
            fontFamily: 'MadimiOne',
            color: Color.fromARGB(255, 121, 155, 228),
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: GestureDetector(
          child: const Icon(
            Icons.arrow_back_ios,
            color: Color.fromARGB(255, 121, 155, 228),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: [
          
          SizedBox(height: 20),
          for (int i = 0; i < alexHotels.length; i++)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarouselSlider(
                  items: alexHotels[i]
                      .imagePaths
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
                    onPageChanged: (index, reason) {
                      setState(() {
                        activeIndices[i] = index;
                      });
                    },
                  ),
                ),
                SizedBox(height: 10),
                buildIndicator(activeIndices[i], alexHotels[i].imagePaths.length),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Text(
                        alexHotels[i].name,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'MadimiOne',
                          color: Color.fromARGB(255, 83, 137, 182),
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Spacer()
                    ],
                  ),
                ),
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    alexHotels[i].description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 36, 108, 163),
                      fontFamily: 'MadimiOne',
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
        ],
      ),
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
