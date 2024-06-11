import 'package:flutter/material.dart';

class landMark extends StatelessWidget {
  const landMark({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F1E7), // Set background color
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Landmarks',
          style: TextStyle(
            color:  Color.fromARGB(255, 121, 155, 228),
            fontWeight: FontWeight.bold,
            fontFamily: 'Madimi One',
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: 8,
        itemBuilder: (context, index) {
          List<String> imagePaths = [
            'images/pyramids.jpg',
            'images/alex library.jpg',
            'images/elkarnak.jpg',
            'images/saintcatherine.jpg',
            'images/abosimble.jpg',
            'images/siwa oasis.jpg',
            'images/philae temple.jpg',
            'images/khan elkhalely.jpg',
          ];

          List<String> texts = [
            'The Pyramids',
            'Alexandria Library',
            'El Karnak Temple',
            'Saint Catherine Monastery',
            'Abo Simble Temple',
            'Siwa Oasis',
            'Philae Temple',
            'Khan Elkhalely',
          ];

          List<String> additionalInfo = [
            'Welcome to the awe-inspiring Pyramids of Egypt ! Prepare to embark on a journey through time as you explore these ancient wonders. Standing proudly against the backdrop of the Egyptian desert, the pyramids represent the pinnacle of human ingenuity and architectural mastery Built thousands of years ago as tombs for the pharaohs, each pyramid holds within it secrets and stories of a bygone era. Marvel at the sheer scale of these monumental structures, constructed with meticulous precision using massive stone blocks.As you stand in the shadow of these ancient marvels, you will be transported back to a time of grandeur and splendor, where the mighty rulers of Egypt sought to immortalize themselves for eternity Join us on an unforgettable adventure as we unravel the mysteries of the pyramids, uncovering the secrets of one of the worlds most iconic historical sites.',
            'Welcome to the legendary Library of Alexandria! Nestled along the Mediterranean coast of Egypt, the Library of Alexandria stands as a beacon of knowledge and enlightenment. Reborn from the ashes of its ancient predecessor, this modern marvel pays homage to the illustrious history of its namesake. Step inside and immerse yourself in a world of boundless wisdom and scholarly pursuits. With its vast collection of books, manuscripts, and digital archives, the library serves as a hub for researchers, students, and curious minds from around the globe.Experience the spirit of intellectual curiosity that has thrived in Alexandria for centuries as you wander through its hallowed halls. From ancient scrolls to modern literature, the librarys diverse collections offer a glimpse into the rich tapestry of human thought and creativity.Join us on a journey of exploration and discovery as we celebrate the enduring legacy of the Library of Alexandria, a testament to the power of knowledge to transcend time and space.',
            'Welcome to the majestic Karnak Temple Complex! Situated on the eastern bank of the Nile River in Luxor, Egypt, the Karnak Temple stands as a testament to the grandeur and architectural prowess of ancient Egyptian civilization Step back in time as you walk through the towering pylons and majestic columns that adorn this sprawling complex. Dedicated to the god Amun, Karnak was the center of religious worship and political power during the New Kingdom period.Marvel at the intricately carved hieroglyphics and towering obelisks that adorn the temple grounds, each telling a story of the gods and pharaohs that once ruled this land.As you explore the Hypostyle Hall, with its forest of massive columns reaching towards the sky, you will be transported to a world of awe and wonder. Join us on a journey through the sands of time as we unravel the mysteries of Karnak Temple, a testament to the enduring legacy of one of historys greatest civilizations.',
            'Welcome to the ancient and revered SaintCatherines Monastery! Nestled in the rugged and awe-inspiring landscape of the Sinai Peninsula in Egypt, SaintCatherines Monastery stands as a beacon of spiritual devotion and cultural heritage. Founded in the 6th century AD, this UNESCO World Heritage site is one of the oldest functioning Christian monasteries in the world. Dedicated to SaintCatherine of Alexandria, a Christian martyr, the monastery has served as a place of worship, pilgrimage, and scholarly pursuit for over a millennium. Stepping through its fortified walls, visitors are transported to a realm of timeless beauty and religious significance. The monasters iconic architecture, adorned with ancient icons, frescoes, and religious artifacts, reflects centuries of Byzantine, Roman, and Islamic influences. At the heart of the monastery lies the Chapel of the Burning Bush, believed to be the site where Moses encountered the miraculous burning bush and received the divine revelation of the Ten Commandments Surrounded by the majestic peaks of Mount Sinai, SaintCatherines Monastery offers a sanctuary for spiritual reflection and contemplation amidst the rugged wilderness of the Sinai desert.Join us as we journey through the hallowed halls of SaintCatherines Monastery, exploring its rich history and profound spiritual legacy.',
            'Welcome to the awe-inspiring Abu Simbel Temple! Situated on the banks of Lake Nasser in southern Egypt, Abu Simbel is a testament to the grandeur and engineering prowess of ancient Egypt.Built during the reign of Pharaoh Ramses II in the 13th century BCE, this magnificent temple complex is dedicated to the gods Amun, Ra-Horakhty, and Ptah, as well as to the deified Ramses himself. The most striking feature of Abu Simbel is its colossal rock-cut statues of Ramses II, standing at over 20 meters tall, guarding the entrance to the temple. Inside, visitors are treated to stunning wall reliefs depicting scenes from Ramses military victories and religious ceremonies. Abu Simbels relocation in the 1960s to avoid flooding from the construction of the Aswan High Dam stands as a testament to modern engineering and international cooperation. Join us on a journey through time as we explore the majestic Abu Simbel Temple, an enduring symbol of Egypts ancient splendor and cultural heritage.',
            'Welcome to Siwa Oasis! Oasis, located in the heart of the Egyptian Western Desert, is a serene haven of natural beauty and cultural richness. Surrounded by stunning landscapes of palm groves, salt lakes, and sand dunes, Siwa offers visitors a unique retreat from the hustle and bustle of modern life. Renowned for its ancient history, including the Oracle Temple of Amun and the ruins of the Shali Fortress, Siwa is a treasure trove of archaeological wonders. Its Berber inhabitants, known for their warm hospitality and distinct cultural traditions, welcome travelers to immerse themselves in the tranquil ambiance of this oasis paradise. Whether exploring the mesmerizing desert scenery, indulging in the therapeutic waters of Cleopatras Bath, or simply enjoying the peaceful atmosphere, a visit to Siwa Oasis promises an unforgettable experience of beauty, history, and serenity.',
            'Welcome to the Philae Temple ,The Philae Temple, located on the island of Philae in the Nile River, is a stunning example of ancient Egyptian architecture and religious devotion. Dedicated primarily to the goddess Isis, it served as a center for worship for over a millennium. The temple complex features beautifully carved reliefs, towering columns, and picturesque courtyards, reflecting the artistic and spiritual achievements of ancient Egypt. Rescued from the rising waters of the Nile due to the construction of the Aswan High Dam, Philae Temple now stands on Agilkia Island, where visitors can marvel at its splendor and immerse themselves in the history and mythology of ancient Egypt.',
            'Welcome to Khan El-Khalili , Khan El-Khalili is a bustling bazaar district in the heart of historic Cairo, Egypt. Dating back to the 14th century, this vibrant marketplace has been a hub of commerce and culture for centuries. Visitors to Khan El-Khalili can explore winding alleys filled with shops selling everything from traditional crafts and spices to jewelry and souvenirs. The atmosphere is alive with the sounds of merchants haggling, the aroma of exotic spices, and the vibrant colors of textiles and trinkets. Khan El-Khalili offers a unique glimpse into Cairos rich history and heritage, making it a must-visit destination for travelers seeking an authentic Egyptian experience.',
          ];

          return Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Landmark(
              imagePath: imagePaths[index],
              title: texts[index],
              info: additionalInfo[index],
            ),
          );
        },
      ),
    );
  }
}

class Landmark extends StatefulWidget {
  final String imagePath;
  final String title;
  final String info;

  const Landmark({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.info,
  }) : super(key: key);

  @override
  _LandmarkState createState() => _LandmarkState();
}

class _LandmarkState extends State<Landmark> {
  bool showMore = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          showMore = !showMore;
        });
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  widget.imagePath,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      showMore = !showMore;
                    });
                  },
                  icon: Icon(
                    showMore ? Icons.expand_less : Icons.expand_more,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              widget.title,
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Madimi One',
              ),
            ),
          ),
          if (showMore)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                widget.info,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }
}