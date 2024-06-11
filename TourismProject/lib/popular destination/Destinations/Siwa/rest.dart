import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'info.dart';
import 'package:url_launcher/url_launcher.dart';
import '../restaurant.dart';

List<Rest> siwaRests = [
  Rest(
      "Tekeyet Elamir",
      [
        'images/siwares/takia1.jpg',
        'images/siwares/takia2.jpg',
        'images/siwares/takia3.jpg',
        'images/siwares/takia4.jpg',
      ],
      "Tekeyet Elamir: A cozy spot in Egypt for traditional cuisine in a welcoming atmosphere.",
      "https://www.facebook.com/profile.php?id=100063058998505",
      "https://maps.app.goo.gl/i8CpW6NWSXUy4S229",
      false,
      "Pdfs/menus/takeyet elamir.pdf"),
  Rest(
      "Nour El Waha Garden",
      [
        'images/siwares/nor1.jpg',
        'images/siwares/nor2.jpg',
        'images/siwares/nor3.jpg',
        'images/siwares/nor4.jpg',
      ],
      "Nour El Waha Garden Restaurant: Egypt's oasis for delightful dining amidst lush greenery.",
      "https://www.rehlat.com.eg/ar/explore/restaurants/nour-el-waha-garden-restaurant-1580192",
      "https://maps.app.goo.gl/CDKUprTu4go9Uj6A8",
      false,
      "Pdfs/menus/elwaha siwa.pdf"),
  Rest(
      'Al-Babinshal',
      [
        'images/siwares/al4.jpg',
        'images/siwares/al3.jpg',
        'images/siwares/al2.jpg',
        'images/siwares/al1.jpg',
      ],
      "Al-Babinshal: Egypt's cozy spot for delicious dining.",
      "https://www.tripadvisor.com.eg/ShowUserReviews-g303857-d1013378-r648444923-Albabenshal-Siwa_Matrouh_Governorate.html",
      "https://maps.app.goo.gl/TiLN4gt1gqYG9VE17",
      false,
      ""),
  Rest(
      'Joba Lounge',
      [
        'images/siwares/jo1.jpg',
        'images/siwares/jo2.jpg',
        'images/siwares/jo3.jpg',
        'images/siwares/jo4.jpg',
      ],
      "Joba Lounge: A chic and trendy spot in Egypt, perfect for enjoying cocktails and socializing in a stylish atmosphere.",
      "https://www.tripadvisor.com/Restaurant_Review-g303857-d7778574-Reviews-Joba_Lounge-Siwa_Matrouh_Governorate.html",
      "https://maps.app.goo.gl/GDjocZFw8wnFqrWk9",
      false,
      ""),
  Rest(
      "Abu Ayman",
      [
        'images/siwares/abo1.jpg',
        'images/siwares/abo2.jpg',
        'images/siwares/abo3.jpg',
      ],
      "Abu Ayman Restaurant: A beloved dining destination in Egypt, serving up delicious cuisine with a welcoming atmosphere, perfect for enjoying a meal with friends and family.",
      "https://www.facebook.com/groups/980099102179067/",
      "https://maps.app.goo.gl/rHEnuR5AFGy2gqeP9",
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
  List<int> activeIndices = List.filled(siwaRests.length, 0);
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
        siwaRests[index]; // Use alexHotels instead of cairoHotels
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
      siwaRests[index].isFavorite =
          !siwaRests[index].isFavorite; // Use alexHotels instead of cairoHotels
    });
  }

  Future<void> fetchBool() async {
    for (int i = 0; i < siwaRests.length; i++) {
      DocumentSnapshot document = await FirebaseFirestore.instance
          .collection('restaurant')
          .doc(siwaRests[i].name)
          .get();
      if (document.exists) {
        bool isFavorite = document.get('isFavourite');
        siwaRests[i] = Rest(
          siwaRests[i].name,
          siwaRests[i].imagePaths,
          siwaRests[i].description,
          siwaRests[i].url,
          siwaRests[i].locationurl,
          isFavorite,
          siwaRests[i].pdfPath,
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
          for (int i = 0; i < siwaRests.length; i++)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarouselSlider(
                  items: siwaRests[i]
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
                    activeIndices[i], siwaRests[i].imagePaths.length),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      SizedBox(width: 8),
                      Text(
                        siwaRests[i].name,
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
                          _launchURL(siwaRests[i]
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
                              content: Text(siwaRests[i].isFavorite
                                  ? 'Removed from Favorites!'
                                  : 'Added to Favorites!'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                        child: Icon(
                          siwaRests[i].isFavorite
                              ? Icons.favorite
                              : Icons.favorite_outline,
                          color: Color.fromARGB(255, 13, 16, 74),
                        ),
                      ),
                      SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          if (siwaRests[i].pdfPath.isNotEmpty) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    PDFScreen(pdfPath: siwaRests[i].pdfPath),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('No menu available'),
                                duration: Duration(seconds: 5),
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
                              siwaRests[i].url); // Launch URL when tapped
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
                    siwaRests[i].description,
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
