// 32130904 Eman Abdulkader & 32130947 Abeer Abou Soltaniyeh
import 'package:flutter/material.dart';
import 'page3.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:math';

const String _baseURL = 'https://emanadulkader.000webhostapp.com';

EncryptedSharedPreferences _encryptedData = EncryptedSharedPreferences();

class Car {
  final String type;
  final double basePrice;
  String washType;

  Car(this.type, this.basePrice, this.washType);
}

List<Car> carTypes = [
  Car('Car 20\$', 20.0, 'Basic Wash'),
  Car('SUVs 30\$', 30.0, 'Basic Wash'),
  Car('Electric Car 50\$', 50.0, 'Basic Wash'),
  Car('Sport Car 40\$', 40.0, 'Basic Wash'),
  Car('Truck 60\$', 60.0, 'Basic Wash'),
  Car('Motorcycle 25\$', 25.0, 'Basic Wash'),
  Car('Bus 55\$', 55.0, 'Basic Wash'),
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
  Car _selectedCarType = carTypes[0];
  int _customerNumber = 0;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _controllerName = TextEditingController();

  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _generateRandomCustomerNumber();
  }

  void _generateRandomCustomerNumber() {
    Random random = Random();
    int min = 100000;
    int max = 999999;
    _customerNumber = min + random.nextInt(max - min + 1);

    print("Random _customerNumber: $_customerNumber");
  }

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
  }

  void update(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              _encryptedData.remove('mykey').then(
                    (success) => Navigator.of(context).pop(),
              );
            },
            icon: const Icon(Icons.logout),
          )
        ],
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
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
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
                    controller: _controllerName,
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
                          'Standard Wash +20\$',
                          'Premium Wash +40\$',
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
                      onPressed: _loading
                          ? null
                          : () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _loading = true;
                          });
                          saveCustomer(
                            update,
                            _controllerName.text.toString(),
                            int.parse(_customerNumber.toString()),
                            _selectedCarType.type.toString(),
                            _selectedCarType.washType.toString(),
                            _selectedDate,
                            _selectedTime,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        onPrimary: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: const Text('Submit'),
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
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
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        onPrimary: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
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
      ),
    );
  }
}

void saveCustomer(
    Function(String text) update,
    String name,
    int Cnumber,
    String CarType,
    String washType,
    DateTime? date,
    TimeOfDay? time,
    ) async {
  try {
    String mykey = await _encryptedData.getString('mykey');
    String formattedTime = time != null
        ? "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}"
        : "";

    final response = await http.post(
      Uri.parse('$_baseURL/add_Customer.php'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: convert.jsonEncode(<String, dynamic>{
        'c_id': Cnumber.toString(),
        'cname': name,
        'date': date?.toIso8601String(),
        'time': formattedTime,
        'washType': washType,
        'carType': CarType,
        'key': 'mykey',
      }),
    ).timeout(const Duration(seconds: 20));

    if (response.statusCode == 200) {
      update(response.body);
    }
  } catch (e) {
    update("connection error");
  }
}