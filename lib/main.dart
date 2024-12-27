import 'dart:io';
import 'dart:ui';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:homey_details_page_modifications/views/item_details.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<Map<String, String>> images = [
    {
      'image': 'assets/images/house_image_1.jpg',
      'label': 'Royal Villa',
      'description': 'This is a beautiful house image.',
    },
    {
      'image': 'assets/images/house_image2.jpg',
      'label': 'House Image 2',
      'description': 'A cozy house with a lovely garden.',
    },
    {
      'image': 'assets/images/house_image_3.jpg',
      'label': 'House Image 3',
      'description': 'A modern house in the city center.',
    },
    {
      'image': 'assets/images/house_image_4.jpg',
      'label': 'House Image 4',
      'description': 'A modern house in the city center.',
    },
    {
      'image': 'assets/images/house_image_4.jpg',
      'label': 'House Image 5',
      'description': 'A modern house in the city center.',
    },
    {
      'image': 'assets/images/house_image_6.jpg',
      'label': 'House Image 6',
      'description': 'A modern house in the city center.',
    },
    {
      'image': 'assets/images/house_image_7.jpg',
      'label': 'House Image 7',
      'description': 'A modern house in the city center.',
    },

    // Add more items as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Properties List"),
        centerTitle: true,
        backgroundColor: const Color(0XFF3270FC),
        foregroundColor: Color.fromARGB(255, 253, 253, 254),
        actions: [
          IconButton(
            icon: Icon(Icons.search,
                color: const Color.fromARGB(221, 249, 249, 249)),
            onPressed: () {
              // Add search functionality here
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert,
                color: const Color.fromARGB(221, 254, 253, 253)),
            onPressed: () {
              // Add more options functionality here
            },
          ),
        ],
        leading: IconButton(
          icon: Icon(Icons.menu, color: Color.fromARGB(221, 251, 250, 250)),
          onPressed: () {
            // Add menu functionality here
          },
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            mainAxisExtent: 280, // Controls overall card height
          ),
          itemCount: images.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ItemDetails(
                      image: images[index]['image']!,
                      label: images[index]['label']!,
                      description: images[index]['description']!,
                    ),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    ),
                  ],
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey[200],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: images[index]['image']!.endsWith('.svg')
                            ? SvgPicture.asset(
                                images[index]['image']!,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                images[index]['image']!,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            images[index]['label']!,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            images[index]['description']!,
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 10),
                          Container(
                            width: 100,
                            height: 25,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Color(0XFF3270FC),
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ItemDetails(
                                      image: images[index]['image']!,
                                      label: images[index]['label']!,
                                      description: images[index]
                                          ['description']!,
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                'View Details',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
