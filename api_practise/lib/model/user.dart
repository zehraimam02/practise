class User{

  final String gender;
  final String email;
  final String phone;
  final String cell;
  final String nat;
  final UserName name; 
  //final UserDob dob;

  User({
    required this.gender,
    required this.email,
    required this.phone,
    required this.cell,
    required this.nat,
    required this.name,
    //required this.dob,
  });

  // Factory constructor for user
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      cell: json['cell'],
      email: json['email'],
      gender: json['gender'],
      nat: json['nat'],
      phone: json['phone'],
      name: UserName.fromJson(json['name']),
      //dob: UserDob.fromJson(json['dob']),
    );
  }

}


class UserName {
  final String title;
  final String first;
  final String last;

  UserName({
    required this.title,
    required this.first,
    required this.last,
  });

  // Factory constructor
  factory UserName.fromJson(Map<String, dynamic> json) {
    return UserName( 
      title: json['title'],
      first: json['first'],
      last: json['last'],
      );
  }

  String get fullName{
    return '${this.title} ${this.first} ${this.last}';
  }
}

class UserDob {
  final DateTime date;
  final int age;

  UserDob({
    required this.age,
    required this.date,
    
  });

  // Factory constructor
  // factory UserDob.fromJson(Map<String, dynamic> json) {
  //   return UserDob(
  //     age: json['age'], 
  //     date: DateTime.parse(json['data']),
  //   );
  // }

}

// class UserLocation {
//   final String city;
//   final String state;
//   final String country;
//   final String postcode;//3:45
// }