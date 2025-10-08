class UserProfileModel {
  final String userId;
  final String userEmail;
  final DateTime createdAt;

  UserProfileModel({
    required this.userId,
    required this.userEmail,
    required this.createdAt,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      userId: json['userId'],
      userEmail: json['userEmail'],
      createdAt: DateTime.parse(json['createdAt'])
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userEmail': userEmail,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}