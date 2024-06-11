import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import '../hotel.dart';

List<Hotel> sinaiHotels = [
  Hotel(
      name: "Amar Sina Boutique Village",
      imagePaths: [
        'images/sinahotels/ama1.jpg',
        'images/sinahotels/ama2.jpg',
        'images/sinahotels/ama3.jpg',
        'images/sinahotels/ama4.jpg',
      ],
      description:
          "Amar Sina Boutique Village: A charming oasis in the heart of the Red Sea.",
      price: 0,
      url: "https://amarsinavillage.com-sharmelsheikh.com/ar/",
      locationurl:
          "https://www.google.com/maps/place/Amar+Sina+Boutique+Village+%D9%82%D8%B1%D9%8A%D8%A9+%D9%82%D9%85%D8%B1+%D8%B3%D9%8A%D9%86%D8%A7%E2%80%AD/@27.8700597,34.3071756,17z/data=!3m1!4b1!4m9!3m8!1s0x14533a1f89077e95:0xeff56338b1d05e54!5m2!4m1!1i2!8m2!3d27.870055!4d34.3097505!16s%2Fg%2F1tgkdkq3?entry=ttu",
      isFavorite: false),
  Hotel(
      name: "Sunrise Arabian Beach",
      imagePaths: [
        'images/sinahotels/sun1.jpg',
        'images/sinahotels/sun2.jpg',
        'images/sinahotels/sun3.jpg',
        'images/sinahotels/sun4.jpg',
      ],
      description:
          "Sunrise Arabian Beach Resort: Luxury meets the shore for an unforgettable coastal escape.",
      price: 0,
      url: "https://www.sunrise-resorts.com/arabian-beach-resort",
      locationurl: "https://maps.app.goo.gl/xBxnvHTQ1FAVCEpu7",
      isFavorite: false),
  Hotel(
      name: 'sinai grand resort',
      imagePaths: [
        'images/sinahotels/sina1.jpg',
        'images/sinahotels/sina2.jpg',
        'mages/sinahotels/sina3.jpg',
        'images/sinahotels/sina4.jpg',
      ],
      description:
          "Sinai Grand Resort: Luxurious tranquility awaits at our serene escape.",
      price: 0,
      url:
          "https://www.tripadvisor.com/Hotel_Review-g297555-d583853-Reviews-or15-Sinai_Grand_Resort-Sharm_El_Sheikh_South_Sinai_Red_Sea_and_Sinai.html",
      locationurl: "https://maps.app.goo.gl/vAYWE1YPMa1MnEWbA",
      isFavorite: false),
  Hotel(
      name: 'sinaway Lagoon Hotel & Spa',
      imagePaths: [
        'images/sinahotels/sinaa1.jpg',
        'images/sinahotels/sinaa2.jpg',
        'images/sinahotels/sinaa3.jpg',
        'images/sinahotels/sinaa4.jpg',
      ],
      description: "Sinaway Lagoon: Your serene Red Sea getaway awaits.",
      price: 0,
      url: "https://sinaway-lagoon-hotel-and-spa-ras-sedr.albooked.com/",
      locationurl: "https://maps.app.goo.gl/Ucc63UPhfopfi7kd7",
      isFavorite: false),
  Hotel(
      name: 'Charmillion Club Resort',
      imagePaths: [
        'images/sinahotels/cha1.jpg',
        'images/sinahotels/cha2.jpg',
        'images/sinahotels/cha3.jpg',
        'images/sinahotels/cha4.jpg',
      ],
      description: "Charmillion Club Resort: Your Red Sea retreat awaits.",
      price: 0,
      url:
          "https://charmillionresorts.com/ar/%D8%A7%D9%84%D8%B1%D8%A6%D9%8A%D8%B3%D9%8A%D8%A9/%D9%85%D9%86%D8%AA%D8%AC%D8%B9-%D8%B4%D8%A7%D8%B1%D9%85%D9%8A%D9%84%D9%8A%D9%88%D9%86-%D9%83%D9%84%D9%88%D8%A8/",
      locationurl:
          "https://www.google.com/maps/place/Charmillion+Club+Resort/@28.0048695,34.4234868,16z/data=!4m13!1m2!2m1!1z4oCqQ2hhcm1pbGxpb24gQ2x1YiBSZXNvcnTigKw!3m9!1s0x14534bf833105c87:0xbace759a704dd0e4!5m2!4m1!1i2!8m2!3d27.9996304!4d34.4318219!15sCh3igKpDaGFybWlsbGlvbiBDbHViIFJlc29ydOKArFoZIhdjaGFybWlsbGlvbiBjbHViIHJlc29ydJIBBWhvdGVs4AEA!16s%2Fg%2F1tf62s6f?entry=ttu",
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
  List<int> activeIndices = List.filled(sinaiHotels.length, 0);
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

    final hotel = sinaiHotels[index]; // Use alexHotels instead of cairoHotels
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
      sinaiHotels[index].isFavorite = !sinaiHotels[index]
          .isFavorite; // Use alexHotels instead of cairoHotels
    });
  }

  Future<void> getHotelPrices() async {
    for (int i = 0; i < sinaiHotels.length; i++) {
      DocumentSnapshot document = await FirebaseFirestore.instance
          .collection('Hotels')
          .doc(sinaiHotels[i].name)
          .get();
      if (document.exists) {
        int price = document.get('price');
        bool isFavorite = document.get('isFavourite');
        sinaiHotels[i] = Hotel(
          name: sinaiHotels[i].name,
          imagePaths: sinaiHotels[i].imagePaths,
          description: sinaiHotels[i].description,
          price: price,
          url: sinaiHotels[i].url,
          locationurl: sinaiHotels[i].locationurl,
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
          'Sinai',
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
              MaterialPageRoute(builder: (context) => SixthRoute()),
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
          for (int i = 0; i < sinaiHotels.length; i++)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarouselSlider(
                  items: sinaiHotels[i]
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
                    activeIndices[i], sinaiHotels[i].imagePaths.length),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      SizedBox(width: 8),
                      Text(
                        sinaiHotels[i].name,
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
                          _launchURL(sinaiHotels[i]
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
                              content: Text(sinaiHotels[i].isFavorite
                                  ? 'Removed from Favorites!'
                                  : 'Added to Favorites!'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                        child: Icon(
                          sinaiHotels[i].isFavorite
                              ? Icons.favorite
                              : Icons.favorite_outline,
                          color: Color.fromARGB(255, 13, 16, 74),
                        ),
                      ),
                      SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          _launchURL(
                              sinaiHotels[i].url); // Launch URL when tapped
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
                    sinaiHotels[i].description,
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
                      if (!isLoading && sinaiHotels[i].price != 0)
                        Text(
                          sinaiHotels[i].price.toString(),
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 5, 59, 107),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      if (!isLoading && sinaiHotels[i].price != 0)
                        SizedBox(width: 8),
                      if (!isLoading && sinaiHotels[i].price != 0)
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

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }
}
