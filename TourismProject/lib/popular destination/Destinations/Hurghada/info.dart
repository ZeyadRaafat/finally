import 'package:flutter/material.dart';
import 'package:new_project/popular%20destination/home_view.dart';
import './Specification.dart';





class FifthRoute extends StatefulWidget {
  @override
  _FifthRouteState createState() => _FifthRouteState();
}

class _FifthRouteState extends State<FifthRoute> {
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
          'Hurghada',
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
            Navigator.push(context, MaterialPageRoute(builder: (context) => HomeView(),)); // Implement the back button functionality
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
                          _toggleExpandedState(1); // Toggle image 1 expanded state
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          width: _isExpanded1 ? 300 : 200,
                          height: _isExpanded1 ? 300 : 150,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(
                              'images/hurghada1.jpg',
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
                          _toggleExpandedState(2); // Toggle image 2 expanded state
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          width: _isExpanded2 ? 300 : 200,
                          height: _isExpanded2 ? 300 : 150,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(
                              'images/hurghada2.jpg',
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
                          _toggleExpandedState(3); // Toggle image 3 expanded state
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          width: _isExpanded3 ? 300 : 200,
                          height: _isExpanded3 ? 300 : 150,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(
                              'images/hurghada3.jpg',
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
            SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              'About Hurghada:',
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
                'Hurghada: Once a humble fishing village, Hurghada now stands as a vibrant Red Sea resort. Its azure waters, sun-kissed beaches, and rich heritage beckon travelers seeking both relaxation and adventure.',
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
                'Getting to Hurghada',
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
                'Traveling to Hurghada: Hurghada, a stunning beach destination on the Red Sea coast, is accessible via the Hurghada International Airport, which welcomes flights from major cities worldwide. Visitors can also reach Hurghada by bus or car from other Egyptian cities, enjoying a scenic route through the desert landscape. Once in Hurghada, a variety of transportation options, including taxis and local buses, are available for exploring the city and its beautiful surroundings. Whether arriving by air or land, Hurghada promises an unforgettable getaway with its clear waters and vibrant marine life.',
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
                'Ideal Months: November to April offers pleasant weather with warm temperatures and low humidity. It\'s perfect for beach vacations and water activities.\n\n'
                'Shoulder Seasons: April, May, October, and November strike a balance between warmth and comfort. These months are great for a pleasant visit.',
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
                'A must-see attraction Must-See Attraction: “Sri Travel” enhances the travel experience by offering personalized attraction suggestions. Utilizing data and algorithms, the app recommends a variety of attractions, activities, and points of interest within each city or destination. These suggestions are designed to help users discover both hidden gems and popular spots, ensuring an enriched travel journey tailored to their preferences. Whether it’s a well-known museum or a secluded beach, “Sri Travel” aims to bring the best of each location to the traveler’s itinerary.',
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
                '1. Experience Stargazing in the Desert:Take a night tour through Hurghada’s Red Sea desert on a jeep safari.Enjoy the sunset and vast open space as you drive 25 kilometers into the desert.At a Bedouin camp, indulge in a barbecue buffet and gaze at the stars through a telescope with an astronomist guiding you\n\n'
                '2. Discover the Red Sea Underwater World:Board the Royal Seascope, a semi-submarine with a glass observation deck.Descend 3 meters below sea level to observe marine creatures swimming freely.Snorkel during a 20-minute stop and maybe even spot dolphins\n\n'
                '3. Explore Old Town Sahl Hasheesh:Stroll through the charming streets of Old Town Sahl Hasheesh.Discover local shops, cafes, and the laid-back atmosphere of this coastal gem.\n\n'
                '4. Visit Coptic Cairo: Explore the ancient churches and monasteries of Coptic Cairo, including the Hanging Church, the Church of St. Sergius and Bacchus, and the Coptic Museum. Learn about Egypt\'s Christian heritage and marvel at the beautiful architecture and religious artifacts.\n\n'
                '5. Quad Biking in the Desert:Get your adrenaline pumping with a quad biking adventure in the arid desert.Feel the thrill as you ride across the sandy landscape.\n\n',
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