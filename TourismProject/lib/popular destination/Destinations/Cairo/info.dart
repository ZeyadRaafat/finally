import 'package:flutter/material.dart';
import 'package:new_project/popular%20destination/home_view.dart';
import './Specification.dart';





class FirstRoute extends StatefulWidget {
  @override
  _FirstRouteState createState() => _FirstRouteState();
}

class _FirstRouteState extends State<FirstRoute> {
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
          'Cairo',
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
                              'images/cairo1.jpg',
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
                              'images/cairo2.jpg',
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
                              'images/cairo3.jpg',
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
              'About Cairo:',
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
                'The discovery of Cairo, one of the world\'s oldest cities, is a testament to human ingenuity and historical significance. Located on the banks of the Nile, Cairo\'s roots stretch back over 1,000 years BCE, evolving into a vibrant metropolis that has witnessed the rise and fall of empires, the spread of cultures, and the shaping of civilizations. Its rich tapestry of history, from the Pharaonic era to Islamic conquests and beyond, makes Cairo a captivating mosaic of antiquity and modernity, beckoning explorers and historians alike to unravel its mysteries and embrace its timeless allure.',
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
                'Getting to Cairo',
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
                'Getting to Cairo is easy via Cairo International Airport, major highways, railways, or Nile River cruises, offering access to millennia of history and culture.',
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
                'The best time to visit Cairo is during the cooler months of October to April, when temperatures are milder and more comfortable for exploring the city\'s attractions. This period also coincides with the peak tourist season, offering clear skies and ideal conditions for sightseeing and outdoor activities. However, travelers should be mindful of larger crowds and higher prices during this time.',
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
                'A must-see attraction in Cairo is the Giza Necropolis, home to the iconic Great Pyramid of Giza, one of the Seven Wonders of the Ancient World, along with the enigmatic Sphinx and other ancient pyramids. This archaeological complex offers a glimpse into ancient Egyptian civilization and is a testament to human ingenuity and architectural mastery.',
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
                'Some Experiences to enjoy your trip in Cairo',
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
                '1. Explore the Pyramids of Giza: Start your journey with a visit to the iconic Pyramids of Giza, including the Great Pyramid and the Sphinx. Marvel at these ancient wonders and learn about the fascinating history of ancient Egypt.\n\n'
                '2. Discover Egyptian Museum: Immerse yourself in Egypt\'s rich history at the Egyptian Museum in Tahrir Square. Admire the vast collection of artifacts, including the treasures of Tutankhamun, mummies, and ancient artifacts spanning thousands of years.\n\n'
                '3. Wander through Old Cairo: Take a stroll through the narrow streets of Old Cairo, also known as Islamic Cairo, and discover historic landmarks such as the Sultan Hassan Mosque, Al-Azhar Mosque, and the Khan El Khalili Bazaar. Lose yourself in the bustling souks filled with colorful textiles, spices, and handicrafts.\n\n'
                '4. Visit Coptic Cairo: Explore the ancient churches and monasteries of Coptic Cairo, including the Hanging Church, the Church of St. Sergius and Bacchus, and the Coptic Museum. Learn about Egypt\'s Christian heritage and marvel at the beautiful architecture and religious artifacts.\n\n'
                '5. Cruise the Nile River: Experience the magic of the Nile River with a relaxing cruise aboard a felucca or a luxurious dinner cruise. Enjoy stunning views of Cairo\'s skyline and iconic landmarks as you sail along the river at sunset.\n\n'
                '6. Sample Egyptian Cuisine: Indulge in the flavors of Egypt with a culinary adventure through Cairo\'s bustling street food markets and authentic eateries. Don\'t miss out on classic dishes like koshari, falafel, and shawarma, as well as delicious sweets like baklava and kunafa.\n\n'
                '7. Enjoy Modern Cairo: Explore the modern side of Cairo in neighborhoods like Zamalek and Downtown. Visit contemporary art galleries, trendy cafes, and upscale boutiques, and experience the vibrant nightlife scene with rooftop bars and live music venues.\n\n'
                '8. Day Trip to Memphis and Saqqara: Take a day trip from Cairo to explore the ancient capital of Memphis and the necropolis of Saqqara. Marvel at the colossal statues and ruins of Memphis, and visit the Step Pyramid of Djoser, the oldest stone pyramid in Egypt, in Saqqara.\n\n'
                'With its blend of ancient wonders, vibrant culture, and modern amenities, Cairo offers an unforgettable experience for tourists seeking to explore the treasures of Egypt.',
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