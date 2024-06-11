import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MonumentPlaces {
  final String name;
  final List<String> imagePaths;
  final String description;
  bool isFavorite;
  int price;

  MonumentPlaces({
    required this.name,
    required this.imagePaths,
    required this.description,
    this.isFavorite = false,
    this.price = 0,
  });
}

List<MonumentPlaces> monumentPlacesList = [
  MonumentPlaces(
    name: "Ibn Tulun Mosque",
    imagePaths: [
      'images/monumentosplaces/ibn tolon1.jpg',
      'images/monumentosplaces/ibn tolon3.jpg',
      'images/monumentosplaces/ibntolon2.jpg',
    ],
    description:
        "Ibn Tulun Mosque stands as a masterpiece of Islamic architecture, known for its grand scale and historical significance.",
  ),
  MonumentPlaces(
    name: "Al Azhar Mosque",
    imagePaths: [
      'images/monumentosplaces/azhar1.jpg',
      'images/monumentosplaces/azhar2.jpg',
      'images/monumentosplaces/azhar3.jpg',
    ],
    description:
        "Al-Azhar Mosque, a beacon of Islamic learning and spirituality, stands as a symbol of Egypt's rich cultural heritage.",
  ),
  MonumentPlaces(
    name: 'Muhammad Ali Mosque',
    imagePaths: [
      'images/monumentosplaces/mhmdali1.jpg',
      'images/monumentosplaces/mhmdali2.jpg',
      'images/monumentosplaces/mhmdali3.jpg',
    ],
    description:
        "The Muhammad Ali Mosque, with its majestic domes and towering minarets, commands admiration as a testament to Egypt's architectural prowess and Islamic heritage.",
  ),
  MonumentPlaces(
    name: 'Al Sultan Hassan Mosque',
    imagePaths: [
      'images/monumentosplaces/sultanhassan1.jpg',
      'images/monumentosplaces/sultan2.jpg',
      'images/monumentosplaces/sultan3.jpg',
    ],
    description:
        "The Sultan Hassan Mosque, a timeless marvel of Islamic architecture, embodies elegance and grandeur, captivating visitors with its intricate designs and sacred ambiance.",
  ),
  MonumentPlaces(
    name: 'Al-Hakim Mosque',
    imagePaths: [
      'images/monumentosplaces/hakem1.jpg',
      'images/monumentosplaces/hakeem2.jpg',
      'images/monumentosplaces/hakem3.jpg',
    ],
    description:
        "Al-Hakim Mosque, with its ancient walls whispering tales of faith and history, stands as a testament to the enduring legacy of Islamic architecture and spirituality.",
  ),
];

class monumentos extends StatefulWidget {
  monumentos({Key? key}) : super(key: key);

  static const screenRoute = '/monumentos';

  @override
  State<monumentos> createState() => _monumentosState();
}

class _monumentosState extends State<monumentos> {
  List<int> activeIndices = List.filled(monumentPlacesList.length, 0);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Monuments',
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
          
          for (int i = 0; i < monumentPlacesList.length; i++)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarouselSlider(
                  items: monumentPlacesList[i]
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
                    height: 180.h,
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
                SizedBox(height: 10.h),
                buildIndicator(
                    activeIndices[i], monumentPlacesList[i].imagePaths.length),
                SizedBox(height: 10.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Text(
                        monumentPlacesList[i].name,
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'MadimiOne',
                          color: Color.fromARGB(255, 83, 137, 182),
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Spacer(),
                     
                    ],
                  ),
                ),
                SizedBox(height: 5.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    monumentPlacesList[i].description,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Color.fromARGB(255, 36, 108, 163),
                      fontFamily: 'MadimiOne',
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(height: 5.h),

                SizedBox(height: 10.h),
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
          dotWidth: 18.w,
          dotHeight: 18.h,
          activeDotColor: Colors.blue,
          dotColor: Color.fromARGB(255, 16, 65, 106),
        ),
      ),
    );
  }
}
