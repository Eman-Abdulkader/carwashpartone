// 32130904 Eman Abdulkader & 32130947 Abeer Abou Soltaniyeh
import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const String _baseURL = 'https://emanadulkader.000webhostapp.com';

class Customer {
  int cId;
  String cname;
  DateTime date;
  TimeOfDay time;
  String washType;
  String carType;

  Customer(this.cId, this.cname, this.date, this.time, this.washType, this.carType);

  @override
  String toString() {
    return 'CID: $cId Name: $cname Date: $date Time: $time Wash Type: $washType Car Type: $carType';
  }
}

List<Customer> _customers = [];

void updateCustomers(Function(bool success) update) async {
  try {
    final url = Uri.https(_baseURL, 'get_Customers.php');
    final response = await http.get(url).timeout(const Duration(seconds: 5));

    _customers.clear();

    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);

      for (var row in jsonResponse) {
        Customer c = Customer(
          int.parse(row['c_id']),
          row['cname'],
          DateTime.parse(row['date']),
          _parseTimeOfDay(row['time']),
          row['washType'],
          row['carType'],
        );

        _customers.add(c);
      }

      update(true);
    }
  } catch (e) {
    update(false);
  }
}


TimeOfDay _parseTimeOfDay(String timeString) {
  List<String> parts = timeString.split(':');
  return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
}

class ShowCustomers extends StatelessWidget {
  const ShowCustomers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return ListView.builder(
      itemCount: _customers.length,
      itemBuilder: (context, index) {
        return Column(children: [
          const SizedBox(height: 5),
          Row(children: [
            SizedBox(width: width * 0.3),
            SizedBox(
              width: width * 0.5,
              child: Flexible(
                child: Text(
                  _customers[index].toString(),
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
          ]),
          const SizedBox(height: 5)
        ]);
      },
    );
  }
}