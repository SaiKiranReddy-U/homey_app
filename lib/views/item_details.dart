import 'dart:io';
import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:readmore/readmore.dart';
import '../controllers/share_controller.dart';
import 'add_review_view.dart';
import 'reviews_scroll_container.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:homey_details_page_modifications/controllers/location_controller.dart';
import 'item_details_page_details_section.dart';
import 'item_details_page_property_images_carousel.dart';
import 'emi_calculator.dart';
import 'agent_view.dart';

class ItemDetails extends StatefulWidget {
  const ItemDetails(
      {super.key, required image, required label, required description});
  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  late double height, width;
  bool isFavorite = false;
  bool interested = false;
  bool compared = false;
  final List<bool> _isPressed = [false, false, false, false];
  final ShareController _shareController = ShareController();
  final ScrollController _scrollController = ScrollController();
  final Map<String, GlobalKey> _keys = {
    'Title': GlobalKey(),
    'Images': GlobalKey(),
    'Amenities': GlobalKey(),
    'About Property': GlobalKey(),
    'Details': GlobalKey(),
    'Compare': GlobalKey(),
    'Reviews': GlobalKey(),
  };
  String _currentSection = 'Title';
  bool _hideNavBar = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    setState(() {
      _hideNavBar = _scrollController.offset == 0;
    });

    // Determine the current section based on the scroll position
    for (String section in _keys.keys) {
      final context = _keys[section]?.currentContext;
      if (context != null) {
        final box = context.findRenderObject() as RenderBox;
        final offset = box.localToGlobal(Offset.zero).dy;

        if (offset <= 500 && offset + box.size.height > 500) {
          setState(() {
            _currentSection = section; // Update the current section
          });
          break;
        }
      }
    }
  }

  void _scrollToSection(String section) {
    final context = _keys[section]?.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }

  Widget buildNavigationItem({required String title, required GlobalKey key}) {
    return InkWell(
      onTap: () {
        setState(() {
          _currentSection =
              title; // Update the current section based on user touch
        });
        _scrollToSection(title); // Scroll to the selected section
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: _currentSection == title
                  ? Colors.blue
                  : Colors
                      .transparent, // Add underline only for the selected item
              width: 2.0,
            ),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: _currentSection == title
                ? Colors.blue
                : Colors.black, // Change font color based on the selected item
            fontWeight: _currentSection == title
                ? FontWeight.bold
                : FontWeight.normal, // Apply bold font for the selected item
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        elevation: 0.0,
        title: const Text(
          'Property',
          style: TextStyle(color: Colors.black), // Set text color to white
        ),
        iconTheme: const IconThemeData(
            color: Colors.black), // Set back icon color to white
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
                0, 0, 10, 0.0), // Adjust padding as needed
            child: IconButton(
              icon: const Icon(
                Icons.share,
                color: Colors.black,
                size: 30,
              ),
              onPressed: () async {
                // Your share logic here
                final byteData =
                    await rootBundle.load('assets/images/house_image_1.jpg');
                final tempDir = await getTemporaryDirectory();
                final file =
                    await File('${tempDir.path}/house_image_1.jpg').create();
                file.writeAsBytesSync(byteData.buffer.asUint8List());
                Share.shareFiles([file.path], text: 'Check out this image!');
              },
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Stack(
              children: [
                Image.asset(
                  'assets/images/house_image_7.jpg',
                  height: height * 0.43,
                  width: width,
                  fit: BoxFit.cover,
                ),
                Container(
                  margin: EdgeInsets.only(top: height * 0.4),
                  padding: const EdgeInsets.all(20.0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20.0)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // title
                      Row(
                        //key: titleKey,
                        key: _keys['Title'],
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: const Row(
                              children: [
                                Text(
                                  "Royal Villa",
                                  style: TextStyle(
                                    fontSize: 28.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'OpenSans',
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.location_on),
                                  iconSize: 25,
                                  color: Colors.blue,
                                  onPressed:
                                      openMap, // Set the onPressed function
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      // price and rating
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            //padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: const Row(
                              children: [
                                Text(
                                  "Price: ",
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                Text(
                                  "65,000",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'OpenSans',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  offset: const Offset(0, 3),
                                  blurRadius: 5,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: const Row(
                              children: [
                                Text(
                                  "4.2 ",
                                  style: TextStyle(
                                    fontSize: 20.0,
                                  ),
                                ),
                                Icon(
                                  Icons.star,
                                  size: 25,
                                  color: Colors.blue,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      //PropertyTour() images container,
                      Column(
                        //key: imagesKey,
                        key: _keys['Images'],
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0, 10.0, 0, 20.0),
                            child: Text(
                              'Tour this property: Images and videos',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.25,
                            child: CarouselSlider(
                              options: CarouselOptions(
                                height: 200.0,
                                enlargeCenterPage: true,
                                autoPlay: true,
                                aspectRatio: 16 / 9,
                                autoPlayCurve: Curves.fastOutSlowIn,
                                enableInfiniteScroll: true,
                                autoPlayAnimationDuration:
                                    const Duration(milliseconds: 800),
                                viewportFraction: 0.8,
                              ),
                              items: [
                                'assets/images/house_image_1.jpg',
                                'assets/images/house_image2.jpg',
                                'assets/images/house_image_3.jpg',
                                'assets/images/house_image_4.jpg',
                                'assets/images/house_image_5.jpg',
                                'assets/images/house_image_6.jpg',
                                'assets/images/house_image_7.jpg',
                              ].map((imagePath) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            20.0), // Same radius as container
                                        child: Image.asset(
                                          imagePath,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      // Amenities (features icons)
                      Column(
                        //key: amenitiesKey,
                        key: _keys['Amenities'],
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Amenities",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                          SingleChildScrollView(
                            padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                FacilityIcon(icon: Icons.home, label: 'Type'),
                                FacilityIcon(
                                    icon: Icons.people, label: 'Guest limit'),
                                FacilityIcon(icon: Icons.bed, label: 'Rooms'),
                                FacilityIcon(
                                    icon: Icons.directions_car,
                                    label: 'Parking'),
                                FacilityIcon(icon: Icons.wifi, label: 'Wifi'),
                                FacilityIcon(icon: Icons.pool, label: 'Pool'),
                                FacilityIcon(
                                    icon: Icons.security, label: 'Security'),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      //About property container
                      Container(
                        //key: aboutPropertyKey,
                        key: _keys['About Property'],
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "About property",
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'OpenSans',
                              ),
                            ),
                            SizedBox(height: 10.0),
                            ReadMoreText(
                              "Welcome to our exquisite villa hotel, where luxury meets tranquility. "
                              "Nestled amidst lush greenery and overlooking breathtaking vistas, our villa offers an unparalleled retreat for discerning travelers. "
                              "Step into a world of opulence and sophistication, where every detail is meticulously crafted to provide an unforgettable experience. "
                              "From elegantly furnished suites to world-class amenities, indulge in the ultimate in comfort and indulgence. "
                              "Immerse yourself in the serenity of our private gardens, rejuvenate your senses at our lavish spa, or savor gourmet delights at our fine dining restaurants. "
                              "Whether you seek relaxation or adventure, our villa hotel promises a haven of indulgence and refinement, where every moment is a celebration of luxury.",
                              trimLines: 3,
                              textAlign: TextAlign.justify,
                              colorClickableText: Colors.blue,
                              trimMode: TrimMode.Line,
                              trimCollapsedText: 'Read More',
                              trimExpandedText: 'Read Less',
                              moreStyle: TextStyle(
                                color: Colors.blue,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      //Details container
                      Container(
                        //key: detailsKey,
                        key: _keys['Details'],
                        child: DetailsPageDetailsSection(),
                      ),
                      const SizedBox(height: 20.0),
                      //compare container
                      Container(
                        //key: compareKey,
                        key: _keys['Compare'],
                        padding: const EdgeInsets.fromLTRB(10, 6, 10, 6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Row(
                          //crossAxisAlignment: CrossAxisAlignment.center ,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Left Container with two images
                            Row(
                              children: [
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 70.0,
                                          height: 80.0,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.asset(
                                              'assets/images/house_image_1.jpg',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10.0),
                                        // Space for the "vs" text
                                        Container(
                                          width: 70.0,
                                          height: 80.0,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Stack(
                                              fit: StackFit.expand,
                                              children: [
                                                Image.asset(
                                                  'assets/images/house_image_1.jpg',
                                                  fit: BoxFit.cover,
                                                ),
                                                BackdropFilter(
                                                  filter: ImageFilter.blur(
                                                      sigmaX: 8.0, sigmaY: 8.0),
                                                  child: Container(
                                                    color: Colors.black
                                                        .withOpacity(0),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Positioned(
                                      left: (120.0 / 2),
                                      // Adjust to align the "vs" text correctly
                                      child: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                          // Background color
                                          border: Border.all(
                                              color: Colors.black,
                                              width:
                                                  0.5), // Adjust color and width as needed
                                        ),
                                        padding: const EdgeInsets.all(8),
                                        // Adjust padding as needed
                                        child: const Text(
                                          'vs',
                                          style: TextStyle(
                                            fontSize:
                                                20, // Adjust size as needed
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            // Right Container with column of text fields and button
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Text(
                                    "Compare Properties",
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'OpenSans',
                                    ),
                                  ),
                                  const Text(
                                    "Add and compare",
                                    style: TextStyle(
                                      fontSize: 10.0,
                                      fontFamily: 'OpenSans',
                                    ),
                                  ),
                                  //const SizedBox(height: 8.0),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 8.0),
                                      backgroundColor: _isPressed[3]
                                          ? Colors.white
                                          : Colors.blue,
                                      // Background color
                                      foregroundColor: _isPressed[3]
                                          ? Colors.blue
                                          : Colors.white,
                                      // Text color
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      shadowColor:
                                          Colors.black.withOpacity(0.5),
                                      // Shadow color
                                      elevation: 5, // Elevation for the shadow
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _isPressed[3] = !_isPressed[3];
                                      });
                                    },
                                    child: Text(
                                      _isPressed[3]
                                          ? 'Added to compare'
                                          : 'Add to compare',
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      //Review heading, add review button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Reviews on this Property",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) => const ReviewContainer(),
                              );
                            },
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(
                                  Colors.blue), // Background color
                              foregroundColor: WidgetStateProperty.all(
                                  Colors.white), // Text color
                              shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      10.0), // Border radius
                                ),
                              ),
                              padding: WidgetStateProperty.all(
                                EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 10), // Slim down height
                              ),
                            ),
                            child: const Text('Add your review'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10.0),

                      // Reviews scroll container
                      Container(
                        //key: reviewsKey,
                        key: _keys['Reviews'],
                        child: const ReviewsScrollContainer(),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        child: EMICalculator(),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        child: AgentInformation(),
                      ),
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // buttons container displaying over the screen
          Positioned(
            top: height * 0.81, // Adjust as needed
            left: 2,
            right: 2,
            child: Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 0.5, vertical: 15.0),
              padding:
                  const EdgeInsets.symmetric(horizontal: 5.0, vertical: 6.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5), // Shadow color
                    spreadRadius: 5, // Spread radius
                    blurRadius: 7, // Blur radius
                    offset: const Offset(0, 3), // Offset in x and y directions
                  ),
                ],
                //border: Border.all(color: Colors.blue, width: 2.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 8.0),
                      backgroundColor:
                          _isPressed[0] ? Colors.blue : Colors.white,
                      foregroundColor:
                          _isPressed[0] ? Colors.white : Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        side: const BorderSide(color: Colors.blue),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _isPressed[0] = !_isPressed[0];
                      });
                    },
                    child: Text(_isPressed[0]
                        ? 'Marked Interested'
                        : 'Are you Interested?'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 2.0),
                      backgroundColor:
                          _isPressed[1] ? Colors.blue : Colors.white,
                      foregroundColor:
                          _isPressed[1] ? Colors.white : Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        side: const BorderSide(color: Colors.blue),
                      ),
                      fixedSize: const Size.fromHeight(40),
                    ),
                    onPressed: () {
                      setState(() {
                        _isPressed[1] = !_isPressed[1];
                      });
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _isPressed[1]
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: _isPressed[1] ? Colors.white : Colors.blue,
                        ),
                        const SizedBox(width: 8.0),
                        Text(
                            _isPressed[1] ? 'Saved property' : 'Save property'),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      fixedSize: const Size.fromHeight(40),
                    ),
                    onPressed: () {},
                    child: const Text('About Agent'),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: _hideNavBar ? 0.0 : 48.0,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(10.0), // Adjust the value as needed
                color: const Color(0xFFFFFFFF),
              ),
              child: Material(
                elevation: 4.0,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _keys.keys.map((String section) {
                      return InkWell(
                        onTap: () => _scrollToSection(section),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 12.0),
                          decoration: _currentSection == section
                              ? const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.blue,
                                      width: 2.0,
                                    ),
                                  ),
                                )
                              : null,
                          child: Text(
                            section,
                            style: TextStyle(
                              color: _currentSection == section
                                  ? Colors.blue
                                  : Colors.black,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<Directory> getTemporaryDirectory() async {
  return Directory.systemTemp;
}

class ImageContainer extends StatelessWidget {
  final String imageUrl;
  const ImageContainer({super.key, required this.imageUrl});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.0,
      height: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Image.asset(
        'assets/images/house_image_1.jpg',
        fit: BoxFit.cover,
      ),
    );
  }
}

class FacilityIcon extends StatelessWidget {
  final IconData icon;
  final String label;

  const FacilityIcon({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      height: 80,
      width: 88,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            offset: const Offset(0, 3),
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
      ),
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.blue),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(color: Colors.blueGrey)),
        ],
      ),
    );
  }
}
