import 'dart:convert';
import 'package:api_practise/model/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; //alias

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<User> users = [];

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
          final color = user.gender == 'male'? const Color.fromARGB(255, 196, 229, 244): Colors.white;

          //print(email); // Check if the URL is valid

          return ListTile(
            title: Text(user.name.first),
            subtitle: Text(user.phone),
            tileColor: color,
          );

        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchUsers,
      ),
    );
  }

  void fetchUsers() async{

    print('fetchUsers called');

    const url = 'https://randomuser.me/api/?results=100';
    final uri = Uri.parse(url);
    final response = await http.get(uri); // waiting for the response, until not recieved prog will not move fwd
    
    final body = response.body; // the response from the api will have many components like header, body etc..we want the body that appears on the browser screen
    final json = jsonDecode(body);//response will be in form of string, use json decode to parse the string and return it
    final results = json['results'] as List<dynamic>;

    final transformed = results.map((e) {
      final name = UserName( 
        title: e['name']['title'],
        first: e['name']['first'],
        last: e['name']['last'],
      );
      return User(
        cell: e['cell'],
        email: e['email'],
        gender: e['gender'],
        nat: e['nat'],
        phone: e['phone'],
        name: name,
      );
    }).toList();
    setState(() {
      users = transformed; // the key is results, like data array in the assignment, here we give the key
    });
    print('fetchUsers completed');

  }

}