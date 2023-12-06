import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Import http package for API calls

class HistoryPage extends StatelessWidget {
   Future<List<HistoryItem>> fetchHistoryItems() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8000/image'));

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      Map<String, dynamic> responseData = json.decode(response.body);
      List<dynamic> dataList = responseData['data'][0]; // Access the nested list
      return dataList.map((item) => HistoryItem.fromJson(item)).toList();
    } else {
      // If the server did not return a 200 OK response,
      // throw an exception.
      throw Exception('Failed to load history items');
    }
  }

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('History')),
      body: FutureBuilder<List<HistoryItem>>(
        future: fetchHistoryItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Loading indicator while fetching data
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            // If the Future is complete, display the fetched data
            List<HistoryItem> historyList = snapshot.data!;
            return ListView.builder(
              itemCount: historyList.length,
              itemBuilder: (context, index) {
                final item = historyList[index];
                return ListTile(
                  title: Image.file(File(item.imagePath)),
                  subtitle: Text(item.locationInfo),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class HistoryItem {
  final String imagePath;
  final String locationInfo;

  HistoryItem({
    required this.imagePath,
    required this.locationInfo,
  });

  factory HistoryItem.fromJson(Map<String, dynamic> json) {
    return HistoryItem(
      imagePath: json['imagePath'],
      locationInfo: json['locationInfo'],
    );
  }

  Object? toJson() {}
}
