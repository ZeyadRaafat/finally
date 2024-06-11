import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../place.dart';

List<Place> hurghadaPlaces = [
  Place(
    "Dolphin world reservations",
    [
      'images/hurghadaplaces/dol1.jpg',
      'images/hurghadaplaces/dol2.jpg',
      'images/hurghadaplaces/dol3.jpg',
      'images/hurghadaplaces/dol4.jpg',
    ],
    "Dolphin World Reservations in Hurghada: where the Red Sea's magic meets the playful dance of dolphins.",
    0,
    "https://www.dolphinworldegypt.com/",
    "https://www.google.com/maps/place/Dolphin+World+reservations/@26.9906317,33.8520963,15z/data=!4m6!3m5!1s0x144d793b48194283:0xc688c6808a4f8456!8m2!3d26.9906317!4d33.8520963!16s%2Fg%2F11b6sr2j1r?entry=ttu",
    false,
  ),
  Place(
    "Hurghada Grand Aquarium",
    [
      'images/hurghadaplaces/grand1.jpg',
      'images/hurghadaplaces/grand2.jpg',
      'images/hurghadaplaces/grand3.jpg',
      'images/hurghadaplaces/grand4.jpg',
    ],
    "The Hurghada Grand Aquarium: an underwater wonderland showcasing marine life off the coast of Egypt.",
    0,
    "https://hurghadaaquarium.com/",
    "https://www.google.com/maps/place/Hurghada+Grand+Aquarium/@27.1343995,33.821875,15z/data=!4m6!3m5!1s0x1452805e870e89a9:0xd5266a593848cdaa!8m2!3d27.1343995!4d33.821875!16s%2Fg%2F11c30rvk0f?entry=ttu",
    false,
  ),
  Place(
    'Mahmya Island',
    [
      'images/hurghadaplaces/mah1.jpg',
      'images/hurghadaplaces/mah2.jpg',
      'images/hurghadaplaces/mah3.jpg',
      'images/hurghadaplaces/mah4.jpg',
    ],
    "Mahmya Island: A tranquil paradise with sandy beaches and clear waters for relaxation and snorkeling.",
    0,
    "https://www.mahmya.com/",
    "https://www.google.com/maps/place/Mahmya+Island/@27.1827177,33.9596303,15z/data=!4m6!3m5!1s0x145284d89826aff5:0x19ffcf335924977d!8m2!3d27.1827177!4d33.9596303!16s%2Fg%2F11c5_vgcj9?entry=ttu",
    false,
  ),
  Place(
    'Makadi water world',
    [
      'images/hurghadaplaces/mak1.jpg',
      'images/hurghadaplaces/mak2.jpg',
      'images/hurghadaplaces/mak3.jpg',
      'images/hurghadaplaces/mak4.jpg',
    ],
    "Makadi Water World: A thrilling water park in Egypt, offering slides, pools, and fun for all ages.",
    0,
    "https://makadiwaterworld.com/",
    "https://www.google.com/maps/place/Makadi+Water+World/@26.9824208,33.8728663,15z/data=!4m6!3m5!1s0x144d794316a8f2c9:0x3c18e7ce348ab175!8m2!3d26.9824208!4d33.8728663!16s%2Fg%2F1pp2vj4k7?entry=ttu",
    false,
  ),
  Place(
    'paradise island hurghada',
    [
      'images/hurghadaplaces/par1.jpg',
      'images/hurghadaplaces/par2.jpg',
      'images/hurghadaplaces/par3.jpg',
      'images/hurghadaplaces/par4.jpg',
    ],
    "Paradise Island Hurghada: A scenic island escape in Egypt, boasting beautiful beaches and crystal-clear waters.",
    0,
    "https://www.tripadvisor.com/Attraction_Review-g297549-d13576819-Reviews-Paradise_Island-Hurghada_Red_Sea_and_Sinai.html",
    "https://www.google.com/maps/place/Paradise+Island+Hurghada/@27.1814387,33.9539221,15z/data=!4m6!3m5!1s0x145287e5ac6eb9f1:0xf97bf80e53d281da!8m2!3d27.1814387!4d33.9539221!16s%2Fg%2F11ckrj4dm_?entry=ttu",
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
  List<int> activeIndices = List.filled(hurghadaPlaces.length, 0);
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
        hurghadaPlaces[index]; // Use alexHotels instead of cairoHotels
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
      hurghadaPlaces[index].isFavorite = !hurghadaPlaces[index]
          .isFavorite; // Use alexHotels instead of cairoHotels
    });
  }

  Future<void> getPlacesPrices() async {
    for (int i = 0; i < hurghadaPlaces.length; i++) {
      DocumentSnapshot document = await FirebaseFirestore.instance
          .collection('Touristic places')
          .doc(hurghadaPlaces[i].name)
          .get();
      if (document.exists) {
        int price = document.get('price');
        bool isFavorite = document.get('isFavourite');
        hurghadaPlaces[i] = Place(
          hurghadaPlaces[i].name,
          hurghadaPlaces[i].imagePaths,
          hurghadaPlaces[i].description,
          price,
          hurghadaPlaces[i].url,
          hurghadaPlaces[i].locationurl,
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
          for (int i = 0; i < hurghadaPlaces.length; i++)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarouselSlider(
                  items: hurghadaPlaces[i]
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
                    activeIndices[i], hurghadaPlaces[i].imagePaths.length),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      SizedBox(width: 8),
                      Text(
                        hurghadaPlaces[i].name,
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
                          _launchURL(hurghadaPlaces[i]
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
                              content: Text(hurghadaPlaces[i].isFavorite
                                  ? 'Removed from Favorites!'
                                  : 'Added to Favorites!'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                        child: Icon(
                          hurghadaPlaces[i].isFavorite
                              ? Icons.favorite
                              : Icons.favorite_outline,
                          color: Color.fromARGB(255, 13, 16, 74),
                        ),
                      ),
                      SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          _launchURL(
                              hurghadaPlaces[i].url); // Launch URL when tapped
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
                    hurghadaPlaces[i].description,
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
                      if (!isLoading && hurghadaPlaces[i].price != 1)
                        Text(
                          hurghadaPlaces[i].price.toString(),
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 5, 59, 107),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      if (!isLoading && hurghadaPlaces[i].price != 1)
                        SizedBox(width: 8),
                      if (!isLoading && hurghadaPlaces[i].price != 1)
                        Text(
                          "EGP",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 5, 59, 107),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      if (isLoading && hurghadaPlaces[i].price == 1)
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
