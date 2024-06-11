import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../place.dart';

List<Place> luxorAswanPlaces = [
  Place(
    "Colossi Of Memnon",
    [
      'images/luxorandaswanplaces/mon1.jpg',
      'images/luxorandaswanplaces/mon2.jpg',
      'images/luxorandaswanplaces/mon3.jpg',
      'images/luxorandaswanplaces/mon4.jpg',
    ],
    "The Colossi of Memnon: Majestic ancient statues in Luxor, Egypt, standing as guardians of the Theban necropolis.",
    0,
    "https://www.tripadvisor.com/Attraction_Review-g294205-d472001-Reviews-Colossi_of_Memnon-Luxor_Nile_River_Valley.html",
    "https://www.google.com/maps/place/Colossi+of+Memnon/@25.720581,32.6105303,15z/data=!4m6!3m5!1s0x1449166b7c9f0809:0x75789827d3bea3b!8m2!3d25.720581!4d32.6105303!16zL20vMDJmeHBs?entry=ttu",
    false,
  ),
  Place(
    "Karnak",
    [
      'images/luxorandaswanplaces/kar1.jpg',
      'images/luxorandaswanplaces/kar2.jpg',
      'images/luxorandaswanplaces/kar3.jpg',
      'images/luxorandaswanplaces/kar4.jpg',
    ],
    "Karnak: A vast ancient temple complex in Luxor, Egypt, renowned for its impressive columns and rich history.",
    0,
    "https://www.britannica.com/place/Karnak",
    "https://www.google.com/maps/place/Karnak/@25.7188346,32.6572703,15z/data=!4m6!3m5!1s0x1449159228fec0cd:0xc71ae8c008c259d8!8m2!3d25.7188346!4d32.6572703!16zL20vMDE0d3k0?entry=ttu",
    false,
  ),
  Place(
    'Luxor Temple',
    [
      'images/luxorandaswanplaces/lux1.jpg',
      'images/luxorandaswanplaces/lux2.jpg',
      'images/luxorandaswanplaces/lux3.jpg',
      'images/luxorandaswanplaces/lux4.jpg',
    ],
    "Luxor Temple: A magnificent ancient temple in Luxor, Egypt, known for its grandeur and historical significance.",
    0,
    "https://egymonuments.gov.eg/en/monuments/luxor-temple",
    "https://www.google.com/maps/place/Luxor+Temple/@25.699502,32.6390509,15z/data=!4m6!3m5!1s0x144915c41edadf61:0x7693895c346c7d81!8m2!3d25.699502!4d32.6390509!16zL20vMDNwcDd2?entry=ttu",
    false,
  ),
  Place(
    'Mummification Museum',
    [
      'images/luxorandaswanplaces/mom1.jpg',
      'images/luxorandaswanplaces/mom2.jpg',
      'images/luxorandaswanplaces/mom3.jpg',
      'images/luxorandaswanplaces/mom4.jpg',
    ],
    "The Mummification Museum in Luxor: a captivating showcase of ancient embalming practices.",
    0,
    "https://egymonuments.gov.eg/museums/mummification-museum/",
    "https://www.google.com/maps/place/Mummification+Museum/@25.7023166,32.6398497,15z/data=!4m6!3m5!1s0x144915c82f8983a9:0x6189ac424f113e64!8m2!3d25.7023166!4d32.6398497!16zL20vMDNwdGgx?entry=ttu",
    false,
  ),
  Place(
    'Valley of the king',
    [
      'images/luxorandaswanplaces/val1.jpg',
      'images/luxorandaswanplaces/val2.jpg',
      'images/luxorandaswanplaces/val3.jpg',
      'images/luxorandaswanplaces/val4.jpg',
    ],
    "The Valley of the Kings: an ancient burial site in Luxor, Egypt, home to pharaohs' tombs.",
    0,
    "https://egymonuments.gov.eg/archaeological-sites/valley-of-the-kings/",
    "https://www.google.com/maps/place/Valley+of+the+Kings/@25.7401643,32.601411,15z/data=!4m6!3m5!1s0x14493d8ab5defed7:0x718fccf6a2e3a9da!8m2!3d25.7401643!4d32.601411!16zL20vMDhtOHc2?entry=ttu",
    false,
  ),

  Place(
    "Kom Ombo temple",
    [
      'images/luxorandaswanplaces/kom1.jpg',
      'images/luxorandaswanplaces/kom2.jpg',
      'images/luxorandaswanplaces/kom3.jpg',
      'images/luxorandaswanplaces/kom4.jpg',
    ],
    "Kom Ombo Temple: An ancient Egyptian temple dedicated to Sobek and Horus.",
    0,
    "https://egymonuments.gov.eg/monuments/kom-ombo-temple/",
    "https://maps.app.goo.gl/q9LbCTadut58wcDh8",
    false,
  ),
  Place(
    "Nile Museum",
    [
      'images/luxorandaswanplaces/nil1.jpg',
      'images/luxorandaswanplaces/nil2.jpg',
      'images/luxorandaswanplaces/nil3.jpg',
      'images/luxorandaswanplaces/nil4.jpg',
    ],
    "The Nile Museum: A cultural institution celebrating the history and significance of the Nile River in Egypt.",
    0,
    "https://www.tripadvisor.com/Attraction_Review-g294204-d10097874-Reviews-Nile_Museum-Aswan_Aswan_Governorate_Nile_River_Valley.html",
    "https://maps.app.goo.gl/CG6UDpQhkp2SjSBNA",
    false,
  ),
  Place(
    'Nubian Museum',
    [
      'images/luxorandaswanplaces/nub1.jpg',
      'images/luxorandaswanplaces/nub2.jpg',
      'images/luxorandaswanplaces/nub3.jpg',
      'images/luxorandaswanplaces/nub4.jpg',
    ],
    "The Nubian Museum: A cultural treasure in Aswan, Egypt, preserving the heritage and traditions of the Nubian people.",
    0,
    "https://egymonuments.gov.eg/en/museums/nubia-museum",
    "https://maps.app.goo.gl/3wqvBsDn1xwuJwFo6",
    false,
  ),
  Place(
    'Nubian Village Aswan',
    [
      'images/luxorandaswanplaces/vi1.jpg',
      'images/luxorandaswanplaces/vi2.jpg',
      'images/luxorandaswanplaces/vi3.jpg',
      'images/luxorandaswanplaces/vi4.jpg',
    ],
    "The Nubian Village in Aswan: A vibrant community along the Nile, showcasing traditional Nubian culture and hospitality.",
    0,
    "	https://www.tripadvisor.com/Attraction_Review-g294204-d553252-Reviews-Nubian_Village-Aswan_Aswan_Governorate_Nile_River_Valley.html",
    "https://maps.app.goo.gl/xN2S3Rkf9H4ovMd37",
    false,
  ),
  Place(
    'Unfinished Obliesk',
    [
      'images/luxorandaswanplaces/unf1.jpg',
      'images/luxorandaswanplaces/unf2.jpg',
      'images/luxorandaswanplaces/unf3.jpg',
      'images/luxorandaswanplaces/unf4.jpg',
    ],
    "The Unfinished Obelisk: A colossal ancient structure in Aswan, Egypt, revealing ancient construction techniques.",
    0,
    "https://egymonuments.gov.eg/monuments/the-unfinished-obelisk/",
    "https://maps.app.goo.gl/Qk8YHMNzNf4Z8TAE7",
    false,
  ),
  // Add more hotels here
];

class ScreenThree extends StatefulWidget {
  ScreenThree({Key? key});

  @override
  State<ScreenThree> createState() => _ScreenThreeState();
}

class _ScreenThreeState extends State<ScreenThree> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _userId;
  String? _firestoreUserId;
  List<int> activeIndices = List.filled(luxorAswanPlaces.length, 0);
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getPlacesPrices();
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

    final place =
        luxorAswanPlaces[index]; // Use alexHotels instead of cairoHotels
    final placeRef = FirebaseFirestore.instance
        .collection('Touristic places')
        .doc(place.name);
    final userFavoritesRef = FirebaseFirestore.instance
        .collection('Usere')
        .doc(_firestoreUserId!)
        .collection('favorites');

    // Update the isFavorite field in the hotel document
    await placeRef.update({'isFavourite': !place.isFavorite});

    // Add or remove the hotel from the user's favorites sub-collection
    if (!place.isFavorite) {
      // Add to favorites
      await userFavoritesRef.doc(place.name).set({
        'name': place.name,
        // Add any other relevant data you want to store
      });
    } else {
      // Remove from favorites
      await userFavoritesRef.doc(place.name).delete();
    }

    // Update the local state to reflect the change
    setState(() {
      luxorAswanPlaces[index].isFavorite = !luxorAswanPlaces[index]
          .isFavorite; // Use alexHotels instead of cairoHotels
    });
  }

  Future<void> getPlacesPrices() async {
    for (int i = 0; i < luxorAswanPlaces.length; i++) {
      DocumentSnapshot document = await FirebaseFirestore.instance
          .collection('Touristic places')
          .doc(luxorAswanPlaces[i].name)
          .get();
      if (document.exists) {
        int price = document.get('price');
        bool isFavorite = document.get('isFavourite');
        luxorAswanPlaces[i] = Place(
          luxorAswanPlaces[i].name,
          luxorAswanPlaces[i].imagePaths,
          luxorAswanPlaces[i].description,
          price,
          luxorAswanPlaces[i].url,
          luxorAswanPlaces[i].locationurl,
          isFavorite,
        );
        if (price == 1) {
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
          'Luxor And Aswan',
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
              MaterialPageRoute(builder: (context) => ThirdRoute()),
            );
          },
        ),
      ),
      body: ListView(
        children: [
          Center(
            child: Text(
              'Touristic',
              style: TextStyle(
                fontFamily: 'MadimiOne',
                color: Color.fromARGB(255, 121, 155, 230),
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 20),
          for (int i = 0; i < luxorAswanPlaces.length; i++)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarouselSlider(
                  items: luxorAswanPlaces[i]
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
                    activeIndices[i], luxorAswanPlaces[i].imagePaths.length),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      SizedBox(width: 8),
                      Text(
                        luxorAswanPlaces[i].name,
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
                          _launchURL(luxorAswanPlaces[i]
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
                              content: Text(luxorAswanPlaces[i].isFavorite
                                  ? 'Removed from Favorites!'
                                  : 'Added to Favorites!'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                        child: Icon(
                          luxorAswanPlaces[i].isFavorite
                              ? Icons.favorite
                              : Icons.favorite_outline,
                          color: Color.fromARGB(255, 13, 16, 74),
                        ),
                      ),
                      SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          _launchURL(luxorAswanPlaces[i]
                              .url); // Launch URL when tapped
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
                    luxorAswanPlaces[i].description,
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
                      if (!isLoading && luxorAswanPlaces[i].price != 1)
                        Text(
                          luxorAswanPlaces[i].price.toString(),
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 5, 59, 107),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      if (!isLoading && luxorAswanPlaces[i].price != 1)
                        SizedBox(width: 8),
                      if (!isLoading && luxorAswanPlaces[i].price != 1)
                        Text(
                          "EGP",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 5, 59, 107),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      if (isLoading && luxorAswanPlaces[i].price == 1)
                        IconButton(
                          icon: Icon(Icons.cloud_download),
                          onPressed:
                              () {}, // Add the function to handle downloading here
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
