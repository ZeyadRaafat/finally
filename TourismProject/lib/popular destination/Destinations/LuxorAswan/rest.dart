import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import '../restaurant.dart';

List<Rest> luxorAswanRests = [
  Rest(
      "Sofra",
      [
        'images/luxorandaswanres/sofra1.jpg',
        'images/luxorandaswanres/sofra2.jpg',
        'images/luxorandaswanres/sofra3.jpg',
        'images/luxorandaswanres/sofra4.jpg',
      ],
      "Sofra Restaurant: A popular dining destination in Egypt, renowned for its authentic and mouthwatering Egyptian cuisine served in a cozy and welcoming atmosphere.",
      "https://www.sofra.com.eg/",
      "https://www.google.com/maps/place/Sofra/@25.6948529,32.6398246,17z/data=!3m1!4b1!4m6!3m5!1s0x144915cce7c96959:0xab55aa77b2c4e009!8m2!3d25.6948529!4d32.6424049!16s%2Fg%2F1typqy3l?entry=ttu",
      false,
      "Pdfs/menus/sofra luxor.pdf"),
  Rest(
      "The Lantern Room",
      [
        'images/luxorandaswanres/la1.jpg',
        'images/luxorandaswanres/la2.jpg',
        'images/luxorandaswanres/la3.jpg',
        'images/luxorandaswanres/la4.jpg',
      ],
      "The Lantern Room Restaurant: A cozy dining spot in Egypt, offering delicious food and a warm ambiance, perfect for a memorable meal with loved ones.",
      "https://www.tripadvisor.com/Restaurant_Review-g294205-d754056-Reviews-The_Lantern_Room_Restaurant-Luxor_Nile_River_Valley.html/",
      "https://www.google.com/maps/place/The+Lantern+Room+Restaurant/@25.6874577,32.6301785,17z/data=!3m1!4b1!4m6!3m5!1s0x1449142f18336c13:0x9861c12f36be041f!8m2!3d25.6874577!4d32.6327588!16s%2Fg%2F1tdj6d11?entry=ttu",
      false,
      "Pdfs/menus/lantern luxor.pdf"),
  Rest(
      'Tout Ankh Amoun Restaurant',
      [
        'images/luxorandaswanres/tot1.jpg',
        'images/luxorandaswanres/tot2.jpg',
        'images/luxorandaswanres/tot3.jpg',
        'images/luxorandaswanres/tot4.jpg',
      ],
      "Tout Ankh Amoun Restaurant: A charming eatery in Egypt, named after the legendary Pharaoh, offering delectable cuisine and a unique dining experience inspired by ancient Egyptian culture.",
      "https://www.tripadvisor.co.uk/Restaurant_Review-g19118142-d23309219-Reviews-Tut_Ankh_Amun-Al_Badrashin_Giza_Governorate.html/",
      "https://www.google.com/maps/place/%D9%85%D8%B7%D8%B9%D9%85+%D8%AA%D9%88%D8%AA+%D8%B9%D9%86%D8%AE+%D8%A7%D9%85%D9%88%D9%86+Tout+Ankh+Amoun+Restaurant%E2%80%AD/@25.702674,32.6310864,17z/data=!3m1!4b1!4m6!3m5!1s0x144915d133ed5fbd:0x288f49fed5aa0fa!8m2!3d25.702674!4d32.6336667!16s%2Fg%2F11g01vg9ql?entry=ttu",
      false,
      ""),
  Rest(
      'Almasry Restaurant',
      [
        'images/luxorandaswanres/al2.jpg',
        'images/luxorandaswanres/al3.jpg',
        'images/luxorandaswanres/al4.jpg',
        'images/luxorandaswanres/al1.jpg',
      ],
      "Almasry Restaurant: A beloved eatery in Egypt, serving authentic Egyptian cuisine with a friendly vibe.",
      "https://www.tripadvisor.com/Restaurant_Review-g294204-d1488292-Reviews-Al_Masry-Aswan_Aswan_Governorate_Nile_River_Valley.html/",
      "https://maps.app.goo.gl/d7YFbE731v4BvQY26",
      false,
      ""),
  Rest(
      'ElDokka Restaurant',
      [
        'images/luxorandaswanres/dok2.jpg',
        'images/luxorandaswanres/dok3.jpg',
        'images/luxorandaswanres/dok4.jpg',
        'images/luxorandaswanres/dok1.jpg',
      ],
      "ElDokka Restaurant: A charming spot in Egypt for a cozy meal with tasty dishes.",
      "https://www.tripadvisor.com/Restaurant_Review-g294204-d1309045-Reviews-El_Dokka-Aswan_Aswan_Governorate_Nile_River_Valley.html/",
      "https://maps.app.goo.gl/iK9NqmvPG5iXr2TCA",
      false,
      ""),
  // Add more hotels here
];

class ScreenTwo extends StatefulWidget {
  ScreenTwo({Key? key});

  @override
  State<ScreenTwo> createState() => _ScreenTwoState();
}

class _ScreenTwoState extends State<ScreenTwo> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _userId;
  String? _firestoreUserId;
  List<int> activeIndices = List.filled(luxorAswanRests.length, 0);
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchBool();
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

    final restaurant =
        luxorAswanRests[index]; // Use alexHotels instead of cairoHotels
    final restRef = FirebaseFirestore.instance
        .collection('restaurant')
        .doc(restaurant.name);
    final userFavoritesRef = FirebaseFirestore.instance
        .collection('Usere')
        .doc(_firestoreUserId!)
        .collection('favorites');

    // Update the isFavorite field in the hotel document
    await restRef.update({'isFavourite': !restaurant.isFavorite});

    // Add or remove the hotel from the user's favorites sub-collection
    if (!restaurant.isFavorite) {
      // Add to favorites
      await userFavoritesRef.doc(restaurant.name).set({
        'name': restaurant.name,
        // Add any other relevant data you want to store
      });
    } else {
      // Remove from favorites
      await userFavoritesRef.doc(restaurant.name).delete();
    }

    // Update the local state to reflect the change
    setState(() {
      luxorAswanRests[index].isFavorite = !luxorAswanRests[index]
          .isFavorite; // Use alexHotels instead of cairoHotels
    });
  }

  Future<void> fetchBool() async {
    for (int i = 0; i < luxorAswanRests.length; i++) {
      DocumentSnapshot document = await FirebaseFirestore.instance
          .collection('restaurant')
          .doc(luxorAswanRests[i].name)
          .get();
      if (document.exists) {
        bool isFavorite = document.get('isFavourite');
        luxorAswanRests[i] = Rest(
          luxorAswanRests[i].name,
          luxorAswanRests[i].imagePaths,
          luxorAswanRests[i].description,
          luxorAswanRests[i].url,
          luxorAswanRests[i].locationurl,
          isFavorite,
          luxorAswanRests[i].pdfPath,
        );
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
          for (int i = 0; i < luxorAswanRests.length; i++)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarouselSlider(
                  items: luxorAswanRests[i]
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
                    activeIndices[i], luxorAswanRests[i].imagePaths.length),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      SizedBox(width: 8),
                      Text(
                        luxorAswanRests[i].name,
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
                          _launchURL(luxorAswanRests[i]
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
                              content: Text(luxorAswanRests[i].isFavorite
                                  ? 'Removed from Favorites!'
                                  : 'Added to Favorites!'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                        child: Icon(
                          luxorAswanRests[i].isFavorite
                              ? Icons.favorite
                              : Icons.favorite_outline,
                          color: Color.fromARGB(255, 13, 16, 74),
                        ),
                      ),
                      SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          if (luxorAswanRests[i].pdfPath.isNotEmpty) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PDFScreen(
                                    pdfPath: luxorAswanRests[i].pdfPath),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('No menu available'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          }
                        },
                        child: Icon(
                          Icons.menu_book_rounded,
                          color: Color.fromARGB(255, 13, 16, 74),
                        ),
                      ),
                      SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          _launchURL(
                              luxorAswanRests[i].url); // Launch URL when tapped
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
                    luxorAswanRests[i].description,
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

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }
}

class PDFScreen extends StatelessWidget {
  final String pdfPath;

  PDFScreen({required this.pdfPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Restaurant\'s menu',
          style: TextStyle(
            color: Color.fromARGB(255, 121, 155, 228), // Text color
            fontWeight: FontWeight.bold, // Bold text
            fontFamily: 'MadimiOne', // Font family
          ),
        ),
      ),
      body: SfPdfViewer.asset(
        pdfPath,
      ),
    );
  }
}
