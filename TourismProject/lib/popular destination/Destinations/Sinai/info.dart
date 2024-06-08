import 'package:flutter/material.dart';
import 'package:new_project/popular%20destination/home_view.dart';
import './Specification.dart';

class SixthRoute extends StatefulWidget {
  @override
  _SixthRouteState createState() => _SixthRouteState();
}

class _SixthRouteState extends State<SixthRoute> {
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
            'Sinai',
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
                              'images/Sinai1.jpg',
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
                              'images/Sinai2.jpg',
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
                              'images/Sinai3.jpg',
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
                'About Sinai:',
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
                'Sinai is a peninsula in Egypt, uniquely situated in Asia between the Mediterranean Sea and the Red Sea It covers about 60,000 km² and serves as a land bridge between Asia and AfricaWith a rich history, Sinai has been part of Egypt since ancient times and has seen periods of foreign occupation,The region is known for Mount Sinai, a site of great religious importance in the Abrahamic faiths.',
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
                'Getting to Sinai',
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
                'Getting to Sinai Reaching the Sinai Peninsula from Cairo offers various travel options. You can take a bus or taxi directly, with the journey taking approximately 6-7 hours on the road due to the 500 kilometers distance. Alternatively, flights provide a quicker but more expensive route. For a comprehensive experience, joining a guided tour could be beneficial, combining the exploration of Ancient Egypt with the stunning landscapes of Sinai. It’s essential to stay updated with local news for any travel restrictions or security advisories when planning your trip.',
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
                'The best times to visit the Sinai Peninsula in Egypt for ideal weather are March 5th to June 3rd and September 24th to November 25th. During these periods, the temperatures are very pleasant, avoiding the extreme heat of summer and the cold of winter.',
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
                'St. Catherine\’s Monastery: This ancient monastery dates back to around AD 330 and was founded by Byzantine empress Helena. It includes a small chapel and a fortified refuge for local hermits.'
                'Mount Sinai (Gebel Musa): Revered by Christians, Muslims, and Jews, Mount Sinai is believed to be the place where God delivered the Ten Commandments to Moses. It’s a significant pilgrimage site.'
                'Blue Hole (Dahab): Carved into a reef, the Blue Hole is Egypt’s most infamous dive site. It\’s a gaping sinkhole that drops straight down, offering a unique underwater experience.'
                'aThistlegorm (Sharm El Sheikh): Ranked among the top five wreck dives globally, the Thistlegorm is a 129m-long cargo ship sunk during World War II. It’s a fascinating underwater exploration site.'
                'Ras Mohammed National Park: Located 20km west of Sharm El Sheikh, this park boasts spectacular coral reefs, including the famous Shark and Jolanda Reefs.'
                'Ras Um Sid (Sharm El Sheikh): A fantastic dive site featuring a gorgonian forest along a dramatic drop-off, hosting a variety of reef life.'
                'Thomas Reef (Sharm El Sheikh): Although the smallest of the Tiran reefs, Thomas Reef is spectacular, with steeply plunging walls adorned with soft coral and schooling fish.'
                'Dunraven (Sharm El Sheikh): The Dunraven wreck, sunk in 1876, lies encrusted in coral at the southeast tip of Sha’ab Mahmud. It’s a captivating underwater archaeological site.'
                'Shark & Jolanda Reefs (Ras Mohammed National Park): This two-for-one special dive off the southern tip of Ras Mohammed is famous for its vibrant marine life and stunning underwater landscapes.'
                'Steps of Repentance: An alternative path to Mount Sinai’s summit, the 3750 Steps of Repentance begin outside the southeastern corner of St. Catherine’s Monastery.',
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
                '1-Camel Trekking in the Desert: Explore the vast desert landscapes on a traditional camel ride. Witness the stunning sunrises and sunsets against the backdrop of rugged mountains and golden sands.\n\n'
                '2-Stargazing at Mount Sinai: Head to Mount Sinai (Gebel Musa) at night for an unforgettable stargazing experience. The clear desert skies offer breathtaking views of constellations and celestial wonders.\n\n'
                '3-Bedouin Tea and Hospitality: Connect with the local Bedouin community. Enjoy a cup of sweet Bedouin tea while listening to their stories and learning about their ancient way of life.\n\n'
                '4-Diving and Snorkeling in the Red Sea: The Red Sea is renowned for its vibrant coral reefs and diverse marine life. Dive or snorkel in crystal-clear waters to discover colorful fish, rays, and even shipwrecks.\n\n'
                '5-Visit the Colored Canyon: Take a guided hike through the Colored Canyon, known for its dramatic sandstone formations in various hues. The narrow passages and towering walls create a surreal landscape.\n\n'
                '6-Relax on the Beaches: Sinai boasts beautiful beaches along the Red Sea coast. Whether in Dahab, Sharm El Sheikh, or Nuweiba, unwind on soft sands, swim, and soak up the sun.\n\n'
                '7-Explore Dahab’s Laid-Back Vibe: Dahab is a chilled-out coastal town with a bohemian atmosphere. Enjoy beachfront cafes, yoga sessions, and windsurfing in the turquoise waters.\n\n'
                '8-Quad Biking in the Desert: Get your adrenaline pumping by renting a quad bike and exploring the desert dunes. It’s a thrilling way to experience the rugged terrain.\n\n'
                '9-Visit Nuweiba Oasis: Discover the lush oasis of Nuweiba, where freshwater springs meet the desert. Relax by the palm-fringed pools and enjoy the tranquility.\n\n'
                '10-Discover Ras Abu Galum: Accessible by camel or hiking, Ras Abu Galum is a secluded coastal area with pristine beaches, coral reefs, and a peaceful ambiance.\n\n',
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
