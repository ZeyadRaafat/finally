import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import '../hotel.dart';

List<Hotel> hurghadaHotels = [
  Hotel(
      name:"Baron Palace Sahl Hasheesh",
      imagePaths:[
        'images/hurghadahotels/hur1.jpg',
        'images/hurghadahotels/hur2.jpg',
        'images/hurghadahotels/hur3.jpg',
        'images/hurghadahotels/hur4.jpg',
      ],
      description:"Nestled amidst the sun-kissed shores of Hurghada, the Baron Palace Hotel exudes an enchanting charm, where every moment is a symphony of luxury, pampering guests with opulent indulgence against the backdrop of the Red Sea's azure embrace.",
      price: 0,
       url:"https://baronhotels.com/baron-palace-sahl-hasheesh/",
      isFavorite:false),
  Hotel(
      name:"Giftun Beach Resort",
      imagePaths:[
        'images/hurghadahotels/gif1.jpg',
        'images/hurghadahotels/gif2.jpg',
        'images/hurghadahotels/gif3.jpg',
        'images/hurghadahotels/gif4.jpg',
      ],
      description:"Giftun Beach: Where sun, sand, and sea unite in a tranquil paradise, offering a perfect escape for those seeking serenity by the Red Sea.",
       price:0,
       url: "https://www.giftunazurresort.com/ar/",
      isFavorite:  false),
  Hotel(
      name: 'Panorama Bungalows',
      imagePaths: [
        'images/hurghadahotels/pano1.jpg',
        'images/hurghadahotels/pano2.jpg',
        'images/hurghadahotels/pano3.jpg',
        'images/hurghadahotels/pano4.jpg',
      ],
      description:"Panorama Hotel: Where every stay offers unforgettable views and comfort in every corner.",
     price: 0,
    url:  "http://www.panorama-resorts.com/en/41/panorama-bungalows-el-gouna",
     isFavorite:  false),
  Hotel(
       name:'Rixos Premium Magawish',
     imagePaths: [
        'images/hurghadahotels/rixos1.jpg',
        'images/hurghadahotels/rixos2.jpg',
        'images/hurghadahotels/rixos3.jpg',
        'images/hurghadahotels/rixos4.jpg',
      ],
       description:"Rixos: Luxury and lifestyle harmonize, delivering an exceptional experience in opulence and service.",
     price:  0,
      url: "https://www.rixos.com/en/hotel-resort/rixos-premium-magawish-suites-villas",
      isFavorite:false),
  Hotel(
      name:'Serry Beach Resort',
     imagePaths: [
        'images/hurghadahotels/serry1.jpg',
        'images/hurghadahotels/serry2.jpg',
        'images/hurghadahotels/serry3.jpg',
        'images/hurghadahotels/serry4.jpg',
      ],
      description:"Serry Beach Hotel: Where serenity meets the sea for an unforgettable escape.",
         price: 0,
       url: "https://www.theserry.com/en",
      isFavorite:false),
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
  List<int> activeIndices = List.filled(hurghadaHotels.length, 0);
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

    final hotel =
        hurghadaHotels[index]; // Use alexHotels instead of cairoHotels
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
      hurghadaHotels[index].isFavorite = !hurghadaHotels[index]
          .isFavorite; // Use alexHotels instead of cairoHotels
    });
  }

  Future<void> getHotelPrices() async {
    for (int i = 0; i < hurghadaHotels.length; i++) {
      DocumentSnapshot document = await FirebaseFirestore.instance
          .collection('Hotels')
          .doc(hurghadaHotels[i].name)
          .get();
      if (document.exists) {
        int price = document.get('price');
        bool isFavorite =
            document.get('isFavourite'); // Get isFavorite value from Firestore
        hurghadaHotels[i] = Hotel(
          name: hurghadaHotels[i].name,
          imagePaths: hurghadaHotels[i].imagePaths,
          description: hurghadaHotels[i].description,
          price: price,
          url: hurghadaHotels[i].url,
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
          'Hurghada',
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
              MaterialPageRoute(builder: (context) => FifthRoute()),
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
          for (int i = 0; i < hurghadaHotels.length; i++)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarouselSlider(
                  items: hurghadaHotels[i]
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
                    activeIndices[i], hurghadaHotels[i].imagePaths.length),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      SizedBox(width: 8),
                      Text(
                        hurghadaHotels[i].name,
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
                          toggleFavoriteStatus(i);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(hurghadaHotels[i].isFavorite
                                  ? 'Removed from Favorites!'
                                  : 'Added to Favorites!'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                        child: Icon(
                          hurghadaHotels[i].isFavorite
                              ? Icons.favorite
                              : Icons.favorite_outline,
                          color: Color.fromARGB(255, 13, 16, 74),
                        ),
                      ),
                      SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          _launchURL(
                              hurghadaHotels[i].url); // Launch URL when tapped
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
                    hurghadaHotels[i].description,
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
                      if (!isLoading && hurghadaHotels[i].price != 0)
                        Text(
                          hurghadaHotels[i].price.toString(),
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 5, 59, 107),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      if (!isLoading && hurghadaHotels[i].price != 0)
                        SizedBox(width: 8),
                      if (!isLoading && hurghadaHotels[i].price != 0)
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
