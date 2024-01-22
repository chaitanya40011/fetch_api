import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class ApiCall extends StatefulWidget {
  const ApiCall({Key? key}) : super(key: key);

  @override
  State<ApiCall> createState() => ApiCallState();
}

class ApiCallState extends State<ApiCall>{



  Future<Map<String, dynamic>> fetchData() async {
    final url = Uri.parse('https://reqres.in/api/users/2');
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      return Map<String, dynamic>.from(json.decode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('API Data Display'),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              FutureBuilder(
                future: fetchData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    var userData = snapshot.data?['data'];
                    return ListView(
                      shrinkWrap: true,
                      children: [
                        ListTile(
                          leading: Icon(Icons.person),
                          title: Text('ID: ${userData['id']}'),
                          subtitle: Text('Email: ${userData['email']}'),
                        ),
                        ListTile(

                          title: Text('First Name: ${userData['first_name']}'),
                          subtitle: Text('Last Name: ${userData['last_name']}'),
                        ),
                        ListTile(

                          title: Text('Avatar URL: ${userData['avatar']}'),
                        ),
                      ],
                    );
                  } else {
                    return const Text('No data available.');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
  }

