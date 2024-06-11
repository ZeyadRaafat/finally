import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../place.dart';

List<Place> sinaiPlaces = [
  Place(
    "Sahaba Mosque",
    [
      'images/sinaplaces/mos1.jpg',
      'images/sinaplaces/mos2.jpg',
      'images/sinaplaces/mos3.jpg',
      'images/sinaplaces/mos4.jpg',
    ],
    "The Sahaba Mosque: A historic mosque in Sharm El Sheikh, Egypt, honoring the companions of the Prophet Muhammad.",
    0,
    "https://www.tripadvisor.com/Attraction_Review-g297555-d16850020-Reviews-Al_Sahaba_Mosque-Sharm_El_Sheikh_South_Sinai_Red_Sea_and_Sinai.html",
    "https://www.google.com/maps/place/Sahaba+Mosque/@27.8664178,34.2926635,17z/data=!3m1!4b1!4m6!3m5!1s0x14533a2fadcd5449:0x5d44adb200d4f8b2!8m2!3d27.8664178!4d34.2952438!16s%2Fg%2F11c1r16zgb?entry=ttu",
    false,
  ),

  Place(
    "Mount Catherine",
    [
      'images/sinaplaces/mount1.jpg',
      'images/sinaplaces/mount2.jpg',
      'images/sinaplaces/mount3.jpg',
      'images/sinaplaces/mount4.jpg',
    ],
    "Mount Catherine: Egypt's tallest peak, offering stunning views and challenging hikes in the Sinai Peninsula.",
    0,
    "https://www.britannica.com/place/Mount-Katrina",
    "https://www.google.com/maps/place/Mount+Catherine/@28.5097214,33.9449565,15z/data=!3m1!4b1!4m6!3m5!1s0x145485210abc0239:0x41281dd36680e7b4!8m2!3d28.5097222!4d33.9552777!16zL20vMGd6bWNm?entry=ttu",
    false,
  ),

  Place(
    'Soho Square Dancing',
    [
      'images/sinaplaces/soho1.jpg',
      'images/sinaplaces/soho2.jpg',
      'images/sinaplaces/soho3.jpg',
      'images/sinaplaces/soho4.jpg',
    ],
    "Soho Square Dancing Fountain: Sharm El Sheikh's captivating water show with music and lights.",
    0,
    "https://www.tripadvisor.com/Attraction_Review-g297555-d4010193-Reviews-Soho_Square_Dancing_Fountain-Sharm_El_Sheikh_South_Sinai_Red_Sea_and_Sinai.html",
    "https://maps.google.com/?cid=8170284750953649346&entry=gps",
    false,
  ),
  Place(
    'The Heavenly Cathedral',
    [
      'images/sinaplaces/hea1.jpg',
      'images/sinaplaces/hea2.jpg',
      'images/sinaplaces/hea3.jpg',
      'images/sinaplaces/hea4.jpg',
    ],
    "The Heavenly Cathedral: A serene sanctuary in Sharm El Sheikh, Egypt, inviting contemplation and prayer.",
    0,
    "https://www.tripadvisor.com/Attraction_Review-g297555-d2706237-Reviews-The_Heavenly_Cathedral-Sharm_El_Sheikh_South_Sinai_Red_Sea_and_Sinai.html",
    "https://maps.app.goo.gl/x2SFbWWhTvTzsHRV7",
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
  List<int> activeIndices = List.filled(sinaiPlaces.length, 0);
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

    final place = sinaiPlaces[index]; // Use alexHotels instead of cairoHotels
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
      sinaiPlaces[index].isFavorite = !sinaiPlaces[index]
          .isFavorite; // Use alexHotels instead of cairoHotels
    });
  }

  Future<void> getPlacesPrices() async {
    for (int i = 0; i < sinaiPlaces.length; i++) {
      DocumentSnapshot document = await FirebaseFirestore.instance
          .collection('Touristic places')
          .doc(sinaiPlaces[i].name)
          .get();
      if (document.exists) {
        int price = document.get('price');
        bool isFavorite = document.get('isFavourite');
        sinaiPlaces[i] = Place(
          sinaiPlaces[i].name,
          sinaiPlaces[i].imagePaths,
          sinaiPlaces[i].description,
          price,
          sinaiPlaces[i].url,
          sinaiPlaces[i].locationurl,
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
          for (int i = 0; i < sinaiPlaces.length; i++)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarouselSlider(
                  items: sinaiPlaces[i]
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
                    activeIndices[i], sinaiPlaces[i].imagePaths.length),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      SizedBox(width: 8),
                      Text(
                        sinaiPlaces[i].name,
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
                          _launchURL(sinaiPlaces[i]
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
                              content: Text(sinaiPlaces[i].isFavorite
                                  ? 'Removed from Favorites!'
                                  : 'Added to Favorites!'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                        child: Icon(
                          sinaiPlaces[i].isFavorite
                              ? Icons.favorite
                              : Icons.favorite_outline,
                          color: Color.fromARGB(255, 13, 16, 74),
                        ),
                      ),
                      SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          _launchURL(
                              sinaiPlaces[i].url); // Launch URL when tapped
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
                    sinaiPlaces[i].description,
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
                      if (!isLoading && sinaiPlaces[i].price != 1)
                        Text(
                          sinaiPlaces[i].price.toString(),
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 5, 59, 107),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      if (!isLoading && sinaiPlaces[i].price != 1)
                        SizedBox(width: 8),
                      if (!isLoading && sinaiPlaces[i].price != 1)
                        Text(
                          "EGP",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 5, 59, 107),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      if (isLoading && sinaiPlaces[i].price == 1)
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
