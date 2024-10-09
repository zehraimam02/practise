import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; //alias

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> users = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rest API Call'),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context,index){
          final user = users[index];
          final name = user['name']['first'];
          final email = user['email'];
          final imageUrl = user['picture']['thumbnail'];

          print(imageUrl); // Check if the URL is valid
          return ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.network(
                imageUrl,
                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child; // Image loaded successfully
                  } else {
                    return const CircularProgressIndicator(); // Placeholder while loading
                  }
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.error); // Show an error icon if the image fails to load
                },
              ),
            ),

            title: Text(name),
            subtitle: Text(email),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchUsers,
      ),
    );
  }

  void fetchUsers() async{
    const url = 'https://randomuser.me/api/?results=100';
    final uri = Uri.parse(url);
    final response = await http.get(uri); // waiting for the response, until not recieved prog will not move fwd
    final body = response.body; // the response from the api will have many components like header, body etc..we want the body that appears on the browser screen
    final json = jsonDecode(body);//response will be in form of string, use json decode to parse the string and return it
    setState(() {
      users = json['results']; // the key is results, like data array in the assignment, here we give the key
    });
  }
}