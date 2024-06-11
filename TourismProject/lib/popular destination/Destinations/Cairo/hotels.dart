import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import '../hotel.dart';

List<Hotel> cairoHotels = [
  Hotel(
      name: "Ramses Hilton",
      imagePaths: [
        'images/ramsesimages/ramses hilton.jpg',
        'images/ramsesimages/rest.jpg',
        'images/ramsesimages/room.jpg',
        'images/ramsesimages/swimming-pool-day.avif',
      ],
      description:
          "Luxurious accommodation with stunning views and relaxing amenities.",
      price: 0,
      url: "https://www.hilton.com/en/hotels/cairhtw-ramses-hilton/",
      locationurl: "https://maps.app.goo.gl/Pw5onWsf9nSV7ijf6",
      isFavorite: false),
  Hotel(
      name: "Tolip Golden plaza",
      imagePaths: [
        'images/tolipimages/tolip.jpg',
        'images/tolipimages/toliprest.jpg',
        'images/tolipimages/toliproom.jpg',
        'images/tolipimages/swimmpool.jpg',
      ],
      description:
          "Experience comfort and convenience in the heart of the city.",
      price: 0,
      url: "http://tolipgoldenplaza.com/",
      locationurl: "https://maps.app.goo.gl/BbXsxVoQQHfZV8VV7",
      isFavorite: false),
  Hotel(
      name: 'Fairmont Nile City',
      imagePaths: [
        'images/fairmonthotel/fairmont.jpg',
        'images/fairmonthotel/fairmontrestt.jpg',
        'images/fairmonthotel/fairmontroom.jpg',
        'images/fairmonthotel/fairmontpool.jpg',
      ],
      description: "Where luxury meets elegance, offering top-notch services.",
      price: 0,
      url: "https://www.fairmont.com/nile-city-cairo/",
      locationurl: "https://maps.app.goo.gl/1Qg793SniEJRG48YA",
      isFavorite: false),
  Hotel(
      name: 'Kempinski Nile Hotel',
      imagePaths: [
        'images/kempinskihotel/kempinski.jpg',
        'images/kempinskihotel/kemppool.jpg',
        'images/kempinskihotel/kemprest.jpg',
        'images/kempinskihotel/kemproom.jpg',
      ],
      description:
          "Unparalleled luxury and impeccable service for a memorable stay.",
      price: 0,
      url: "https://www.kempinski.com/en/cairo/kempinski-nile-hotel",
      locationurl: "https://maps.app.goo.gl/MPtmnLz5kmZ8wsxG8",
      isFavorite: false),
  Hotel(
      name: 'Steigenberger Nile Palace',
      imagePaths: [
        'images/steighenberghotel/steigenberger.jpg',
        'images/steighenberghotel/steighenloopy.jpg',
        'images/steighenberghotel/steighenroom.jpg',
        'images/steighenberghotel/steinpool.jpg',
      ],
      description:
          "Discover sophistication and charm in every detail of your stay.",
      price: 0,
      url:
          "https://steigenberger.com/en/hotels/all-hotels/egypt/cairo/steigenberger-pyramids-cairo",
      locationurl: "https://maps.app.goo.gl/tauef8Jf9kehtXKi9",
      isFavorite: false),
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
  List<int> activeIndices = List.filled(cairoHotels.length, 0);
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

    final hotel = cairoHotels[index]; // Use alexHotels instead of cairoHotels
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
      cairoHotels[index].isFavorite = !cairoHotels[index]
          .isFavorite; // Use alexHotels instead of cairoHotels
    });
  }

  Future<void> getHotelPrices() async {
    for (int i = 0; i < cairoHotels.length; i++) {
      DocumentSnapshot document = await FirebaseFirestore.instance
          .collection('Hotels')
          .doc(cairoHotels[i].name)
          .get();
      if (document.exists) {
        int price = document.get('price');
        bool isFavorite = document.get('isFavourite');
        cairoHotels[i] = Hotel(
          name: cairoHotels[i].name,
          imagePaths: cairoHotels[i].imagePaths,
          description: cairoHotels[i].description,
          price: price,
          url: cairoHotels[i].url,
          locationurl: cairoHotels[i].locationurl,
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
          'Cairo',
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
              MaterialPageRoute(builder: (context) => FirstRoute()),
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
          for (int i = 0; i < cairoHotels.length; i++)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarouselSlider(
                  items: cairoHotels[i]
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
                    activeIndices[i], cairoHotels[i].imagePaths.length),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      SizedBox(width: 8),
                      Text(
                        cairoHotels[i].name,
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
                          _launchURL(cairoHotels[i]
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
                              content: Text(cairoHotels[i].isFavorite
                                  ? 'Removed from Favorites!'
                                  : 'Added to Favorites!'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                        child: Icon(
                          cairoHotels[i].isFavorite
                              ? Icons.favorite
                              : Icons.favorite_outline,
                          color: Color.fromARGB(255, 13, 16, 74),
                        ),
                      ),
                      SizedBox(width: 8),
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
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    cairoHotels[i].description,
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
                      if (!isLoading && cairoHotels[i].price != 0)
                        Text(
                          cairoHotels[i].price.toString(),
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 5, 59, 107),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      if (!isLoading && cairoHotels[i].price != 0)
                        SizedBox(width: 8),
                      if (!isLoading && cairoHotels[i].price != 0)
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
