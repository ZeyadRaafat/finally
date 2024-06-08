import 'package:flutter/material.dart';
import 'package:new_project/popular%20destination/home_view.dart';
import './Specification.dart';

class FourthRoute extends StatefulWidget {
  @override
  _FourthRouteState createState() => _FourthRouteState();
}

class _FourthRouteState extends State<FourthRoute> {
  // Track the expanded state of each image
  bool _isExpanded1 = false;
  bool _isExpanded2 = false;
  bool _isExpanded3 = false;

  // Function to toggle the expanded state of an image
  void _toggleExpandedState(int imageIndex) {
    setState(() {
      switch (imageIndex) {
        case 1:
          _isExpanded1 = !_isExpanded1;
          break;
        case 2:
          _isExpanded2 = !_isExpanded2;
          break;
        case 3:
          _isExpanded3 = !_isExpanded3;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBar(
          title: Text(
            'Siwa',
            style: TextStyle(
              color: Color.fromARGB(255, 121, 155, 228), // Text color
              fontWeight: FontWeight.bold, // Bold text
              fontFamily: 'MadimiOne', // Font family
            ),
          ),
          primary: true, // Make the app bar static
          leading: GestureDetector(
            child: Icon(
              Icons.arrow_back_ios,
              color: Color.fromARGB(255, 121, 155, 228), // Icon color
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeView(),
                  )); // Implement the back button functionality
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Specify(),
            SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          _toggleExpandedState(
                              1); // Toggle image 1 expanded state
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          width: _isExpanded1 ? 300 : 200,
                          height: _isExpanded1 ? 300 : 150,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(
                              'images/siwa1.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          _toggleExpandedState(
                              2); // Toggle image 2 expanded state
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          width: _isExpanded2 ? 300 : 200,
                          height: _isExpanded2 ? 300 : 150,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(
                              'images/siwa2.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          _toggleExpandedState(
                              3); // Toggle image 3 expanded state
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          width: _isExpanded3 ? 300 : 200,
                          height: _isExpanded3 ? 300 : 150,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(
                              'images/siwa3.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                'About Siwa:',
                style: TextStyle(
                  fontFamily: 'MadimiOne',
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Siwa was known as Sekht-am in ancient Egyptian times, meaning \“Field of Trees.\” It was home to the oracle temple of Amon (Zeus Ammon), which gained fame during the time of Herodotus and was even consulted by Alexander the Great,The fragmentary remains of the temple, dating back to the 4th century BCE, lie in the ruins of Aghūrmī,The oracle fell into disrepute during the Roman occupation of Egypt,The Arabic name for the oasis is Siwah, while it was called Sali in Berber,The oasis is also known as Isiwan in modern Berber,The etymology of the word Siwah is unclear, with various theories linking it to Coptic, Berber, and Egyptian sources.',
                style: TextStyle(
                  fontFamily: 'MadimiOne',
                  fontSize: 15,
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                'Getting to Siwa',
                style: TextStyle(
                  fontFamily: 'MadimiOne',
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Bus:The most common way to reach Siwa from Cairo is by taking a bus. The journey takes approximately 7 hours and 30 minutes,You can catch a bus from Abd Al Moneim Riad in Cairo to Siwa Oasis. The ticket price is around \$6,Bus operators: Everday Bus and West and Middle delta.\n\n'
                'Taxi:If you prefer a more direct route, you can hire a taxi. The distance between Cairo and Siwa Oasis is approximately 740.9 kilometers,The taxi ride will take around 9 hours and 3 minutes1,Estimated cost: \$28 - \$35.\n\n'
                'Private Car: For convenience and flexibility, consider traveling by private car. The drive from Cairo to Siwa Oasis takes about 8 to 9 hours, including a few stops along the way,Cairo Top Tours can arrange a tour from Cairo to Siwa Oasis at affordable prices.\n\n',
                style: TextStyle(
                  fontFamily: 'MadimiOne',
                  fontSize: 15,
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                'Best Time to visit',
                style: TextStyle(
                  fontFamily: 'MadimiOne',
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'he best time to visit Siwa Oasis in Egypt is from February 19th to April 29th. During this period, you’ll experience ideal weather conditions. Let’s delve into the details: Weather Overview: Siwa generally enjoys fine weather with abundant sunshine year-round,The most favorable time for a visit is from late February to late April, considering both temperature and humidity',
                style: TextStyle(
                  fontFamily: 'MadimiOne',
                  fontSize: 15,
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                'Must-See Attraction',
                style: TextStyle(
                  fontFamily: 'MadimiOne',
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'When visiting Siwa Oasis in Egypt, there are several must-see attractions that you won’t want to miss. Let’s explore them:\n\n'
                '1-The Fortress at Shali (Shali Fortress): Located in central Siwa, this 13th-century mud-brick fortress dominates the landscape with its spectacular organic shapes. Built from kershef (chunks of salt), it offers a glimpse into Siwa’s history and architectural heritage.\n\n'
                '2-Gebel Al Dakrur: Explore Gebel Al Dakrur, a mountain in Siwa known for its unique rock formations and stunning views. It’s a great spot for hiking and photography.\n\n'
                '3-Cleopatra’s Bath:Discover Cleopatra’s Bath, a natural spring believed to have been visited by the legendary Egyptian queen Cleopatra herself. The crystal-clear waters invite you to take a refreshing dip.\n\n',
                style: TextStyle(
                  fontFamily: 'MadimiOne',
                  fontSize: 15,
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                'Some Experiences to enjoy your trip in Hurghada',
                style: TextStyle(
                  fontFamily: 'MadimiOne',
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                '1-Camel Trekking in the Desert: Explore the vast desert landscapes on a traditional camel ride. Witness stunning sunrises and sunsets against the backdrop of rugged mountains and golden sands.\n\n'
                '2-Stargazing at Mount Dakrur: Head to Gebel Al Dakrur at night for an unforgettable stargazing experience. The clear desert skies offer breathtaking views of constellations and celestial wonders.\n\n'
                '3-Bedouin Tea and Hospitality: Connect with the local Bedouin community. Enjoy a cup of sweet Bedouin tea while listening to their stories and learning about their ancient way of life.\n\n'
                '4-Diving and Snorkeling in Cleopatra\’s Bath: Cleopatra\’s Bath is a natural spring believed to have been visited by the legendary Egyptian queen Cleopatra herself. Dive or snorkel in its crystal-clear waters.\n\n'
                '5-Explore the Temple of the Oracle (Temple of Amun): Visit the ancient Temple of the Oracle, where oracles once provided guidance. It gained fame during the time of Herodotus and was even consulted by Alexander the Great.\n\n'
                '6-Sunset at Fatnas: Witness the breathtaking sunset at Fatnas, a picturesque spot near Siwa. The changing colors of the sky over the desert create a magical experience.\n\n'
                '7-Discover Gebel Al Mawta (Mountain of the Dead): Explore the Mountain of the Dead, an ancient necropolis where rock-cut tombs and inscriptions reveal Siwa\’s past.'
                '8-Relax by Bir Wahed Hot-Cold Spring: Take a trip to Bir Wahed, a freshwater lake located 15 kilometers away on the edge of the Great Sand Sea. Unwind by the spring and enjoy the tranquility.\n\n'
                '9-Visit the Temple of Umm Ubaydah: Discover the Temple of Umm Ubaydah, another historical site in Siwa. Its ancient ruins offer insights into the oasis\’s rich heritage.\n\n'
                '10-Quad Biking in the Desert Dunes: Get your adrenaline pumping by renting a quad bike and exploring the desert dunes. It\’s a thrilling way to experience the rugged terrain.\n\n',
                style: TextStyle(
                  fontFamily: 'MadimiOne',
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
