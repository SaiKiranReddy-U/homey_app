import 'package:flutter/material.dart';

class ReviewsScrollContainer extends StatefulWidget {
  const ReviewsScrollContainer({super.key});

  @override
  State<ReviewsScrollContainer> createState() => _ReviewsScrollContainerState();
}

class _ReviewsScrollContainerState extends State<ReviewsScrollContainer> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220, // Adjust the height as per your design
      child: Stack(
        children: [
          Positioned.fill(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                reviewContainer(),
                reviewContainer(),
                reviewContainer(),
                reviewContainer(),
                reviewContainer(),
                reviewContainer(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget reviewContainer() {
    return Container(
      width: 300, // Adjust the width as per your design
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage(
                    'assets/images/profile_default_1.jpg'), // Default profile picture
                radius: 20,
              ),
              const SizedBox(width: 10),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Reviewer Name',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Posted on: 01 Jan 2024'),
                ],
              ),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Row(
                  children: [
                    Text('5.0',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white)),
                    SizedBox(width: 5),
                    Icon(Icons.star, color: Colors.white, size: 16),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text('Review:', style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(
            child: SingleChildScrollView(
              //padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
              child: Text(
                'This is a default review text. It provides a few lines of text to represent the review content.Houses come in a myriad of shapes, sizes, and styles, each offering a unique charm and character. From cozy cottages nestled in the countryside to towering skyscrapers in bustling urban centers, every house tells a story. The architecture of a house often reflects the culture and history of its location, with details like gabled roofs, ornate facades, or sleek modern lines. Inside, homes provide a sanctuary from the world, a place where families gather to create memories, and individuals find comfort and solace. Whether its a quaint farmhouse with a wraparound porch, a sleek minimalist apartment, or a grand Victorian mansion, houses are more than just structures; they are the heart of daily life, offering warmth, security, and a sense of belonging.',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: Colors.grey[700],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: const Text('Reviews')),
      body: const ReviewsScrollContainer(),
    ),
  ));
}
