import 'package:flutter/material.dart';
import 'package:new_project/popular%20destination/home_view.dart';
import './Specification.dart';

class ThirdRoute extends StatefulWidget {
  @override
  _ThirdRouteState createState() => _ThirdRouteState();
}

class _ThirdRouteState extends State<ThirdRoute> {
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
            'Luxor And Aswan',
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
                              'images/LuxAndAsw1.jpg',
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
                              'images/LuxAndAsw2.jpg',
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
                              'images/LuxAndAsw3.jpg',
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
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                'About Luxor And Aswan:',
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
                'Luxor and Aswan: These two Egyptian cities, nestled along the Nile River, hold ancient wonders waiting to be explored. In Luxor, you’ll encounter grand temples, mysterious tombs, and colossal statues. Aswan, with its Philae Temple and Nubian culture, offers a more tranquil experience. Both cities invite you to step back in time and immerse yourself in the magic of Egypt’s past.',
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
                'Getting to Luxor and Aswan',
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
                'Getting to Luxor: Travelers can easily access Luxor, a city rich in ancient Egyptian history, by various means. The most common ways include flying directly into Luxor International Airport, taking a train from major cities like Cairo, or enjoying a scenic cruise along the Nile River. Once in Luxor, visitors can explore iconic sites such as the Valley of the Kings and the Temple of Karnak, immersing themselves in the city’s storied past.',
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
                'The best time to visit Luxor and Aswan is during winter, from November to February. Although cooler temperatures also bring greater crowds, this period offers pleasant weather for exploring ancient ruins, temples, and historical sites. Alternatively, consider visiting in spring (March to May) or autumn (September to November) for milder weather and fewer tourists. Whether you’re fascinated by Luxor’s open-air museum or drawn to Aswan’s tranquil vibe, both cities promise an unforgettable journey through Egypt’s past.',
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
                '1-Luxor:Explore the Valley of the Kings, where ancient pharaohs were laid to rest in elaborate tombs.Visit the Karnak Temple, an awe-inspiring complex dedicated to the god Amun-Ra.Marvel at the Temple of Queen Hatshepsut, a stunning mortuary temple carved into the cliffs.\n\n'
                '2-Aswan:Discover the Philae Temple, dedicated to the goddess Isis, on Agilkia Island.Admire the colossal statues at the Abu Simbel Temple, a testament to Ramses II’s grandeur.Immerse yourself in Nubian culture with a visit to a traditional Nubian Village.',
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
                'Some Experiences to enjoy your trip in Luxor and Aswan',
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
                '1-Cruise on the Nile:Sailing between Luxor and Aswan on the Nile River offers a relaxing and scenic experience.Explore ancient Egyptian temples and tombs during day tours from your Nile cruise.\n\n'
                '2-Karnak Temple (Luxor):The Temple of Karnak, the largest temple in Egypt, grew over time with different pharaohs’ modifications.Marvel at its grandeur and intricate architecture.\n\n'
                '3-The Luxor Temple (Luxor):Dedicated to the god Amun-Ra, the Luxor Temple stands in the heart of the city.Explore its buildings and facilities ordered by various pharaohs.\n\n'
                '4-The Valley of the Kings (Luxor):A unique necropolis carved into rock, where pharaohs were buried during the New Kingdom.Discover the tombs hidden within the mountains.\n\n'
                '5-Unfinished Obelisk (Aswan):Witness the massive unfinished obelisk, abandoned due to cracks.Learn about ancient quarrying techniques.\n\n'
                '6-Philae Temple (Aswan):Located on Agilkia Island, the Philae Temple is dedicated to the goddess Isis.Accessible by boat, it offers picturesque views.\n\n'
                '7-Abu Simbel Temple (Aswan):Ramses II’s twin temples stand as a testament to ancient engineering.Admire the colossal statues guarding the entrance.\n\n'
                '8-Nubian Village (Aswan):Take a boat ride to a traditional Nubian village along the Nile.Immerse yourself in Nubian culture and vibrant traditions.',
                style: TextStyle(
                  fontFamily: 'MadimiOne',
                  fontSize: 15,
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
