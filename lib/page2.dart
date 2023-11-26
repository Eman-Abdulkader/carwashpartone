// 32130904 Eman Abdulkader & 32130947 Abeer Abou Soltaniyeh
import 'package:flutter/material.dart';
import 'page3.dart';

class Car {
  final String type;
  final double basePrice;
  bool selected = false;
  String washType; // Separate wash type for each car type

  Car(this.type, this.basePrice, this.washType);
}

List<Car> carTypes = [
  Car('Car', 20.0, 'Basic Wash'),
  Car('SUVs', 30.0, 'Basic Wash'),
  Car('Electric Car', 50.0, 'Basic Wash'),
  Car('Sport Car', 40.0, 'Basic Wash'),
  Car('Truck', 60.0, 'Basic Wash'),
  Car('Motorcycle', 25.0, 'Basic Wash'),
  Car('Bus', 55.0, 'Basic Wash'),
];

class Page2 extends StatefulWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  String _text = '';
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  Car _selectedCarType = carTypes[0]; // Default car type
  int _customerNumber = 1; // Initial customer number

  // Controllers for text fields
  TextEditingController nameController = TextEditingController();
  TextEditingController carTypeController = TextEditingController();
  TextEditingController washTypeController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  void updateText(String text) {
    setState(() {
      _text = text;
    });
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        dateController.text = picked.toString(); // Set date controller text
      });
    }
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void openPage3() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Page3(
          name: _text,
          selectedDate: _selectedDate,
          selectedTime: _selectedTime,
          selectedCarType: _selectedCarType.type,
          carPrice: calculateTotalPrice(),
          washType: _selectedCarType.washType,
          customerNumber: _customerNumber,
        ),
      ),
    );

    setState(() {
      _customerNumber++;
      clearFields(); // Call clearFields after navigating to Page3
    });
  }

  double calculateTotalPrice() {
    double basePrice = _selectedCarType.basePrice;
    switch (_selectedCarType.washType) {
      case 'Basic Wash':
        return basePrice;
      case 'Standard Wash':
        return basePrice + 20.0;
      case 'Premium Wash':
        return basePrice + 40.0;
      default:
        return basePrice;
    }
  }

  void clearFields() {
    nameController.clear();
    carTypeController.clear();
    washTypeController.clear();
    dateController.clear();
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
              'Personalize Your Wash',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
        centerTitle: false,
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 10),
              const Text(
                'Enter Your name:',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: 300,
                child: TextField(
                  controller: nameController,
                  style: const TextStyle(fontSize: 18.0, color: Colors.black),
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Your Name',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                  ),
                  onChanged: (text) {
                    updateText(text);
                  },
                ),
              ),
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: const Text(
                  'Wash Types:\n'
                      'Basic Car Wash: Exterior wash, drying, tire cleaning\n'
                      'Standard Car Wash: Exterior wash, drying, tire cleaning\n'
                      'Premium Car Wash: All standard services plus interior detailing plus Gas fill\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    height: 1.5,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    const Text(
                      'Select Car Type:',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Move the loop outside the Column
                    for (var carType in carTypes)
                      RadioListTile<Car>(
                        title: Text(carType.type),
                        value: carType,
                        groupValue: _selectedCarType,
                        onChanged: (value) {
                          setState(() {
                            _selectedCarType = value!;
                          });
                        },
                      ),
                    // Add the wash type DropdownButton outside the loop
                    const SizedBox(height: 10),
                    const SizedBox(height: 10),
                    const Text(
                      'Select Wash Type:',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 10),
                    DropdownButton<String>(
                      value: _selectedCarType.washType,
                      onChanged: (value) {
                        setState(() {
                          _selectedCarType.washType = value!;
                        });
                      },
                      items: [
                        'Basic Wash',
                        'Standard Wash',
                        'Premium Wash',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {

                      clearFields();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      onPrimary: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child:  const Icon(
                      Icons.delete_forever,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () async {
                      await _selectDate();
                      await _selectTime();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      onPrimary: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Icon(
                      Icons.calendar_month_rounded,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      openPage3();
                      clearFields();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      onPrimary: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Icon(
                      Icons.navigate_next,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

            ],
          ),
        ),
      ),
    );
  }
}