import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'info.dart';
import 'package:url_launcher/url_launcher.dart';
import '../restaurant.dart';

List<Rest> sinaiRests = [
  Rest(
      "Athanor Pizzeria",
      [
        'images/sinairest/anth1.jpg',
        'images/sinairest/anth2.jpg',
        'images/sinairest/anth3.jpg',
        'images/sinairest/anth4.jpg',
      ],
      "Athanor Pizzeria: A cozy pizzeria in Egypt, serving up delicious pies with a variety of toppings in a relaxed atmosphere.",
      "https://www.elmenus.com/dahab/athanor-r92w",
      "https://maps.app.goo.gl/ffEMqLeDLJrHLUDX6",
      false,
      ""),
  Rest(
      "Boharat Restaurant",
      [
        'images/sinairest/boh1.jpg',
        'images/sinairest/boh2.jpg',
        'images/sinairest/boh3.jpg',
        'images/sinairest/boh4.jpg',
      ],
      "Boharat Restaurant: A taste of excellence in Egypt, with flavorful dishes served in a cozy setting.",
      "https://www.tripadvisor.com/Restaurant_Review-g297555-d10665099-Reviews-Boharat_Restaurant-Sharm_El_Sheikh_South_Sinai_Red_Sea_and_Sinai.html",
      "https://maps.app.goo.gl/m6SFKPBtsd9XK5rW9",
      false,
      "Pdfs/menus/boharat sina.pdf"),
  Rest(
      'Camel Bar & Rooftop',
      [
        'images/sinairest/cam1.jpg',
        'images/sinairest/cam2.jpg',
        'images/sinairest/cam3.jpg',
        'images/sinairest/cam4.jpg',
      ],
      "Camel Bar & Rooftop: A lively spot in Egypt, offering refreshing drinks and a vibrant atmosphere with stunning rooftop views.",
      "https://www.cameldive.com/food-and-drinks-camel-bar-rooftop/",
      "https://www.google.com/maps/place/Camel+Bar+%26+Rooftop/@27.9094122,34.3224081,17z/data=!3m1!4b1!4m6!3m5!1s0x1453382c839df84f:0x4207b3fab8e43e72!8m2!3d27.9094075!4d34.324983!16s%2Fg%2F12hkb2yy1?entry=ttu",
      false,
      ""),
  Rest(
      'King Chicken',
      [
        'images/sinairest/king1.jpg',
        'images/sinairest/king2.jpg',
        'images/sinairest/king3.jpg',
        'images/sinairest/king4.jpg',
      ],
      "King Chicken Restaurant: Egypt's hotspot for tasty chicken in a friendly atmosphere.",
      "https://www.tripadvisor.com/Restaurant_Review-g297547-d2033607-Reviews-King_Chicken-Dahab_South_Sinai_Red_Sea_and_Sinai.html",
      "https://www.google.com/maps/place/King+Chicken/@28.1776317,34.0808548,10z/data=!4m12!1m2!2m1!1sKing+Chicken!3m8!1s0x15ab4b36e98213ad:0x1db06a6653b987c7!8m2!3d28.4929422!4d34.5159413!9m1!1b1!15sCgxLaW5nIENoaWNrZW5aDiIMa2luZyBjaGlja2VukgESY2hpY2tlbl9yZXN0YXVyYW504AEA!16s%2Fg%2F11c481vfqq?entry=ttu",
      false,
      ""),
  Rest(
      'Mango Restaurant',
      [
        'images/sinairest/mango1.jpg',
        'images/sinairest/mango2.jpg',
        'images/sinairest/mango3.jpg',
        'images/sinairest/mango4.jpg',
      ],
      "Mango Restaurant: A delightful dining spot in Egypt, offering delicious cuisine with a tropical twist in a relaxed setting.",
      "https://www.tripadvisor.com/Restaurant_Review-g297555-d20069368-Reviews-Mango_Chinese_Restaurant-Sharm_El_Sheikh_South_Sinai_Red_Sea_and_Sinai.html",
      "https://maps.google.com/?cid=6081069186578010497&entry=gps",
      false,
      "Pdfs/menus/mango sinaa.pdf"),
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
  List<int> activeIndices = List.filled(sinaiRests.length, 0);
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
        sinaiRests[index]; // Use alexHotels instead of cairoHotels
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
      sinaiRests[index].isFavorite = !sinaiRests[index]
          .isFavorite; // Use alexHotels instead of cairoHotels
    });
  }

  Future<void> fetchBool() async {
    for (int i = 0; i < sinaiRests.length; i++) {
      DocumentSnapshot document = await FirebaseFirestore.instance
          .collection('restaurant')
          .doc(sinaiRests[i].name)
          .get();
      if (document.exists) {
        bool isFavorite = document.get('isFavourite');
        sinaiRests[i] = Rest(
          sinaiRests[i].name,
          sinaiRests[i].imagePaths,
          sinaiRests[i].description,
          sinaiRests[i].url,
          sinaiRests[i].locationurl,
          isFavorite,
          sinaiRests[i].pdfPath,
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
          for (int i = 0; i < sinaiRests.length; i++)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarouselSlider(
                  items: sinaiRests[i]
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
                    activeIndices[i], sinaiRests[i].imagePaths.length),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      SizedBox(width: 8),
                      Text(
                        sinaiRests[i].name,
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
                          _launchURL(sinaiRests[i]
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
                              content: Text(sinaiRests[i].isFavorite
                                  ? 'Removed from Favorites!'
                                  : 'Added to Favorites!'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                        child: Icon(
                          sinaiRests[i].isFavorite
                              ? Icons.favorite
                              : Icons.favorite_outline,
                          color: Color.fromARGB(255, 13, 16, 74),
                        ),
                      ),
                      SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          if (sinaiRests[i].pdfPath.isNotEmpty) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    PDFScreen(pdfPath: sinaiRests[i].pdfPath),
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
                              sinaiRests[i].url); // Launch URL when tapped
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
                    sinaiRests[i].description,
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
