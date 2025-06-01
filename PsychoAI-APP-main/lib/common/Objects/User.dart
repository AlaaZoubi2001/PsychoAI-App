class AppUser {
  String id;
  String email;
  String name;
  String password;
  String sex;
  String age;
  String points;
  String lastLogin;

  // Constructor
  AppUser({
    required this.id,
    required this.email,
    required this.password,
    required this.name,
    required this.sex,
    required this.age,
    required this.points,
    required this.lastLogin,
  });

  // Method to create a AppUser object from Firestore document snapshot
  factory AppUser.fromFirestore(Map<String, dynamic> data,uid) {
    return AppUser(
      id: uid ?? '',
      name: '${data["first_name"]} ${data["last_name"]}' ?? '',
      email: data['email'] ?? '',
      password: data['password'] ?? '',
      sex: data['sex'] ?? '',
      age: data['age'] ?? '',
      points: data['points'].toString() ?? '',
      lastLogin: (data['lastLogin'] as String),
    );
  }

  // Method to convert AppUser object to Firestore data
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'sex': sex,
      'age': age,
      'points': points,
      'lastLogin': lastLogin,
    };
  }
}
