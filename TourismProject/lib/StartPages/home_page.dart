//import 'dart:async';
import 'package:Guide/landmarks.dart';
import 'package:Guide/popular%20destination/home_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:Guide/widgets/app_drawer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../monumentos%20religioss/monumentos.dart';
import '../seashores/seashores.dart';

String? finalEmail;

class Homepage extends StatefulWidget {
  Homepage({Key? key}) : super(key: key);

  static const screenRoute = '/homepage';

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final TextEditingController _searchController = TextEditingController();

  final List<String> _places = [
    'Cairo',
    'Alexandria',
    'Luxor',
    'Aswan',
    'Luxor And Aswan',
    'Hurghada',
    'Siwa',
    'Sinai',
    // Add more places
  ];
  List<String> _filteredPlaces = [];

  final List<String> urlImages = [
    'images/photo_2024-03-22_00-51-19.jpg',
    'images/photo_2024-03-22_00-51-21.jpg',
    'images/photo_2024-03-22_00-51-22.jpg',
    'images/photo_2024-03-22_00-51-25.jpg',
    'images/photo_2024-03-22_00-51-28.jpg',
  ];

  final List<String> circleImages = [
    'images/cairoplaces/mus4.jpg',
    'images/cairoplaces/tower1.jpg',
    'images/monumentosplaces/azhar1.jpg',
    'images/seashores/matroh3.jpg',
  ];

  final List<String> clipRRectImages = [
    'images/monumentosplaces/azhar1.jpg',
    'images/seashores/matroh3.jpg',
  ];

  @override
  void initState() {
    getValidationData().whenComplete(() async {
      if (finalEmail == null) {
        Navigator.pushNamed(context, 'login');
      }
    });
    super.initState();
    _filteredPlaces = _places;
    _searchController.addListener(_handleSearch);
  }

  Future getValidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var OptainedEmail = sharedPreferences.getString('email');
    setState(() {
      finalEmail = OptainedEmail;
    });
    print(finalEmail);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _handleSearch() {
    final query = _searchController.text.toLowerCase();
    _filteredPlaces = _places
        .where((place) => place.toLowerCase().startsWith(query))
        .toList();
    setState(() {});
  }

  void _onSearchPressed() {
    String query = _searchController.text.trim().toLowerCase();
    if (query.isNotEmpty) {
      switch (query) {
        case 'cairo':
          Navigator.pushNamed(context, 'cairo');
          break;
        case 'alexandria':
          Navigator.pushNamed(context, 'alex');
          break;
        case 'luxor':
          Navigator.pushNamed(context, 'luxAndAsw');
          break;
        case 'Aswan':
          Navigator.pushNamed(context, 'luxAndAsw');
          break;
        case 'luxor and aswan':
          Navigator.pushNamed(context, 'luxAndAsw');
          break;
        case 'hurghada':
          Navigator.pushNamed(context, 'hurghada');
          break;
        case 'siwa':
          Navigator.pushNamed(context, 'siwa');
          break;
        case 'sinai':
          Navigator.pushNamed(context, 'sinai');
          break;
        // Add more cases for other government names
        default:
          print('No matching screen found for: $query');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Color.fromARGB(255,121, 155, 228),
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Home ",
                  style: TextStyle(
                    fontSize: 25,
                    fontFamily: 'MadimiOne',
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
                Text(
                  "Page",
                  style: TextStyle(
                    fontSize: 25,
                    fontFamily: 'MadimiOne',
                    color: Color.fromARGB(255, 22, 23, 82),
                  ),
                ),
              ],
            ),
            centerTitle: true,
            stretch: true,
            expandedHeight: 250,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: [StretchMode.blurBackground],
              background: Container(
                color: Color.fromARGB(255, 121, 155, 228),
                padding: EdgeInsets.only(top: 30.0, bottom: 20.0),
                alignment: Alignment.bottomCenter,
                child: Text(
                  "Tourism guiding involves leading tours and providing insightful information about destinations, ensuring visitors have an engaging and enjoyable experience.",
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'MadimiOne',
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(16),
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15),
                  Text(
                    'Where you want to go?',
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 20,
                      fontFamily: 'MadimiOne',
                    ),
                  ),
                  SizedBox(height: 15),
                  TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(255, 229, 234, 238),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                        borderSide: BorderSide.none,
                      ),
                      hintText: "search",
                      prefixIcon: Icon(Icons.search),
                    ),
                    onSubmitted: (value) => _onSearchPressed(),
                  ),
                  SizedBox(
                      height: 30), // Add some space before the categories text
                  Text(
                    '- Categories',
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 25,
                      fontFamily: 'MadimiOne',
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                height: 400,
                color: Color.fromARGB(232, 255, 255, 255),
                child: Column(
                  children: [
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => HomeView(),));
                          },
                          child: CircleAvatar(
                          radius: 70,
                          backgroundImage: AssetImage(circleImages[0]),
                        ),
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => landMark(),));
                          },
                          child: CircleAvatar(
                          radius: 70,
                          backgroundImage: AssetImage(circleImages[1]),
                        ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Popular destination',
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 15,
                            fontFamily: 'MadimiOne',
                          ),
                        ),
                        Text(
                          'Landmarks',
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 15,
                            fontFamily: 'MadimiOne',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => monumentos(),));
                          },
                          child: CircleAvatar(
                          radius: 70,
                          backgroundImage: AssetImage(circleImages[2]),
                        ),
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => shores(),));
                          },
                          child: CircleAvatar(
                          radius: 70,
                          backgroundImage: AssetImage(circleImages[3]),
                        ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Monumentos religiosos',
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 15,
                            fontFamily: 'MadimiOne',
                          ),
                        ),
                        Text(
                          'Seashores',
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 15,
                            fontFamily: 'MadimiOne',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 20),
          ),
          SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '  - Travel places',
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 25,
                    fontFamily: 'MadimiOne',
                  ),
                ),
              ],
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: 300,
                  color: Color.fromARGB(232, 255, 255, 255),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CarouselSlider.builder(
                        itemCount: urlImages.length,
                        itemBuilder: (context, index, realIndex) {
                          final String imageUrl = urlImages[index];
                          return buildImage(imageUrl);
                        },
                        options: CarouselOptions(
                          height: 200,
                          viewportFraction: 1,
                          autoPlay: true,
                          enlargeCenterPage: true,
                          enlargeStrategy: CenterPageEnlargeStrategy.height,
                          reverse: true,
                          autoPlayInterval: Duration(seconds: 3),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      drawer: Appdrawer(),
    );
  }

  Widget buildImage(String url) => Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          image: DecorationImage(
            image: AssetImage(url),
            fit: BoxFit.cover,
          ),
        ),
      );
}
