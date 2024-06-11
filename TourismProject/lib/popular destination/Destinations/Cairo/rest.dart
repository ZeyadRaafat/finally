import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../restaurant.dart';

List<Rest> cairoRests = [
  Rest(
      "Al Khal",
      [
        'images/cairorest/khal1.jpg',
        'images/cairorest/khal2.jpg',
        'images/cairorest/khal3.jpg',
        'images/cairorest/khal4.jpg',
      ],
      "Al Khal Egyptian Restaurant: A beloved eatery in Egypt, serving authentic cuisine with a warm ambiance.",
      "https://www.tripadvisor.com/Restaurant_Review-g294201-d2715802-Reviews-or90-Al_Khal_Egyptian_Restaurant-Cairo_Cairo_Governorate.html/",
      "https://maps.app.goo.gl/CmDYS5mhf1cqS5gLA",
      false,
      "Pdfs/menus/elkhal cairo.pdf"),
  Rest(
      "Frank and Co restaurant",
      [
        'images/cairorest/frank.jpg',
        'images/cairorest/frank2.jpg',
        'images/cairorest/frank3.jpg',
        'images/cairorest/frank4.jpg',
      ],
      "Frank and Co Restaurant: A cozy dining establishment known for its welcoming atmosphere and delicious food in Egypt.",
      "https://www.tripadvisor.com/Restaurant_Review-g294201-d13277057-Reviews-Frank_and_Co-Cairo_Cairo_Governorate.html/",
      "https://maps.app.goo.gl/jQ5bkwQY2vfdhUfZ7",
      false,
      "Pdfs/menus/frank and co Cairo.pdf"),
  Rest(
      'Scores Sports',
      [
        'images/cairorest/sco1.jpg',
        'images/cairorest/sco2.jpg',
        'images/cairorest/sco3.jpg',
        'images/cairorest/sco4.jpg',
      ],
      "Scores Sports Bar & Restaurant: A vibrant venue in Egypt, offering a lively atmosphere, delicious food, and live sports entertainment.",
      "https://www.tripadvisor.com/Restaurant_Review-g294201-d14774406-Reviews-Scores_Sports_Bar_Restaurant-Cairo_Cairo_Governorate.html/",
      "https://maps.app.goo.gl/tPEpwP52ozdsbrga7",
      false,
      ""),
  Rest(
      'Zi bar bar &restaurant',
      [
        'images/cairorest/zi1.jpg',
        'images/cairorest/zi2.jpg',
        'images/cairorest/zi3.jpg',
        'images/cairorest/zi4.jpg',
      ],
      "Zi Bar & Restaurant: A trendy spot in Egypt, blending chic ambiance with delectable cuisine for a memorable dining experience.",
      "http://zilounge.com/",
      "https://maps.app.goo.gl/shxca3JL9zyDqwoa6",
      false,
      ""),
  Rest(
      'Bistro Paris Maadi',
      [
        'images/cairorest/bisto1.jpg',
        'images/cairorest/bisto2.jpg',
        'images/cairorest/bisto3.jpg',
        'images/cairorest/bistro4.jpg',
      ],
      "Bistro Paris: A charming eatery in Egypt, evoking the ambiance of a Parisian café with delicious French-inspired cuisine.",
      "https://www.tripadvisor.com/LocationPhotoDirectLink-g294201-d25333819-i676620050-Bistro_Paris_Maadi-Cairo_Cairo_Governorate.html/",
      "https://maps.app.goo.gl/7gSVQoT19opQDAnk7",
      false,
      "Pdfs/menus/bistro paris cairo.pdf"),
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
  List<int> activeIndices = List.filled(cairoRests.length, 0);
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
        cairoRests[index]; // Use alexHotels instead of cairoHotels
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
      cairoRests[index].isFavorite = !cairoRests[index]
          .isFavorite; // Use alexHotels instead of cairoHotels
    });
  }

  Future<void> fetchBool() async {
    for (int i = 0; i < cairoRests.length; i++) {
      DocumentSnapshot document = await FirebaseFirestore.instance
          .collection('restaurant')
          .doc(cairoRests[i].name)
          .get();
      if (document.exists) {
        bool isFavorite = document.get('isFavourite');
        cairoRests[i] = Rest(
          cairoRests[i].name,
          cairoRests[i].imagePaths,
          cairoRests[i].description,
          cairoRests[i].url,
          cairoRests[i].locationurl,
          isFavorite,
          cairoRests[i].pdfPath,
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
          for (int i = 0; i < cairoRests.length; i++)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarouselSlider(
                  items: cairoRests[i]
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
                    activeIndices[i], cairoRests[i].imagePaths.length),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      SizedBox(width: 8),
                      Text(
                        cairoRests[i].name,
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
                          _launchURL(cairoRests[i]
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
                              content: Text(cairoRests[i].isFavorite
                                  ? 'Removed from Favorites!'
                                  : 'Added to Favorites!'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                        child: Icon(
                          cairoRests[i].isFavorite
                              ? Icons.favorite
                              : Icons.favorite_outline,
                          color: Color.fromARGB(255, 13, 16, 74),
                        ),
                      ),
                      SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          if (cairoRests[i].pdfPath.isNotEmpty) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    PDFScreen(pdfPath: cairoRests[i].pdfPath),
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
                              cairoRests[i].url); // Launch URL when tapped
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
                    cairoRests[i].description,
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
