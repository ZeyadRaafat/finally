import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'info.dart';
import '../restaurant.dart';

List<Rest> alexRests = [
  Rest(
      "Ginger",
      [
        'images/alexrest/gin1.jpg',
        'images/alexrest/gin2.jpg',
        'images/alexrest/gin3.jpg',
        'images/alexrest/gin4.jpg',
      ],
      "Ginger Restaurant: A delightful dining destination in Egypt, known for its flavorful cuisine and inviting atmosphere.",
      "https://www.tripadvisor.com.eg/Restaurant_Review-g294201-d23521213-Reviews-Ginger_Restaurant-Cairo_Cairo_Governorate.html/",
      "https://maps.app.goo.gl/vLK7JA2NybnPZV9n8",
      false,
      "Pdfs/menus/ginger alex.pdf"),
  Rest(
      "Mafia",
      [
        'images/alexrest/mafia1.jpg',
        'images/alexrest/mafia2.jpg',
        'images/alexrest/mafia3.jpg',
        'images/alexrest/mafia4.jpg',
      ],
      "Mafia Restaurant: A unique dining experience in Egypt, combining a themed ambiance with delicious cuisine for an unforgettable meal.",
      "https://www.menuegypt.com/ar/%D9%85%D8%A7%D9%81%D9%8A%D8%A7/Alex/%D8%B3%D9%86%D8%AF%D9%88%D8%AA%D8%B4%D8%A7%D8%AA/",
      "https://maps.app.goo.gl/ZYC632Nqw4gtPhBWA",
      false,
      "Pdfs/menus/mafia alex.pdf"),
  Rest(
      'White&Blue',
      [
        'images/alexrest/blue1.jpg',
        'images/alexrest/blue2.jpg',
        'images/alexrest/blue3.jpg',
        'images/alexrest/blue4.jpg',
      ],
      "Blue and White Restaurant: A chic dining establishment in Egypt, offering a stylish ambiance and delectable cuisine with a modern twist.",
      "https://www.tripadvisor.com.eg/Restaurant_Review-g295398-d2361538-Reviews-White_and_Blue_Restaurant-Alexandria_Alexandria_Governorate.html/",
      "https://maps.app.goo.gl/u99mB5KvFncempXc8",
      false,
      ""),
  Rest(
      'Koshary El Tahrir',
      [
        'images/alexrest/kosh1.jpg',
        'images/alexrest/kosh2.jpg',
        'images/alexrest/khos3.jpg',
        'images/alexrest/khos4.jpg',
      ],
      "Koshary El Tahrir: A popular eatery in Egypt, celebrated for its delicious and authentic Egyptian street food, particularly the iconic dish, koshary.",
      "https://www.tripadvisor.com/LocationPhotoDirectLink-g295398-d2727688-i369439157-Koshary_El_Tahrir-Alexandria_Alexandria_Governorate.html/",
      "https://maps.app.goo.gl/dBAGKQP9EVbkrN4Z7",
      false,
      "Pdfs/menus/tahrer.pdf"),
  Rest(
      'Sahar El-Laialy',
      [
        'images/alexrest/shar2.jpg',
        'images/alexrest/shar1.jpg',
        'images/alexrest/shar3.jpg',
        'images/alexrest/shar4.jpg',
      ],
      "Sahar El-Laialy Restaurant: A renowned dining spot in Egypt, known for its flavorful cuisine and inviting atmosphere, perfect for enjoying a meal with family and friends.",
      "https://www.tripadvisor.com/LocationPhotoDirectLink-g295398-d2729767-i425165426-Sahar_El_Laialy_Lebanese_Restaurant-Alexandria_Alexandria_Governorate.html/",
      "https://maps.app.goo.gl/WGrjVuLXCATit9116",
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
  List<int> activeIndices = List.filled(alexRests.length, 0);
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
        alexRests[index]; // Use alexHotels instead of cairoHotels
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
      alexRests[index].isFavorite =
          !alexRests[index].isFavorite; // Use alexHotels instead of cairoHotels
    });
  }

  Future<void> fetchBool() async {
    for (int i = 0; i < alexRests.length; i++) {
      DocumentSnapshot document = await FirebaseFirestore.instance
          .collection('restaurant')
          .doc(alexRests[i].name)
          .get();
      if (document.exists) {
        bool isFavorite = document.get('isFavourite');
        alexRests[i] = Rest(
          alexRests[i].name,
          alexRests[i].imagePaths,
          alexRests[i].description,
          alexRests[i].url,
          alexRests[i].locationurl,
          isFavorite,
          alexRests[i].pdfPath,
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
          'Alexandria',
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
              MaterialPageRoute(builder: (context) => SecRoute()),
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
                fontSize: 25.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 20.h),
          for (int i = 0; i < alexRests.length; i++)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarouselSlider(
                  items: alexRests[i]
                      .imagePaths
                      .map((imagePath) => Container(
                            margin: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(imagePath),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(25.r),
                            ),
                          ))
                      .toList(),
                  options: CarouselOptions(
                    height: 180.h,
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
                SizedBox(height: 10.h),
                buildIndicator(
                    activeIndices[i], alexRests[i].imagePaths.length),
                SizedBox(height: 10.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      SizedBox(width: 8.w),
                      Text(
                        alexRests[i].name,
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'MadimiOne',
                          color: Color.fromARGB(255, 83, 137, 182),
                        ),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(width: 8.w),
                      GestureDetector(
                        onTap: () {
                          _launchURL(alexRests[i]
                              .locationurl); // Launch URL when tapped
                        },
                        child: Icon(
                          Icons.location_on,
                          color: Color.fromARGB(255, 5, 59, 107),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      GestureDetector(
                        onTap: () {
                          toggleFavoriteStatus(i);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(alexRests[i].isFavorite
                                  ? 'Removed from Favorites!'
                                  : 'Added to Favorites!'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                        child: Icon(
                          alexRests[i].isFavorite
                              ? Icons.favorite
                              : Icons.favorite_outline,
                          color: Color.fromARGB(255, 13, 16, 74),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      GestureDetector(
                        onTap: () {
                          if (alexRests[i].pdfPath.isNotEmpty) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    PDFScreen(pdfPath: alexRests[i].pdfPath),
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
                      SizedBox(width: 8.w),
                      GestureDetector(
                        onTap: () {
                          _launchURL(
                              alexRests[i].url); // Launch URL when tapped
                        },
                        child: Icon(
                          Icons.link,
                          color: Colors.blue, // Use blue color for link icon
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    alexRests[i].description,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Color.fromARGB(255, 36, 108, 163),
                      fontFamily: 'MadimiOne',
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(height: 10.h),
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
          dotWidth: 18.w,
          dotHeight: 18.h,
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
    print('pdffffff ${pdfPath}');
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
