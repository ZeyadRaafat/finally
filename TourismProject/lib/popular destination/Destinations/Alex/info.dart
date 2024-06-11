import 'package:flutter/material.dart';
import 'package:Guide/popular%20destination/home_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import './Specification.dart';

class SecRoute extends StatefulWidget {
  @override
  _SecRouteState createState() => _SecRouteState();
}

class _SecRouteState extends State<SecRoute> {
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
            'Alexandria',
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
            SizedBox(height: 10.h),
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
                          width: _isExpanded1 ? 300.w : 200.w,
                          height: _isExpanded1 ? 300.h : 150.h,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(
                              'images/alex1.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
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
                          width: _isExpanded2 ? 300.w : 200.w,
                          height: _isExpanded2 ? 300.h : 150.h,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(
                              'images/alex2.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
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
                          width: _isExpanded3 ? 300.w : 200.w,
                          height: _isExpanded3 ? 300.h : 150.h,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(
                              'images/alex3.jpg',
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
              height: 20.h,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                'About Alexandria:',
                style: TextStyle(
                  fontFamily: 'MadimiOne',
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Alexandria, Egypt, beckons tourists with its rich historical landmarks like the Bibliotheca Alexandrina and the Citadel of Qaitbay, offering glimpses into ancient civilizations. The city iss coastal allure is evident in its picturesque beaches and the serene Montazah Palace and Gardens. Cultural enthusiasts can explore museums and enjoy performances at the Alexandria Opera House. Food lovers will delight in the diverse culinary scene, while shoppers can peruse bustling markets or modern malls. With easy transportation options and nearby day trips to Rosetta and Abu Mena, Alexandria promises a vibrant blend of history, culture, and seaside charm for every traveler.',
                style: TextStyle(
                  fontFamily: 'MadimiOne',
                  fontSize: 15.sp,
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                'Getting to Alexandria',
                style: TextStyle(
                  fontFamily: 'MadimiOne',
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Getting to Alexandria is convenient due to its status as a major city in Egypt. Travelers can fly into Cairo International Airport (CAI) and then take a domestic flight to Borg El Arab Airport (HBE), located about 25 kilometers southwest of Alexandria. Alternatively, trains from Cairo to Alexandria offer a scenic journey of 2-3 hours, with Misr Station serving as the main train hub in Alexandria. Buses also provide a direct route from Cairo, with a travel time of approximately 3-4 hours. For those who prefer driving, the Desert Road offers a well-maintained highway connecting Cairo to Alexandria, with a driving time of around 2-3 hours. Upon arrival, taxis, buses, and trams are available for local transportation within the city, with taxis being the most convenient option. Many hotels and tourist sites offer shuttle services for added convenience.',
                style: TextStyle(
                  fontFamily: 'MadimiOne',
                  fontSize: 15.sp,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                'Best Time to visit',
                style: TextStyle(
                  fontFamily: 'MadimiOne',
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'The best time to visit Alexandria is during the spring (March to May) and autumn (September to November) months when the weather is mild and comfortable, making it ideal for exploring the city is outdoor attractions and cultural sites. During these seasons, temperatures are typically pleasant, ranging from around 20°C to 30°C (68°F to 86°F), with lower humidity levels compared to the hot and humid summer months. Additionally, tourist crowds tend to be smaller, allowing for a more enjoyable experience at popular landmarks and beaches. However, if you are a fan of cultural events, consider visiting during the summer months when Alexandria hosts various festivals and events, despite the higher temperatures. Overall, spring and autumn offer the most favorable conditions for a memorable visit to Alexandria.',
                style: TextStyle(
                  fontFamily: 'MadimiOne',
                  fontSize: 15.sp,
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                'Must-See Attraction',
                style: TextStyle(
                  fontFamily: 'MadimiOne',
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'A must-see attraction in Alexandria is the Bibliotheca Alexandrina, a modern library and cultural center built to commemorate the ancient Library of Alexandria. This iconic landmark is not only a repository of knowledge but also a stunning architectural marvel. Visitors can explore its vast collection of books, manuscripts, and artifacts, as well as enjoy exhibitions, lectures, and cultural events. The library is striking design, with its tilted roof and expansive glass facade overlooking the Mediterranean Sea, is a sight to behold. Additionally, the Bibliotheca Alexandrina houses several museums, including the Antiquities Museum and the Manuscript Museum, offering insight into Egypt is rich history and heritage. Whether you are a book lover, history enthusiast, or simply appreciate beautiful architecture, the Bibliotheca Alexandrina is a must-visit destination that encapsulates the spirit of Alexandria is intellectual and cultural legacy.',
                style: TextStyle(
                  fontFamily: 'MadimiOne',
                  fontSize: 15.sp,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                'Some Experiences to enjoy your trip in Alexandria',
                style: TextStyle(
                  fontFamily: 'MadimiOne',
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                '1. Explore Ancient Ruins: Wander through the ancient ruins of the Roman Amphitheater, Catacombs of Kom el Shoqafa, and Pompey\'s Pillar to immerse yourself in the city\'s rich history.\n\n'
                '2. Relax on the Beach\: Spend a leisurely day soaking up the sun and swimming at one of Alexandria\'s beautiful beaches, such as Maamoura Beach or Montazah Beach.\n\n'
                '3. Savor Egyptian Cuisine: Indulge in delicious Egyptian cuisine at local restaurants and street food stalls. Don\'t miss out on trying traditional dishes like koshari, falafel, and fresh seafood by the waterfront.\n\n'
                '4. Take a Boat Ride: Enjoy a boat ride along the Mediterranean coast for stunning views of Alexandria\'s skyline and landmarks, including the Citadel of Qaitbay and the Bibliotheca Alexandrina.\n\n'
                '5. Visit Museums and Art Galleries: Immerse yourself in Alexandria\'s cultural scene by visiting museums like the Alexandria National Museum and art galleries showcasing contemporary Egyptian art.\n\n'
                '6. Stroll Along the Corniche: Take a leisurely stroll along the Corniche, Alexandria\'s picturesque waterfront promenade, and soak in the sea breeze while admiring the views of the Mediterranean Sea.\n\n'
                '7. Explore Local Markets: Get lost in the bustling souks and markets of Alexandria, such as Souq El Attarine and Souq El Gomrok, where you can shop for souvenirs, spices, textiles, and handicrafts.\n\n'
                '8. Attend Cultural Events: Check out the calendar of events for concerts, festivals, and performances happening in Alexandria during your visit to experience the city\'s vibrant cultural scene.\n\n'
                'By immersing yourself in these experiences, you\'ll be able to fully enjoy your trip to Alexandria and create lasting memories of this enchanting city.',
                style: TextStyle(
                  fontFamily: 'MadimiOne',
                  fontSize: 15.sp,
                ),
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
