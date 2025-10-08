class UserProfileModel {
  final String userId;
  final String username;
  final int age;

  UserProfileModel({
    required this.userId,
    required this.username,
    required this.age,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      userId: json['userId'],
      username: json['username'],
      age: json['age'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'username': username,
      'age': age,
    };
  }
}