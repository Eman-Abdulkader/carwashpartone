// 32130904 Eman Abdulkader & 32130947 Abeer Abou Soltaniyeh
import 'package:flutter/material.dart';
import 'getCustomer.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _load = false;
  Future<void> updateCustomers(Function(bool success) callback) async {
    await Future.delayed(const Duration(seconds: 2));
    bool success = true;
    callback(success);
  }

  void update(bool success) {
    setState(() {
      _load = false;
      if (!success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to load data')),
        );
      }
    });
  }

  @override
  void initState() {
    updateCustomers((success) => update(success));
    super.initState();
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
              'Available Products',
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

      body: _load
          ? const ShowCustomers()
          : const Center(
        child: SizedBox(
          width: 100,
          height: 100,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}