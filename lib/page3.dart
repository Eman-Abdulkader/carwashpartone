// 32130904 Eman Abdulkader & 32130947 Abeer Abou Soltaniyeh
import 'package:flutter/material.dart';

class Page3 extends StatelessWidget {
  final String name;
  final DateTime? selectedDate;
  final TimeOfDay? selectedTime;
  final String selectedCarType;
  final double carPrice;
  final String washType;
  final int customerNumber;

  const Page3({
    Key? key,
    required this.name,
    required this.selectedDate,
    required this.selectedTime,
    required this.selectedCarType,
    required this.carPrice,
    required this.washType,
    required this.customerNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(
              Icons.account_box,
              color: Colors.white,
            ),
            SizedBox(width: 8),
            Text(
              'Wash Details',
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
      body: Center(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black ,width: 5.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Welcome, $name!',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              if (selectedDate != null && selectedTime != null) ...[
                Text(
                  'Customer Number: $customerNumber',
                  style: const TextStyle(fontSize: 20),
                ),
                Text(
                  'Selected Date and Time:\n ${selectedDate!
                      .toLocal()} ${selectedTime!.format(context)}',
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 16),
                Text(
                  'Selected Car Type: $selectedCarType',
                  style: const TextStyle(fontSize: 20),
                ),
                Text(
                  'Wash Type: $washType',
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 16),
                Text(
                  'Wash Price: \$${carPrice.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 30),
                ),

              ],
              const SizedBox(height: 150),
              const Text(
                'Thank you for your visit!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 90),
              const Divider(
                height: 20,
                thickness: 2,
                color: Colors.black,
              ),
              const SizedBox(height: 8),
             const Text(
                'For more info contact us: +961 xxx xxx', // Replace XXX with the actual place number
                style: TextStyle(fontSize: 16),
              ),
             const Text(
                'Email: carwash@example.com', // Replace with the actual email
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),

        ),
      ),
    );
  }
}