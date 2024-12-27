import 'package:flutter/material.dart';

class ReviewContainer extends StatefulWidget {
  const ReviewContainer({super.key});

  @override
  _ReviewContainerState createState() => _ReviewContainerState();
}

class _ReviewContainerState extends State<ReviewContainer> {
  int _rating = 0; // Holds the current rating value

  // Method to build stars based on the current rating
  Widget _buildStar(int index) {
    IconData icon;
    Color color;

    if (index < _rating) {
      icon = Icons.star;
      color = Colors.blue;
    } else {
      icon = Icons.star_border;
      color = Colors.blueGrey;
    }

    return IconButton(
      icon: Icon(icon, color: color),
      onPressed: () {
        setState(() {
          _rating = index + 1; // Update the rating value
        });
      },
      iconSize: 36.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(25.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // Changes position of shadow
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Add your Review',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person, color: Colors.blue),
                hintText: 'Your Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            const TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email, color: Colors.blue),
                hintText: 'Your Email id',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              maxLines: null,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.message, color: Colors.blue),
                hintText: 'Describe your experience',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Rate this ",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) => _buildStar(index)),
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                          Colors.blue), // Background color of the button
                      foregroundColor: WidgetStateProperty.all(
                          Colors.white), // Text color of the button
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              5.0), // Border radius of the button
                        ),
                      ),
                    ),
                    child: const Text("Submit Review"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
