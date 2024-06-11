import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import '../hotel.dart';

List<Hotel> siwaHotels = [
  Hotel(
      name: "Albabenshal-guest House",
      imagePaths: [
        'images/siwahotels/alb1.jpg',
        'images/siwahotels/alb2.jpg',
        'images/siwahotels/alb3.jpg',
        'images/siwahotels/alb4.jpg',
      ],
      description: "Albabenshal Guest House: Your cozy retreat in siwa",
      price: 0,
      url:
          "https://www.tripadvisor.com/Hotel_Review-g303857-d1013378-Reviews-Albabenshal-Siwa_Matrouh_Governorate.html",
      locationurl: "https://maps.app.goo.gl/jru13ZKiBm3RnRYq6",
      isFavorite: false),
  Hotel(
      name: "Forest camp Siwa",
      imagePaths: [
        'images/siwahotels/for1.jpg',
        'images/siwahotels/for2.jpg',
        'images/siwahotels/for3.jpg',
        'images/siwahotels/for4.jpg',
      ],
      description:
          "Forest Camp Siwa: Your serene oasis amidst nature's embrace.",
      price: 0,
      url:
          "https://www.tripadvisor.com/Hotel_Review-g303857-d27162328-Reviews-Forest_Camp_Siwa-Siwa_Matrouh_Governorate.html",
      locationurl: "https://maps.app.goo.gl/XpLMxvXnG7fxZnnSA",
      isFavorite: false),
  Hotel(
      name: 'Shali Ladge',
      imagePaths: [
        'images/siwahotels/shali1.jpg',
        'images/siwahotels/shali2.jpg',
        'images/siwahotels/shali3.jpg',
        'images/siwahotels/shali4.jpg',
      ],
      description: "Shali Lodge: Your serene oasis in Siwa",
      price: 0,
      url: "https://www.siwashaliresort.com/index.html",
      locationurl: "https://maps.app.goo.gl/Z4TjzYPF9QShWXKm7",
      isFavorite: false),
  Hotel(
      name: 'Siwa Paradise',
      imagePaths: [
        'images/siwahotels/para1.jpg',
        'images/siwahotels/para2.jpg',
        'images/siwahotels/para3.jpg',
        'images/siwahotels/para4.jpg',
      ],
      description:
          "Siwa Paradise: Where desert serenity meets comfort, promising an unforgettable oasis retreat.",
      price: 0,
      url: "https://siwa-paradise-siwa-oasis.albooked.com/",
      locationurl: "https://maps.app.goo.gl/EXAX74NPwEHnziAe9",
      isFavorite: false),
  Hotel(
      name: 'Siwa Camp Osman Oasis',
      imagePaths: [
        'images/siwahotels/camp1.jpg',
        'images/siwahotels/camp2.jpg',
        'images/siwahotels/camp3.jpg',
        'images/siwahotels/camp4.jpg',
      ],
      description:
          "Siwa Camp Osman Oasis: Your tranquil retreat amidst the beauty of Siwa's natural splendor.",
      price: 0,
      url: "https://www.booking.com/hotel/eg/siwa-camp-osman-oasis.html",
      locationurl: "https://maps.app.goo.gl/gfcqqGKpbimQCqUQA",
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
  List<int> activeIndices = List.filled(siwaHotels.length, 0);
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

    final hotel = siwaHotels[index]; // Use alexHotels instead of cairoHotels
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
      siwaHotels[index].isFavorite = !siwaHotels[index]
          .isFavorite; // Use alexHotels instead of cairoHotels
    });
  }

  Future<void> getHotelPrices() async {
    for (int i = 0; i < siwaHotels.length; i++) {
      DocumentSnapshot document = await FirebaseFirestore.instance
          .collection('Hotels')
          .doc(siwaHotels[i].name)
          .get();
      if (document.exists) {
        int price = document.get('price');
        bool isFavorite =
            document.get('isFavourite'); // Get isFavorite value from Firestore
        siwaHotels[i] = Hotel(
          name: siwaHotels[i].name,
          imagePaths: siwaHotels[i].imagePaths,
          description: siwaHotels[i].description,
          price: price,
          url: siwaHotels[i].url,
          locationurl: siwaHotels[i].locationurl,
          isFavorite: isFavorite, // Set the retrieved isFavorite value
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
          'Siwa',
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
              MaterialPageRoute(builder: (context) => FourthRoute()),
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
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 20),
          for (int i = 0; i < siwaHotels.length; i++)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarouselSlider(
                  items: siwaHotels[i]
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
                buildIndicator(
                    activeIndices[i], siwaHotels[i].imagePaths.length),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      SizedBox(width: 8),
                      Text(
                        siwaHotels[i].name,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'MadimiOne',
                          color: Color.fromARGB(255, 83, 137, 182),
                        ),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          _launchURL(siwaHotels[i]
                              .locationurl); // Launch URL when tapped
                        },
                        child: Icon(
                          Icons.location_on,
                          color: Color.fromARGB(255, 5, 59, 107),
                        ),
                      ),
                      SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          toggleFavoriteStatus(i);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(siwaHotels[i].isFavorite
                                  ? 'Removed from Favorites!'
                                  : 'Added to Favorites!'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                        child: Icon(
                          siwaHotels[i].isFavorite
                              ? Icons.favorite
                              : Icons.favorite_outline,
                          color: Color.fromARGB(255, 13, 16, 74),
                        ),
                      ),
                      SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          _launchURL(
                              siwaHotels[i].url); // Launch URL when tapped
                        },
                        child: Icon(
                          Icons.link,
                          color: Colors.blue, // Use blue color for link icon
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    siwaHotels[i].description,
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
                      if (isLoading)
                        CircularProgressIndicator(), // Show loading icon
                      if (!isLoading && siwaHotels[i].price != 0)
                        Text(
                          siwaHotels[i].price.toString(),
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 5, 59, 107),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      if (!isLoading && siwaHotels[i].price != 0)
                        SizedBox(width: 8),
                      if (!isLoading && siwaHotels[i].price != 0)
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

void _launchURL(String url) async {
  final Uri uri = Uri.parse(url);
  if (!await launchUrl(uri)) {
    throw Exception('Could not launch $url');
  }
}
