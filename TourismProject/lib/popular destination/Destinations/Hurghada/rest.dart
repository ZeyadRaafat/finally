import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'info.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';
import '../restaurant.dart';

List<Rest> hurghadaRests = [
  Rest(
      "Corallo",
      [
        'images/hurghadares/ca3.jpg',
        'images/hurghadares/ca2.jpg',
        'images/hurghadares/ca4.jpg',
        'images/hurghadares/ca1.jpg',
      ],
      "Corala Restaurant: A charming seaside eatery in Egypt, serving fresh seafood with picturesque views.",
      "https://www.tripadvisor.com.eg/Restaurant_Review-g424910-d5970375-Reviews-Corallo_Sea_Food_Almaza_Bay-Mersa_Matruh_Matrouh_Governorate.html/",
      "https://www.google.com/maps/place/Corallo/@27.0912931,33.8440293,17z/data=!3m1!4b1!4m6!3m5!1s0x145281ace8910705:0xd2f7a11f18421de0!8m2!3d27.0912931!4d33.8466096!16s%2Fg%2F11fsh7p9kt?entry=ttu",
      false,
      ""),
  Rest(
      "La Cantina",
      [
        'images/hurghadares/laa1.jpg',
        'images/hurghadares/laa2.jpg',
        'images/hurghadares/laa4.jpg',
        'images/hurghadares/laa3.jpg',
      ],
      "La Cantina Restaurant and Bar: A vibrant dining venue in Egypt, offering delicious cuisine and refreshing drinks in a lively atmosphere.",
      "https://www.tripadvisor.com/Restaurant_Review-g297549-d25409730-Reviews-La_Cantina-Hurghada_Red_Sea_and_Sinai.html/",
      "https://www.google.com/maps/place/La+Cantina+Restaurant+and+Bar/@27.2268658,33.8387855,17z/data=!3m1!4b1!4m6!3m5!1s0x145287040356ae4f:0x7a32f5c9b735f5d0!8m2!3d27.2268658!4d33.8413658!16s%2Fg%2F11tgdbh4r1?entry=ttu",
      false,
      ""),
  Rest(
      'MAKAI TUKAI',
      [
        'images/hurghadares/maka1.jpg',
        'images/hurghadares/maka2.jpg',
        'images/hurghadares/maka3.jpg',
        'images/hurghadares/maka4.jpg',
      ],
      "Makai Tukai: A cozy eatery in Egypt, serving flavorful dishes in a relaxed setting, perfect for a casual dining experience.",
      "https://www.tripadvisor.com.eg/Restaurant_Review-g297549-d7313956-Reviews-Makai_Tukai_Restaurant-Hurghada_Red_Sea_and_Sinai.html/",
      "https://www.google.com/maps/place/MAKAI+TUKAI/@27.0909035,33.7641797,12z/data=!4m6!3m5!1s0x14528130eb49c401:0x9d1ae08c4fd164f7!8m2!3d27.0909757!4d33.8471072!16s%2Fg%2F11j2vy6515?entry=ttu",
      false,
      ""),
  Rest(
      'Nino\'s Resturant',
      [
        'images/hurghadares/nino1.jpg',
        'images/hurghadares/nino2.jpg',
        'images/hurghadares/nino3.jpg',
        'images/hurghadares/nino4.jpg',
      ],
      "Nino's Restaurant: A favorite spot in Egypt for delicious food in a cozy atmosphere.",
      "https://www.tripadvisor.com/Restaurant_Review-g297549-d7173339-Reviews-Nino_s_Restaurant-Hurghada_Red_Sea_and_Sinai.html/",
      "https://www.google.com/maps/place/Nino's+Restaurant/@27.0926936,33.8449733,17z/data=!3m1!4b1!4m6!3m5!1s0x145281d5fcac98d5:0x52e81ce324fccb05!8m2!3d27.0926936!4d33.8475536!16s%2Fg%2F11c1s353m8?entry=ttu",
      false,
      "Pdfs/menus/ninos hurghada.pdf"),
  Rest(
      'Sofra Oriental',
      [
        'images/hurghadares/sof1.jpg',
        'images/hurghadares/sof2.jpg',
        'images/hurghadares/sof3.jpg',
        'images/hurghadares/sof4.jpg',
      ],
      "Sofra Oriental: Egypt's go-to for authentic Oriental cuisine in a cozy setting.",
      "https://www.tripadvisor.com/Restaurant_Review-g297549-d3752928-Reviews-or60-Sofra-Hurghada_Red_Sea_and_Sinai.html/",
      "https://www.google.com/maps/place/Sofra+Oriental/@26.9888564,33.8946539,17z/data=!3m1!4b1!4m6!3m5!1s0x144d7bfc771702e1:0xe9db48e54a29fb30!8m2!3d26.9888516!4d33.8972288!16s%2Fg%2F1tdnhdpp?entry=ttu",
      false,
      "Pdfs/menus/sofra hurghada.pdf"),
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
  List<int> activeIndices = List.filled(hurghadaRests.length, 0);
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
        hurghadaRests[index]; // Use alexHotels instead of cairoHotels
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
      hurghadaRests[index].isFavorite = !hurghadaRests[index]
          .isFavorite; // Use alexHotels instead of cairoHotels
    });
  }

  Future<void> fetchBool() async {
    for (int i = 0; i < hurghadaRests.length; i++) {
      DocumentSnapshot document = await FirebaseFirestore.instance
          .collection('restaurant')
          .doc(hurghadaRests[i].name)
          .get();
      if (document.exists) {
        bool isFavorite = document.get('isFavourite');
        hurghadaRests[i] = Rest(
          hurghadaRests[i].name,
          hurghadaRests[i].imagePaths,
          hurghadaRests[i].description,
          hurghadaRests[i].url,
          hurghadaRests[i].locationurl,
          isFavorite,
          hurghadaRests[i].pdfPath,
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
              'Restaurant',
              style: TextStyle(
                fontFamily: 'MadimiOne',
                color: Color.fromARGB(255, 121, 155, 230),
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 20),
          for (int i = 0; i < hurghadaRests.length; i++)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarouselSlider(
                  items: hurghadaRests[i]
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
                    activeIndices[i], hurghadaRests[i].imagePaths.length),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      SizedBox(width: 8),
                      Text(
                        hurghadaRests[i].name,
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
                          _launchURL(hurghadaRests[i]
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
                              content: Text(hurghadaRests[i].isFavorite
                                  ? 'Removed from Favorites!'
                                  : 'Added to Favorites!'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                        child: Icon(
                          hurghadaRests[i].isFavorite
                              ? Icons.favorite
                              : Icons.favorite_outline,
                          color: Color.fromARGB(255, 13, 16, 74),
                        ),
                      ),
                      SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          if (hurghadaRests[i].pdfPath.isNotEmpty) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PDFScreen(
                                    pdfPath: hurghadaRests[i].pdfPath),
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
                              hurghadaRests[i].url); // Launch URL when tapped
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
                    hurghadaRests[i].description,
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
