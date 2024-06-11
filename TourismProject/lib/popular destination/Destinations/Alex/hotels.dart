import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../Cairo/hotels.dart';
import 'info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import '../hotel.dart';

List<Hotel> alexHotels = [
  Hotel(
      name: "Amoun Hotel",
      imagePaths: [
        'images/alexhotels/amoun1.jpg',
        'images/alexhotels/amoun2.jpg',
        'images/alexhotels/amoun3.jpg',
        'images/alexhotels/amoun4.jpg',
      ],
      description:
          "Hotels offer a temporary haven, providing comfort, convenience, and often a touch of luxury for travelers seeking respite from their journeys.",
      price: 0,
      url: "https://www.hilton.com/en/hotels/cairhtw-ramses-hilton/",
      locationurl: "https://maps.app.goo.gl/5BagZnX3FkNQB7wP9",
      isFavorite: false),
  Hotel(
      name: "Green Plaza Inn",
      imagePaths: [
        'images/alexhotels/green1.jpg',
        'images/alexhotels/green2.jpg',
        'images/alexhotels/green3.jpg',
        'images/alexhotels/green4.jpg',
      ],
      description:
          "From opulent suites to cozy rooms, hotels offer a spectrum of accommodations to suit every taste and budget.",
      price: 0,
      url: "https://www.hilton.com/en/hotels/cairhtw-ramses-hilton/",
      locationurl: "https://maps.app.goo.gl/fVAMoGT9ri5Xcvfn9",
      isFavorite: false),
  Hotel(
      name: 'Hilton Alexandria Corniche',
      imagePaths: [
        'images/alexhotels/hilton1.jpg',
        'images/alexhotels/hilton2.jpg',
        'images/alexhotels/hilton3.jpg',
        'images/alexhotels/hilton4.jpg',
      ],
      description:
          "Hotels welcome weary travelers with open arms, offering a sanctuary where comfort meets convenience.",
      price: 0,
      url: "https://www.hilton.com/en/hotels/cairhtw-ramses-hilton/",
      locationurl: "https://maps.app.goo.gl/dkvCvDp1ss1yUafh6",
      isFavorite: false),
  Hotel(
      name: 'Royal Crown Hotel',
      imagePaths: [
        'images/alexhotels/royal1.jpg',
        'images/alexhotels/royal2.jpg',
        'images/alexhotels/royal3.jpg',
        'images/alexhotels/royal4.jpg',
      ],
      description:
          "Indulge in a world of comfort and luxury at our exquisite hotel, where every moment is crafted to exceed your expectations and leave you with cherished memories to last a lifetime",
      price: 0,
      url: "https://www.hilton.com/en/hotels/cairhtw-ramses-hilton/",
      locationurl: "https://maps.app.goo.gl/V65mZdsQBXiAum8F8",
      isFavorite: false),
  Hotel(
      name: 'Semiramis Hotel',
      imagePaths: [
        'images/alexhotels/sim1.jpg',
        'images/alexhotels/sim2.jpg',
        'images/alexhotels/sim3.jpg',
        'images/alexhotels/sim4.jpg',
      ],
      description:
          "Experience the epitome of luxury and sophistication at Semirames Hotel, where timeless elegance meets modern comfort, creating an unforgettable oasis for discerning travelers.",
      price: 0,
      url: "https://www.hilton.com/en/hotels/cairhtw-ramses-hilton/",
      locationurl: "https://maps.app.goo.gl/SoHExAQc28ymgPP58",
      isFavorite: false),
  // Add more hotels here
];

class ScreenOne extends StatefulWidget {
  ScreenOne({Key? key});

  @override
  State<ScreenOne> createState() => _ScreenOneState();
}

class _ScreenOneState extends State<ScreenOne> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _userId;
  String? _firestoreUserId;
  List<Hotel> favoriteHotels = [];
  List<int> activeIndices = List.filled(alexHotels.length, 0);
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getHotelPrices();
    _auth.authStateChanges().listen((User? user) {
      setState(() {
        _userId = user?.uid;
        if (_userId != null) {
          getFirestoreUserId(_userId!);
        }
      });
    });
  }

  void getFirestoreUserId(String uid) async {
    try {
      DocumentSnapshot docSnapshot =
          await FirebaseFirestore.instance.collection('Usere').doc(uid).get();
      if (docSnapshot.exists) {
        setState(() {
          _firestoreUserId =
              docSnapshot.get('userId') as String?; // Safe cast to String?
        });
      } else {
        print('User document does not exist in Firestore');
      }
    } catch (e) {
      print('Error getting user ID from Firestore: $e');
    }
  }

  void toggleFavoriteStatus(int index) async {
    if (_firestoreUserId == null)
      return; // Cannot proceed without a Firestore user ID

    final hotel = alexHotels[index]; // Use alexHotels instead of cairoHotels
    final hotelRef =
        FirebaseFirestore.instance.collection('Hotels').doc(hotel.name);
    final userFavoritesRef = FirebaseFirestore.instance
        .collection('Usere')
        .doc(_firestoreUserId!)
        .collection('favorites');

    // Update the isFavorite field in the hotel document
    await hotelRef.update({'isFavourite': !hotel.isFavorite});

    // Add or remove the hotel from the user's favorites sub-collection
    if (!hotel.isFavorite) {
      // Add to favorites
      await userFavoritesRef.doc(hotel.name).set({
        'name': hotel.name,
        // Add any other relevant data you want to store
      });
    } else {
      // Remove from favorites
      await userFavoritesRef.doc(hotel.name).delete();
    }

    // Update the local state to reflect the change
    setState(() {
      alexHotels[index].isFavorite = !alexHotels[index]
          .isFavorite; // Use alexHotels instead of cairoHotels
    });
  }

  Future<void> getHotelPrices() async {
    for (int i = 0; i < alexHotels.length; i++) {
      DocumentSnapshot document = await FirebaseFirestore.instance
          .collection('Hotels')
          .doc(alexHotels[i].name)
          .get();
      if (document.exists) {
        int price = document.get('price');
        bool isFavorite = document.get('isFavourite');
        alexHotels[i] = Hotel(
          name: alexHotels[i].name,
          imagePaths: alexHotels[i].imagePaths,
          description: alexHotels[i].description,
          price: price,
          url: alexHotels[i].url,
          locationurl: alexHotels[i].locationurl,
          isFavorite: isFavorite,
        );
        if (price == 0) {
          setState(() {
            isLoading = true;
          });
        } else {
          setState(() {
            isLoading = false;
          });
        }
      } else {
        print('Document does not exist');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Alexandria',
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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SecRoute()),
            );
          },
        ),
      ),
      body: ListView(
        children: [
          Center(
            child: Text(
              'Hotels',
              style: TextStyle(
                fontFamily: 'MadimiOne',
                color: Color.fromARGB(255, 121, 155, 230),
                fontSize: 25.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 20.h),
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
                    activeIndices[i], alexHotels[i].imagePaths.length),
                SizedBox(height: 10.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      SizedBox(width: 8.w),
                      Text(
                        alexHotels[i].name,
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'MadimiOne',
                          color: Color.fromARGB(255, 83, 137, 182),
                        ),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(width: 8.w),
                      GestureDetector(
                        onTap: () {
                          _launchURL(alexHotels[i]
                              .locationurl); // Launch URL when tapped
                        },
                        child: Icon(
                          Icons.location_on,
                          color: Color.fromARGB(255, 5, 59, 107),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      GestureDetector(
                        onTap: () {
                          toggleFavoriteStatus(i);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(alexHotels[i].isFavorite
                                  ? 'Removed from Favorites!'
                                  : 'Added to Favorites!'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                        child: Icon(
                          alexHotels[i].isFavorite
                              ? Icons.favorite
                              : Icons.favorite_outline,
                          color: Color.fromARGB(255, 13, 16, 74),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      GestureDetector(
                        onTap: () {
                          _launchURL(
                              cairoHotels[i].url); // Launch URL when tapped
                        },
                        child: Icon(
                          Icons.link,
                          color: Colors.blue, // Use blue color for link icon
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    alexHotels[i].description,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Color.fromARGB(255, 36, 108, 163),
                      fontFamily: 'MadimiOne',
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(height: 5.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      if (isLoading)
                        CircularProgressIndicator(), // Show loading icon
                      if (!isLoading && alexHotels[i].price != 0)
                        Text(
                          alexHotels[i].price.toString(),
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Color.fromARGB(255, 5, 59, 107),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      if (!isLoading && alexHotels[i].price != 0)
                        SizedBox(width: 8.w),
                      if (!isLoading && alexHotels[i].price != 0)
                        Text(
                          "EGP",
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Color.fromARGB(255, 5, 59, 107),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ],
                  ),
                ),
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

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
