// 32130904 Eman Abdulkader & 32130947 Abeer Abou Soltaniyeh
import 'package:flutter/material.dart';
import 'page2.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void openPage2() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const Page2(),
      ),
    );
  }

  // Reviews
  String _text = '';
  void updateText(String text) {
    setState(() {
      _text = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(
              Icons.directions_car,
              color: Colors.white,
            ),
            SizedBox(width: 8),
            Text(
              'Car Wash',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ],
        ),
        centerTitle: false,
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 50),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey[300]!,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: const Image(
                    image: AssetImage('assets/image1.jpeg'),
                    height: 200,
                    width: 300,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Welcome to Our Elegant Car Wash',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: openPage2,
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                  onPrimary: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text(
                  'Explore Services',
                  style: TextStyle(fontSize: 18),
                ),
              ),

              // Reviews
              const SizedBox(height: 100),
              Text(
                'Customer Reviews: $_text',
                style: const TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: 300,
                child: TextField(
                  style: const TextStyle(fontSize: 18.0, color: Colors.black),
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Add Your Reviews',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                  ),
                  onChanged: (text) {
                    updateText(text);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}